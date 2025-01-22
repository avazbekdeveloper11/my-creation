import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/profile_repo/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepository) : super(const ProfileState()) {
    on<GetProfileEvent>(_getProfile);
  }

  final ProfileRepository profileRepository;

  Future<void> _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    if (event.isLoading) {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
    }

    final result = await profileRepository.getProfile(isCache: event.isCache);

    result.fold(
      (failure) => emit(state.copyWith(apiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (profile) => emit(state.copyWith(apiStatus: ApiStatus.success, profileModel: profile)),
    );
  }
}
