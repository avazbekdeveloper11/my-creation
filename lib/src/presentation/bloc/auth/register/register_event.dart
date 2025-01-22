part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterSubmitEvent extends RegisterEvent {
  const RegisterSubmitEvent({
    required this.login,
    required this.password,
    required this.date,
    required this.gender,
  });

  final String login;
  final String password;
  final String date;
  final String gender;

  @override
  List<Object?> get props => [
        login,
        password,
        date,
        gender,
      ];
}

class ShowPasswordEvent extends RegisterEvent {
  const ShowPasswordEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends RegisterEvent {
  const LoginEvent({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;

  @override
  List<Object?> get props => [login, password];
}

class SetDeviceIdRegister extends RegisterEvent {
  const SetDeviceIdRegister();

  @override
  List<Object?> get props => [];
}

class OnChangedPrivacy extends RegisterEvent {
  const OnChangedPrivacy();

  @override
  List<Object?> get props => [];
}

class GetPrivacy extends RegisterEvent {
  const GetPrivacy();

  @override
  List<Object?> get props => [];
}
