part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final ApiStatus configApiStatus;
  final ApiStatus sendOtpApiStatus;
  final ApiStatus otpApiStatus;
  final ApiStatus loginApiStatus;
  final ConfigModel? config;
  final String message;

  const OtpState(
      {this.configApiStatus = ApiStatus.none,
      this.sendOtpApiStatus = ApiStatus.none,
      this.otpApiStatus = ApiStatus.none,
      this.loginApiStatus = ApiStatus.none,
      this.config,
      this.message = ''});

  OtpState copyWith(
      {ApiStatus? configApiStatus,
      ApiStatus? sendOtpApiStatus,
      ApiStatus? otpApiStatus,
      ApiStatus? loginApiStatus,
      ConfigModel? config,
      String? message}) {
    return OtpState(
      configApiStatus: configApiStatus ?? this.configApiStatus,
      sendOtpApiStatus: sendOtpApiStatus ?? this.sendOtpApiStatus,
      otpApiStatus: otpApiStatus ?? this.otpApiStatus,
      loginApiStatus: loginApiStatus ?? this.loginApiStatus,
      config: config ?? this.config,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [configApiStatus, sendOtpApiStatus, otpApiStatus, config, loginApiStatus, message];
}
