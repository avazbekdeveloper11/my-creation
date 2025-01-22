part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();
}

class GetConfigEvent extends OtpEvent {
  const GetConfigEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends OtpEvent {
  const SendOtpEvent(this.login);

  final String login;

  @override
  List<Object?> get props => [login];
}

class OtpConfirmEvent extends OtpEvent {
  const OtpConfirmEvent(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}
