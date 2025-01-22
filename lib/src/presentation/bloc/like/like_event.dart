part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();
}

class GetLikesEvent extends LikeEvent {
  const GetLikesEvent({this.isCache = true, this.isSuccessLike = false});

  final bool isCache;
  final bool isSuccessLike;

  @override
  List<Object?> get props => [isCache, isSuccessLike];
}

class LikeUserEvent extends LikeEvent {
  final String? profileId;

  const LikeUserEvent(this.profileId);

  @override
  List<Object?> get props => [profileId];
}

class DislikeUserEvent extends LikeEvent {
  final String? profileId;

  const DislikeUserEvent(this.profileId);

  @override
  List<Object?> get props => [profileId];
}
