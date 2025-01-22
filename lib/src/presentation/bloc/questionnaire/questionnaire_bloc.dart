import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/user_repo/user_repository.dart';

part 'questionnaire_event.dart';

part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  QuestionnaireBloc(this.userRepository) : super(const QuestionnaireState()) {
    on<GetNationalityEvent>(_getNationalityEvent);
    on<SelectNationalityProfileEvent>(_selectNationalityEvent);
    on<UnSelectNationalityProfileEvent>(_unSelectNationalityEvent);
    on<GetPlacesProfileEvent>(_getPlacesEvent);
    on<GetParentPlacesProfileEvent>(_getParentPlacesEvent);
    on<SelectPlaceProfile>(_selectPlace);
    on<SelectCurrentPlaceProfile>(_selectCurrentPlace);
    on<SelectEducationStatusProfileEvent>(_selectEducationStatusEvent);
    on<UnSelectEducationStatusProfileEvent>(_unSelectEducationStatusEvent);
    on<OnChangedHealthyProfileEvent>(_onChangedHealthyEvent);
    on<SelectMaritalProfileEvent>(_selectMaritalEvent);
    on<UnSelectMaritalProfileEvent>(_unSelectMaritalEvent);
    on<GetGenderTagsProfileEvent>(_getGenderTagsEvent);
    on<SelectGenderTagsProfileEvent>(_selectGenderTagEvent);
    on<UnSelectGenderTagsProfileEvent>(_unSelectGenderTagEvent);
    on<SelectLangProfileEvent>(_selectLanguageEvent);
    on<UnSelectLangProfileEvent>(_unSelectLanguageEvent);
    on<ChangeHouseStatusEvent>(_changeHouseStatusEvent);
    on<SelectChildPlanEvent>(_selectChildPlanEvent);
    on<ChangeChildCountEvent>(_changeChildCountEvent);
    on<ChangeNumberOfChildrenEvent>(_changeChildNumberOfChildrenEvent);
    on<ChangeWhatChildEvent>(_changeWhatChildEvent);
    on<CreateQuestionnaireEvent>(_createQuestionnaireEvent);
    on<ClearEvent>(_clearEvent);
    on<EditProfileEvent>(_editProfileEvent);
    on<SetUserData>(_setUserData);
    on<FillDataEvent>(_fillDataEvent);
  }

  final UserRepository userRepository;

  Future<void> _getNationalityEvent(GetNationalityEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(nationalityApiStatus: ApiStatus.loading));

    final cacheResult = await userRepository.getNationalities();
    cacheResult.fold(
      (failure) => emit(
        state.copyWith(
          nationalityApiStatus: ApiStatus.error,
        ),
      ),
      (nationalities) {
        emit(
          state.copyWith(
            nationalities: nationalities,
            nationalityApiStatus: ApiStatus.success,
          ),
        );
      },
    );
  }

  void _selectNationalityEvent(SelectNationalityProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(nationality: event.nationality));
  }

  void _unSelectNationalityEvent(UnSelectNationalityProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(nationality: Nationality()));
  }

  Future<void> _getPlacesEvent(GetPlacesProfileEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(placeApiStatus: ApiStatus.loading));
    final result = await userRepository.getPlaces();

    result.fold(
      (failure) => emit(state.copyWith(placeApiStatus: ApiStatus.error)),
      (places) => emit(state.copyWith(placeApiStatus: ApiStatus.success, places: places)),
    );
  }

  Future<void> _getParentPlacesEvent(GetParentPlacesProfileEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(parentPlaceApiStatus: ApiStatus.loading));
    final result = await userRepository.getParentPlaces(event.parentId);

    result.fold(
      (failure) => emit(state.copyWith(parentPlaceApiStatus: ApiStatus.error)),
      (parentPlaces) => emit(state.copyWith(parentPlaceApiStatus: ApiStatus.success, parentPlaces: parentPlaces)),
    );
  }

  void _selectPlace(SelectPlaceProfile event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(place: event.place, parentPlace: event.parentPlace));
  }

  void _selectCurrentPlace(SelectCurrentPlaceProfile event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(currentPlace: event.currentPlace, currentParentPlace: event.currentParentPlace));
  }

  void _selectEducationStatusEvent(SelectEducationStatusProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(education: event.value));
  }

  void _unSelectEducationStatusEvent(UnSelectEducationStatusProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(education: ''));
  }

  void _onChangedHealthyEvent(OnChangedHealthyProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(isHealthy: event.isHealthy));
  }

  void _selectMaritalEvent(SelectMaritalProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(maritalStatus: event.status, childCount: event.status == 'UNMARRIED' ? 0 : null));
  }

  void _unSelectMaritalEvent(UnSelectMaritalProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(maritalStatus: ''));
  }

  void _getGenderTagsEvent(GetGenderTagsProfileEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(genderTagsApiStatus: ApiStatus.loading));

    final cacheResult = await userRepository.getGenderTags();
    cacheResult.fold(
      (failure) => emit(
        state.copyWith(
          genderTagsApiStatus: ApiStatus.error,
        ),
      ),
      (genderTags) {
        emit(
          state.copyWith(
            genderTags: genderTags,
            genderTagsApiStatus: ApiStatus.success,
          ),
        );
      },
    );
  }

  void _selectGenderTagEvent(SelectGenderTagsProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(
        genderTagsSelected:
            event.genderTags != null ? [event.genderTags!, ...?state.genderTagsSelected] : state.genderTagsSelected));
  }

  void _unSelectGenderTagEvent(UnSelectGenderTagsProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(
      genderTagsSelected:
          state.genderTagsSelected?.where((tag) => tag.localization?.localizedValue != event.name).toList(),
    ));
  }

  void _selectLanguageEvent(SelectLangProfileEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(knownLanguages: [event.language, ...?state.knownLanguages]));
  }

  void _unSelectLanguageEvent(UnSelectLangProfileEvent event, Emitter<QuestionnaireState> emit) {
    final List<String> languages = List.from(state.knownLanguages ?? []);
    languages.remove(event.language);
    emit(state.copyWith(knownLanguages: languages));
  }

  void _changeHouseStatusEvent(ChangeHouseStatusEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(houseStatus: event.status));
  }

  void _selectChildPlanEvent(SelectChildPlanEvent event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(childPlan: event.plan));
  }

  void _changeChildCountEvent(ChangeChildCountEvent event, Emitter<QuestionnaireState> emit) {
    if (event.count < 0) {
      emit(state.copyWith(childCount: 0));
    } else {
      emit(state.copyWith(childCount: event.count));
    }
  }

  void _changeChildNumberOfChildrenEvent(ChangeNumberOfChildrenEvent event, Emitter<QuestionnaireState> emit) {
    if (event.count < 1) {
      emit(state.copyWith(numberOfChildren: 1, whatChild: 1));
    } else {
      emit(state.copyWith(numberOfChildren: event.count, whatChild: 1));
    }
  }

  void _changeWhatChildEvent(ChangeWhatChildEvent event, Emitter<QuestionnaireState> emit) {
    if (event.count < 1) {
      emit(state.copyWith(whatChild: 1));
    } else {
      emit(state.copyWith(whatChild: event.count));
    }
  }

  Future<void> _createQuestionnaireEvent(CreateQuestionnaireEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(createQuestionnaireApiStatus: ApiStatus.loading));
    final result = await userRepository.createQuestionnaire(
      UserModel(
        id: null,
        name: event.name,
        user: User(id: localSource.userId),
        height: num.tryParse(event.height) ?? 0,
        weight: num.tryParse(event.weight) ?? 0,
        education: state.education,
        profession: event.profession,
        workPlace: event.workPlace,
        isHealthy: state.isHealthy,
        healthIssues: event.healthIssues,
        // todo to back date of birth add
        dateOfBirth: '2000-06-11',
        // localSource.dateOfBirth ??
        placeOfBirth: state.parentPlace,
        dwellingPlace: state.currentParentPlace,
        maritalStatus: state.maritalStatus,
        childPlanInFuture: state.childPlan,
        numOfMembersInFamily: state.numberOfChildren?.toDouble(),
        numOfChildrenInFamily: state.childCount?.toDouble(),
        birthPositionInFamily: state.whatChild?.toDouble(),
        ownDwelling: state.houseStatus,
        knowledgeOfLanguages: state.knownLanguages,
        skills: event.skills,
        bio: event.bio,
        requirements: event.requirements,
        location: null,
        discoverability: null,
        nationality: state.nationality,
        genderTags: state.genderTagsSelected,
        attachments: [],
        profileState: 'ACCEPTED',
        profilePictureType: 'PRIVATE',
        sharedWithUsers: [],
      ),
    );

    result.fold(
      (failure) => emit(
          state.copyWith(createQuestionnaireApiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (photoLimit) {
        add(ClearEvent());
        emit(state.copyWith(
          photoLimit: photoLimit,
          createQuestionnaireApiStatus: ApiStatus.success,
        ));
      },
    );
  }

  void _clearEvent(ClearEvent event, Emitter<QuestionnaireState> emit) {
    emit(
      state.copyWith(
        genderTagsSelected: [],
        knownLanguages: [],
        childCount: 0,
        numberOfChildren: 1,
        whatChild: 1,
        houseStatus: '',
        isHealthy: true,
        maritalStatus: '',
        currentPlace: PlaceOfBirth(),
        currentParentPlace: PlaceOfBirth(),
        parentPlace: PlaceOfBirth(),
        nationality: Nationality(),
        education: '',
        place: PlaceOfBirth(),
        childPlan: '',
      ),
    );
  }

  Future<void> _editProfileEvent(EditProfileEvent event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(editProfileApiStatus: ApiStatus.loading));
    final result = await userRepository.editProfile(
      profile: UserModel(
        id: localSource.userId,
        name: event.name,
        user: User(id: localSource.userId),
        height: num.tryParse(event.height) ?? 0,
        weight: num.tryParse(event.weight) ?? 0,
        education: state.education,
        profession: event.profession,
        workPlace: event.workPlace,
        isHealthy: state.isHealthy,
        healthIssues: event.healthIssues,
        dateOfBirth: '2000-06-11',
        placeOfBirth: state.parentPlace,
        dwellingPlace: state.currentParentPlace,
        maritalStatus: state.maritalStatus,
        childPlanInFuture: state.childPlan,
        numOfMembersInFamily: state.numberOfChildren?.toDouble(),
        numOfChildrenInFamily: state.childCount?.toDouble(),
        birthPositionInFamily: state.whatChild?.toDouble(),
        ownDwelling: state.houseStatus,
        knowledgeOfLanguages: state.knownLanguages,
        skills: event.skills,
        bio: event.bio,
        requirements: event.requirements,
        profileState: 'ACCEPTED',
        location: null,
        discoverability: null,
        nationality: state.nationality,
        genderTags: state.genderTagsSelected ?? [],
        attachments: event.attachments ?? [],
        profilePictureType: 'PRIVATE',
        sharedWithUsers: event.sharedWithUsers ?? [],
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(editProfileApiStatus: ApiStatus.error, message: (failure as ServerFailure).message)),
      (success) {
        emit(state.copyWith(editProfileApiStatus: ApiStatus.success));
      },
    );
  }

  void _setUserData(SetUserData event, Emitter<QuestionnaireState> emit) {
    emit(state.copyWith(
      setUserDataApiStatus: ApiStatus.loading,
      place: event.place,
      parentPlace: event.parentPlace,
      currentPlace: event.currentPlace,
      currentParentPlace: event.currentParentPlace,
    ));
  }

  void _fillDataEvent(FillDataEvent event, Emitter<QuestionnaireState> emit) {
    emit(
      state.copyWith(
        education: event.profileModel?.education,
        isHealthy: event.profileModel?.isHealthy,
        place: event.profileModel?.placeOfBirth?.children?.firstOrNull,
        parentPlace: event.profileModel?.placeOfBirth?.children?.firstOrNull?.children?.firstOrNull,
        currentPlace: event.profileModel?.dwellingPlace?.children?.firstOrNull,
        currentParentPlace: event.profileModel?.dwellingPlace?.children?.firstOrNull?.children?.firstOrNull,
        maritalStatus: event.profileModel?.maritalStatus,
        childPlan: event.profileModel?.childPlanInFuture,
        numberOfChildren: event.profileModel?.numOfMembersInFamily?.toInt() ?? 1,
        childCount: event.profileModel?.numOfChildrenInFamily?.toInt() ?? 1,
        whatChild: event.profileModel?.birthPositionInFamily?.toInt() ?? 0,
        knownLanguages: event.profileModel?.knowledgeOfLanguages,
        nationality: event.profileModel?.nationality,
        genderTagsSelected: event.profileModel?.genderTags ?? [],
        houseStatus: event.profileModel?.ownDwelling,
      ),
    );
  }
}
