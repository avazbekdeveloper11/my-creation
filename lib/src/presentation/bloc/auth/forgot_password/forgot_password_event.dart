part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class SendForgotOtp extends ForgotPasswordEvent {
  const SendForgotOtp({required this.phone});

  final String phone;

  @override
  List<Object?> get props => [phone];
}

class VerifyForgotOtpEvent extends ForgotPasswordEvent {
  const VerifyForgotOtpEvent({
    required this.phone,
    required this.password,
    required this.code,
  });

  final String phone;
  final String password;
  final String code;

  @override
  List<Object?> get props => [
        phone,
        password,
        code,
      ];
}

class OnChangedVisible extends ForgotPasswordEvent {
  const OnChangedVisible();

  @override
  List<Object?> get props => [];
}

class GetConfigForgotEvent extends ForgotPasswordEvent {
  const GetConfigForgotEvent(this.login);

  final String login;
  @override
  List<Object?> get props => [];
}
