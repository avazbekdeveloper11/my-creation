import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/domain/repositories/like_repo/like_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/user_repo/user_repository.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.userRepository, this.likeRepository) : super(const HomeState()) {
    on<HomeScroll>(_onHomeScroll);
    on<GetUsersEvent>(_getUsersEvent);
    on<LikeUserEvent>(_likeUserEvent);
    on<DislikeUserEvent>(_dislikeUserEvent);
  }

  final UserRepository userRepository;
  final LikeRepository likeRepository;

  void _onHomeScroll(HomeScroll event, Emitter<HomeState> emit) {
    emit(state.copyWith(isScrollingTop: event.isScrollingTop));
  }

  Future<void> _getUsersEvent(GetUsersEvent event, Emitter<HomeState> emit) async {
    LocationPermission permission;
    Position? position;

    if (await Geolocator.isLocationServiceEnabled()) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition();
      } else {
        position = null;
      }
    } else {
      position = null;
    }

    final double latitude = position?.latitude ?? 0;
    final double longitude = position?.longitude ?? 0;

    emit(state.copyWith(apiStatus: ApiStatus.loading));

    final Map<String, dynamic> fl = {};
    if (event.filter?['nationalityId.in'].toString().isNotEmpty ?? false) {
      fl.addAll({
        'nationalityId.in': (event.filter?['nationalityId.in'] as List<dynamic>?)?.map((e) {
              return Nationality.fromJson(e as Map<String, dynamic>).id;
            }).toList() ??
            [],
      });
      event.filter?.remove('nationalityId.in');
    }

    if (event.filter?['placeOfBirth.in'].toString().isNotEmpty ?? false) {
      fl.addAll({
        'placeOfBirth.in': (event.filter?['placeOfBirth.in'] as List<dynamic>?)?.map((e) {
              return PlaceOfBirth.fromJson(e as Map<String, dynamic>).id;
            }).toList() ??
            [],
      });
      event.filter?.remove('placeOfBirth.in');
    }

    if (event.filter?['dwellingPlace.in'].toString().isNotEmpty ?? false) {
      fl.addAll({
        'dwellingPlace.in': (event.filter?['dwellingPlace.in'] as List<dynamic>?)?.map((e) {
              return PlaceOfBirth.fromJson(e as Map<String, dynamic>).id;
            }).toList() ??
            [],
      });
      event.filter?.remove('dwellingPlace.in');
    }

    if (event.filter?['genderTagsId.in'].toString().isNotEmpty ?? false) {
      fl.addAll({
        'genderTagsId.in': (event.filter?['genderTagsId.in'] as List<dynamic>?)?.map((e) {
              return GenderTags.fromJson(e as Map<String, dynamic>).id;
            }).toList() ??
            [],
      });
      event.filter?.remove('genderTagsId.in');
    }

    fl.addAll(event.filter ?? {});

    final cacheResult = await userRepository.getUsers(
      filter: fl,
      lat: latitude,
      long: longitude,
      km: int.tryParse(event.filter?['km'].toString() ?? '1000') ?? 1000,
    );

    cacheResult.fold(
      (failure) => emit(
        state.copyWith(
          apiStatus: ApiStatus.error,
          likeApiStatus: event.isSuccessLike ? ApiStatus.error : ApiStatus.none,
        ),
      ),
      (users) {
        emit(
          state.copyWith(
            users: users,
            apiStatus: ApiStatus.success,
            likeApiStatus: event.isSuccessLike ? ApiStatus.success : ApiStatus.none,
          ),
        );
      },
    );
  }

  Future<void> _likeUserEvent(LikeUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await likeRepository.likeUser(event.profileId);

    result.fold(
      (failure) {
        emit(state.copyWith(likeApiStatus: ApiStatus.error));
      },
      (message) => add(GetUsersEvent(isSuccessLike: true, filter: event.filter)),
    );
  }

  Future<void> _dislikeUserEvent(DislikeUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await likeRepository.dislikeUser(event.profileId);

    result.fold(
      (failure) => emit(state.copyWith(likeApiStatus: ApiStatus.error)),
      (message) => add(GetUsersEvent(isSuccessLike: true, filter: event.filter)),
    );
  }
}
