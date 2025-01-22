import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/auth/config_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(this.authRepository) : super(const OtpState()) {
    on<GetConfigEvent>(_getConfig);
    on<SendOtpEvent>(_sendOtp);
    on<OtpConfirmEvent>(_otpConfirm);
  }

  final AuthRepository authRepository;

  Future<void> _getConfig(GetConfigEvent event, Emitter<OtpState> emit) async {
    emit(state.copyWith(configApiStatus: ApiStatus.loading));
    final result = await authRepository.getConfig();

    result.fold(
      (failure) => emit(state.copyWith(configApiStatus: ApiStatus.error)),
      (config) {
        emit(state.copyWith(configApiStatus: ApiStatus.success, config: config));
        Future.delayed(
          Duration(seconds: 2),
          () async {
            Uri? uri = Uri.parse("${config.telegramBot?.url ?? ''}?start=${localSource.userId}");

            debugPrint('bot url -> $uri');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
        );
      },
    );
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<OtpState> emit) async {
    emit(state.copyWith(sendOtpApiStatus: ApiStatus.loading));
    final result = await authRepository.sendOtp();

    result.fold(
      (failure) => emit(state.copyWith(sendOtpApiStatus: ApiStatus.error)),
      (config) => emit(state.copyWith(sendOtpApiStatus: ApiStatus.success)),
    );
  }

  Future<void> _otpConfirm(OtpConfirmEvent event, Emitter<OtpState> emit) async {
    emit(state.copyWith(otpApiStatus: ApiStatus.loading));
    final result = await authRepository.otpConfirm(code: event.code);

    result.fold(
      (failure) => emit(state.copyWith(otpApiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (config) => emit(state.copyWith(otpApiStatus: ApiStatus.success)),
    );
  }
}
