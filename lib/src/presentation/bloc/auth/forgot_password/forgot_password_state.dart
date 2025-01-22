part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.apiStatus = ApiStatus.none,
    this.otpApiStatus = ApiStatus.none,
    this.isShow = false,
    this.configApiStatus = ApiStatus.none,
    this.config,
    this.message = '',
  });

  final ApiStatus apiStatus;
  final ApiStatus otpApiStatus;
  final bool isShow;
  final ApiStatus configApiStatus;
  final ConfigModel? config;
  final String? message;

  ForgotPasswordState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? otpApiStatus,
    bool? isShow,
    ApiStatus? configApiStatus,
    ConfigModel? config,
    String? message,
  }) {
    return ForgotPasswordState(
        apiStatus: apiStatus ?? this.apiStatus,
        otpApiStatus: otpApiStatus ?? this.otpApiStatus,
        isShow: isShow ?? this.isShow,
        configApiStatus: configApiStatus ?? this.configApiStatus,
        config: config ?? this.config,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        apiStatus,
        otpApiStatus,
        isShow,
        configApiStatus,
        config,
        message,
      ];
}
