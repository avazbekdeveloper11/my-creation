part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;

  @override
  List<Object> get props => [login, password];
}

class ShowPassword extends LoginEvent {
  const ShowPassword();

  @override
  List<Object?> get props => [];
}

class GetAccount extends LoginEvent {
  const GetAccount();

  @override
  List<Object?> get props => [];
}

class SetDeviceId extends LoginEvent {
  const SetDeviceId();

  @override
  List<Object?> get props => [];
}
