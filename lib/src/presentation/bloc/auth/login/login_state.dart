part of 'login_bloc.dart';

class LoginState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus getAccountApiStatus;
  final ApiStatus setDeviceIdApiStatus;
  final bool isVisible;
  final String message;
  final AccountModel? accountModel;

  const LoginState({
    this.apiStatus = ApiStatus.none,
    this.getAccountApiStatus = ApiStatus.none,
    this.setDeviceIdApiStatus = ApiStatus.none,
    this.isVisible = true,
    this.message = '',
    this.accountModel,
  });

  LoginState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? getAccountApiStatus,
    bool? isVisible,
    String? message,
    AccountModel? accountModel,
    ApiStatus? setDeviceIdApiStatus,
  }) {
    return LoginState(
      apiStatus: apiStatus ?? this.apiStatus,
      getAccountApiStatus: getAccountApiStatus ?? this.getAccountApiStatus,
      setDeviceIdApiStatus: setDeviceIdApiStatus ?? this.setDeviceIdApiStatus,
      isVisible: isVisible ?? this.isVisible,
      message: message ?? this.message,
      accountModel: accountModel ?? this.accountModel,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        getAccountApiStatus,
        setDeviceIdApiStatus,
        isVisible,
        message,
        accountModel,
      ];
}
