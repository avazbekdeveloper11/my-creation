part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus likeApiStatus;
  final List<LikesModel>? userLikesModel;

  const LikeState({
    this.apiStatus = ApiStatus.none,
    this.likeApiStatus = ApiStatus.none,
    this.userLikesModel,
  });

  LikeState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? likeApiStatus,
    List<LikesModel>? userLikesModel,
  }) {
    return LikeState(
      apiStatus: apiStatus ?? this.apiStatus,
      likeApiStatus: likeApiStatus ?? this.likeApiStatus,
      userLikesModel: userLikesModel ?? this.userLikesModel,
    );
  }

  @override
  List<Object?> get props => [apiStatus, likeApiStatus, userLikesModel];
}
