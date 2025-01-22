import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/auth/privacy_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.authRepository) : super(const RegisterState()) {
    on<RegisterSubmitEvent>(_register);
    on<ShowPasswordEvent>(_showPassword);
    on<LoginEvent>(_login);
    on<SetDeviceIdRegister>(_setDeviceIdRegister);
    on<OnChangedPrivacy>(_onChangedPrivacy);
    on<GetPrivacy>(_getPrivacy);
  }

  final AuthRepository authRepository;

  Future<void> _register(RegisterSubmitEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await authRepository.register(
      login: event.login,
      password: event.password,
      date: event.date,
      gender: event.gender,
    );

    result.fold(
      (failure) => emit(state.copyWith(apiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (success) {
        emit(state.copyWith(apiStatus: ApiStatus.success));
        add(LoginEvent(login: event.login, password: event.password));
      },
    );
  }

  Future<void> _showPassword(ShowPasswordEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> _login(LoginEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(loginApiStatus: ApiStatus.loading));
    final result = await authRepository.login(login: event.login, password: event.password);

    result.fold(
      (failure) => emit(state.copyWith(loginApiStatus: ApiStatus.error)),
      (config) {
        emit(state.copyWith(loginApiStatus: ApiStatus.success));
      },
    );
  }

  Future<void> _setDeviceIdRegister(SetDeviceIdRegister event, Emitter<RegisterState> emit) async {
    final result = await authRepository.setDeviceId();

    result.fold(
      (failure) => emit(
        state.copyWith(
          setDeviceIdApiStatus: ApiStatus.error,
          message: (failure as ServerFailure).message,
        ),
      ),
      (model) => emit(
        state.copyWith(
          setDeviceIdApiStatus: ApiStatus.success,
        ),
      ),
    );
  }

  Future<void> _onChangedPrivacy(OnChangedPrivacy event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isAccept: !state.isAccept));
  }

  Future<void> _getPrivacy(GetPrivacy event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(privacyApiStatus: ApiStatus.loading));
    final result = await authRepository.getPrivacy();
    result.fold(
      (failure) => emit(
        state.copyWith(
          privacyApiStatus: ApiStatus.error,
          message: (failure as ServerFailure).message,
        ),
      ),
      (model) => emit(
        state.copyWith(
          privacyApiStatus: ApiStatus.success,
          privacyModel: model,
        ),
      ),
    );
  }
}
