part of 'home_detail_bloc.dart';

sealed class HomeDetailEvent extends Equatable {
  const HomeDetailEvent();
}

class GetHomeDetailEvent extends HomeDetailEvent {
  final String uuid;

  const GetHomeDetailEvent({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}

class GetProfileDetailImage extends HomeDetailEvent {
  const GetProfileDetailImage({required this.profileId});
  final String profileId;

  @override
  List<Object?> get props => [profileId];
}

class PostViewedEvent extends HomeDetailEvent {
  const PostViewedEvent({required this.userModel});
  final UserModel? userModel;

  @override
  List<Object?> get props => [userModel];
}
