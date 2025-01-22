import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/auth/config_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this.authRepository) : super(const ForgotPasswordState()) {
    on<SendForgotOtp>(_sendPhoneNumber);
    on<VerifyForgotOtpEvent>(_verifyOtpEvent);
    on<OnChangedVisible>(_onChangedVisible);
    on<GetConfigForgotEvent>(_getConfig);
  }

  final AuthRepository authRepository;

  Future<void> _sendPhoneNumber(SendForgotOtp event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await authRepository.sendForgotOtp(phone: event.phone.toString());

    result.fold(
      (l) => emit(state.copyWith(apiStatus: ApiStatus.error, message: (l as ServerFailure).message)),
      (r) => emit(state.copyWith(apiStatus: ApiStatus.success)),
    );
  }

  Future<void> _verifyOtpEvent(VerifyForgotOtpEvent event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(state.copyWith(otpApiStatus: ApiStatus.loading));
      final result = await authRepository.verifyForgotOtp(
        phone: event.phone,
        password: event.password,
        code: event.code,
      );
      result.fold(
        (l) => emit(state.copyWith(otpApiStatus: ApiStatus.error, message: (l as ServerFailure).message)),
        (r) => emit(state.copyWith(otpApiStatus: ApiStatus.success)),
      );
    } catch (e) {
      emit(state.copyWith(otpApiStatus: ApiStatus.error));
    }
  }

  void _onChangedVisible(OnChangedVisible event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(isShow: !state.isShow));
  }

  Future<void> _getConfig(GetConfigForgotEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(configApiStatus: ApiStatus.loading));
    final result = await authRepository.getConfig();

    result.fold(
      (failure) => emit(state.copyWith(configApiStatus: ApiStatus.error)),
      (config) {
        emit(state.copyWith(configApiStatus: ApiStatus.success, config: config));
        Future.delayed(
          Duration(seconds: 2),
          () async {
            Uri? uri = Uri.parse('${config.telegramBot?.url}?start=998${event.login}');
            debugPrint(uri.toString());
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
        );
      },
    );
  }
}
