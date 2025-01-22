part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.apiStatus = ApiStatus.none,
    this.message = '',
    this.profileModel,
  });

  final ApiStatus apiStatus;
  final String message;
  final ProfileModel? profileModel;

  ProfileState copyWith({
    ApiStatus? apiStatus,
    String? message,
    ProfileModel? profileModel,
  }) {
    return ProfileState(
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      profileModel: profileModel ?? this.profileModel,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        message,
        profileModel,
      ];
}
