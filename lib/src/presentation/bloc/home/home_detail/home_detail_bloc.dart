import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:sovchilar_mobile/src/data/models/image/image_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/image_repo/image_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/user_repo/user_repository.dart';

part 'home_detail_event.dart';

part 'home_detail_state.dart';

class HomeDetailBloc extends Bloc<HomeDetailEvent, HomeDetailState> {
  HomeDetailBloc({required this.homeRepository, required this.imageRepository}) : super(HomeDetailState()) {
    on<GetHomeDetailEvent>(_getHomeDetailEvent);
    on<GetProfileDetailImage>(_getImageUrlEvent);
    on<PostViewedEvent>(_postViewedEvent);
  }

  final UserRepository homeRepository;
  final ImageRepository imageRepository;

  Future<void> _getHomeDetailEvent(GetHomeDetailEvent event, Emitter<HomeDetailState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await homeRepository.getUserDetail(event.uuid);

    result.fold(
      (failure) => emit(state.copyWith(apiStatus: ApiStatus.error)),
      (user) => emit(state.copyWith(apiStatus: ApiStatus.success, user: user)),
    );
  }

  Future<void> _getImageUrlEvent(GetProfileDetailImage event, Emitter<HomeDetailState> emit) async {
    emit(state.copyWith(imageStatus: ApiStatus.loading));
    final result = await imageRepository.getImageUrl(profileId: event.profileId);

    result.fold(
      (error) => emit(
        state.copyWith(
          imageStatus: ApiStatus.none,
          message: (error as ServerFailure).message,
        ),
      ),
      (images) => emit(
        state.copyWith(
          images: images,
          imageStatus: ApiStatus.success,
        ),
      ),
    );
  }

  Future<void> _postViewedEvent(PostViewedEvent event, Emitter<HomeDetailState> emit) async {
    if (event.userModel?.id?.isEmpty ?? true) return;
    if (event.userModel?.viewed ?? false) return;
    emit(state.copyWith(viewStatus: ApiStatus.loading));

    final result = await homeRepository.postViewedApi(uuid: event.userModel?.id ?? '');

    result.fold(
      (error) => emit(
        state.copyWith(
          viewStatus: ApiStatus.none,
          message: (error as ServerFailure).message,
        ),
      ),
      (images) => emit(
        state.copyWith(
          viewStatus: ApiStatus.success,
        ),
      ),
    );
  }
}
