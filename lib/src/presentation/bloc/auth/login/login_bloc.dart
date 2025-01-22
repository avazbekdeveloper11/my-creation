import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/auth/account_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<LoginButtonPressed>(_login);
    on<GetAccount>(_getAccount);
    on<ShowPassword>(_showPassword);
    on<SetDeviceId>(_setDeviceId);
  }

  final AuthRepository authRepository;

  Future<void> _login(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await authRepository.login(login: event.login, password: event.password);

    result.fold(
      (failure) => emit(state.copyWith(apiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (success) {
        emit(state.copyWith(apiStatus: success ? ApiStatus.success : ApiStatus.error));
        add(SetDeviceId());
        add(GetAccount());
      },
    );
  }

  Future<void> _getAccount(GetAccount event, Emitter<LoginState> emit) async {
    emit(state.copyWith(getAccountApiStatus: ApiStatus.loading));
    final result = await authRepository.getAccount();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getAccountApiStatus: ApiStatus.error,
          message: (failure as ServerFailure).message,
        ),
      ),
      (model) => emit(
        state.copyWith(
          getAccountApiStatus: ApiStatus.success,
          accountModel: model,
        ),
      ),
    );
  }

  Future<void> _showPassword(ShowPassword event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> _setDeviceId(SetDeviceId event, Emitter<LoginState> emit) async {
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
}
