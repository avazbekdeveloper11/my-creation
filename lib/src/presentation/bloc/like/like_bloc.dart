import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/like/likes_model.dart';
import 'package:sovchilar_mobile/src/domain/repositories/like_repo/like_repository.dart';

part 'like_event.dart';

part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc(this.likeRepository) : super(const LikeState()) {
    on<GetLikesEvent>(_getLikesEvent);
    on<LikeUserEvent>(_likeUserEvent);
    on<DislikeUserEvent>(_dislikeUserEvent);
  }

  final LikeRepository likeRepository;

  Future<void> _getLikesEvent(GetLikesEvent event, Emitter<LikeState> emit) async {
    if (event.isCache) {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.none));
    }
    final result = await likeRepository.getLikes(isCache: event.isCache);
    result.fold(
      (failure) => emit(state.copyWith(
        apiStatus: ApiStatus.error,
        likeApiStatus: event.isSuccessLike ? ApiStatus.error : ApiStatus.none,
      )),
      (userLikesModel) => emit(
        state.copyWith(
          userLikesModel: userLikesModel,
          apiStatus: ApiStatus.success,
          likeApiStatus: event.isSuccessLike ? ApiStatus.success : ApiStatus.none,
        ),
      ),
    );
  }

  Future<void> _likeUserEvent(LikeUserEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await likeRepository.likeUser(event.profileId);

    result.fold(
      (failure) {
        emit(state.copyWith(likeApiStatus: ApiStatus.error));
      },
      (message) {
        add(GetLikesEvent(isCache: false, isSuccessLike: true));
      },
    );
  }

  Future<void> _dislikeUserEvent(DislikeUserEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await likeRepository.dislikeUser(event.profileId);

    result.fold(
      (failure) => emit(state.copyWith(likeApiStatus: ApiStatus.error)),
      (message) {
        add(GetLikesEvent(isCache: false, isSuccessLike: true));
      },
    );
  }
}
