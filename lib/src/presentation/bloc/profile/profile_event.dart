part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent({this.isCache = true, this.isLoading = true});

  final bool isCache;
  final bool isLoading;

  @override
  List<Object?> get props => [isCache, isLoading];
}
