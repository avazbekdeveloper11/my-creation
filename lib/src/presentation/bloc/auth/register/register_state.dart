part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.apiStatus = ApiStatus.none,
    this.loginApiStatus = ApiStatus.none,
    this.setDeviceIdApiStatus = ApiStatus.none,
    this.privacyApiStatus = ApiStatus.none,
    this.isVisible = true,
    this.message = '',
    this.isAccept = false,
    this.privacyModel,
  });

  final ApiStatus apiStatus;
  final ApiStatus loginApiStatus;
  final ApiStatus setDeviceIdApiStatus;
  final ApiStatus privacyApiStatus;
  final bool isVisible;
  final String message;
  final bool isAccept;
  final PrivacyModel? privacyModel;

  RegisterState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? loginApiStatus,
    ApiStatus? setDeviceIdApiStatus,
    ApiStatus? privacyApiStatus,
    bool? isVisible,
    String? message,
    bool? isAccept,
    PrivacyModel? privacyModel,
  }) {
    return RegisterState(
      apiStatus: apiStatus ?? this.apiStatus,
      loginApiStatus: loginApiStatus ?? this.loginApiStatus,
      setDeviceIdApiStatus: setDeviceIdApiStatus ?? this.setDeviceIdApiStatus,
      privacyApiStatus: privacyApiStatus ?? this.privacyApiStatus,
      isVisible: isVisible ?? this.isVisible,
      message: message ?? this.message,
      isAccept: isAccept ?? this.isAccept,
      privacyModel: privacyModel ?? this.privacyModel,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        loginApiStatus,
        setDeviceIdApiStatus,
        privacyApiStatus,
        isVisible,
        message,
        isAccept,
        privacyModel,
      ];
}
