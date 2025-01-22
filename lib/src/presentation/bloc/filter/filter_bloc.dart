import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/domain/repositories/user_repo/user_repository.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc(this.userRepository) : super(const FilterState()) {
    on<GetPlacesEvent>(_getPlacesEvent);
    on<GetParentPlacesEvent>(_getParentPlacesEvent);
    on<SelectPlace>(_selectPlace);
    on<SelectCurrentPlace>(_selectCurrentPlace);
    on<OnChangedAgeEvent>(_onChangedAgeEvent);
    on<OnChangedHeightEvent>(_onChangedHeightEvent);
    on<OnChangedWeightEvent>(_onChangedWeightEvent);
    on<OnChangedHealthyEvent>(_onChangedHealthyEvent);
    on<SelectMaritalEvent>(_selectMaritalEvent);
    on<UnSelectMaritalEvent>(_unSelectMaritalEvent);
    on<SelectLangEvent>(_selectLanguageEvent);
    on<UnSelectLangEvent>(_unSelectLanguageEvent);
    on<GetNationalityEvent>(_getNationalityEvent);
    on<SelectNationalityEvent>(_selectNationalityEvent);
    on<UnSelectNationalityEvent>(_unSelectNationalityEvent);
    on<GetGenderTagsEvent>(_getGenderTagsEvent);
    on<SelectGenderTagsEvent>(_selectGenderTagEvent);
    on<UnSelectGenderTagsEvent>(_unSelectGenderTagEvent);
    on<SelectEducationStatusEvent>(_selectEducationStatusEvent);
    on<UnSelectEducationStatusEvent>(_unSelectEducationStatusEvent);
    on<SetFilterEvent>(_setFilterEvent);
    on<OnFilterClear>(_onFilterClear);
    on<OnChangeKm>(_onChangedKm);
  }

  final UserRepository userRepository;

  Future<void> _getPlacesEvent(GetPlacesEvent event, Emitter<FilterState> emit) async {
    emit(state.copyWith(placeApiStatus: ApiStatus.loading));
    final result = await userRepository.getPlaces();

    result.fold(
      (failure) => emit(state.copyWith(placeApiStatus: ApiStatus.error)),
      (places) => emit(state.copyWith(placeApiStatus: ApiStatus.success, places: places)),
    );
  }

  Future<void> _getParentPlacesEvent(GetParentPlacesEvent event, Emitter<FilterState> emit) async {
    emit(state.copyWith(parentPlaceApiStatus: ApiStatus.loading));
    final result = await userRepository.getParentPlaces(event.parentId);

    result.fold(
      (failure) => emit(state.copyWith(parentPlaceApiStatus: ApiStatus.error)),
      (parentPlaces) => emit(state.copyWith(parentPlaceApiStatus: ApiStatus.success, parentPlaces: parentPlaces)),
    );
  }

  void _onChangedAgeEvent(OnChangedAgeEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(ageRange: event.ageRange));
  }

  void _onChangedHeightEvent(OnChangedHeightEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(heightRange: event.heightRange));
  }

  void _onChangedWeightEvent(OnChangedWeightEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(weightRange: event.weightRange));
  }

  void _onChangedHealthyEvent(OnChangedHealthyEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(isHealthy: event.isHealthy));
  }

  void _selectPlace(SelectPlace event, Emitter<FilterState> emit) {
    emit(state.copyWith(place: event.place, parentPlace: event.parentPlace));
  }

  void _selectCurrentPlace(SelectCurrentPlace event, Emitter<FilterState> emit) {
    emit(state.copyWith(currentPlace: event.currentPlace, currentParentPlace: event.currentParentPlace));
  }

  void _selectMaritalEvent(SelectMaritalEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(maritalStatus: event.status));
  }

  void _unSelectMaritalEvent(UnSelectMaritalEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(maritalStatus: ''));
  }

  FutureOr<void> _selectLanguageEvent(SelectLangEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(knownLanguages: [event.language, ...?state.knownLanguages]));
  }

  FutureOr<void> _unSelectLanguageEvent(UnSelectLangEvent event, Emitter<FilterState> emit) {
    final List<String> languages = List.from(state.knownLanguages ?? []);
    languages.remove(event.language);
    emit(state.copyWith(knownLanguages: languages));
  }

  Future<void> _getNationalityEvent(GetNationalityEvent event, Emitter<FilterState> emit) async {
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

  FutureOr<void> _selectNationalityEvent(SelectNationalityEvent event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        nationality: (event.nationality?.id?.isNotEmpty ?? false)
            ? [event.nationality!, ...state.nationality ?? []]
            : state.nationality,
      ),
    );
  }

  FutureOr<void> _unSelectNationalityEvent(UnSelectNationalityEvent event, Emitter<FilterState> emit) {
    final List<Nationality> nationality = List.from(state.nationality ?? []);
    int index = nationality.indexWhere((element) => element.localization?.localizedValue == event.nationality);
    if (index != -1) {
      nationality.removeAt(index);
      emit(state.copyWith(nationality: nationality));
    }
  }

  Future<void> _getGenderTagsEvent(GetGenderTagsEvent event, Emitter<FilterState> emit) async {
    emit(state.copyWith(genderTagsApiStatus: ApiStatus.loading));

    final cacheResult = await userRepository.getGenderTags(isFilter: event.isFilter);
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

  FutureOr<void> _selectGenderTagEvent(SelectGenderTagsEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(
        genderTagsSelected:
            event.genderTags != null ? [event.genderTags!, ...?state.genderTagsSelected] : state.genderTagsSelected));
  }

  FutureOr<void> _unSelectGenderTagEvent(UnSelectGenderTagsEvent event, Emitter<FilterState> emit) {
    final List<GenderTags> genderTags = List.from(state.genderTagsSelected ?? []);
    int index = genderTags.lastIndexWhere((e) => e.localization?.localizedValue == event.name);
    genderTags.removeAt(index);
    emit(state.copyWith(genderTagsSelected: genderTags));
  }

  void _selectEducationStatusEvent(SelectEducationStatusEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(education: event.value));
  }

  void _unSelectEducationStatusEvent(UnSelectEducationStatusEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(education: ''));
  }

  void _setFilterEvent(SetFilterEvent event, Emitter<FilterState> emit) {
    final Map<String, dynamic>? filter =
        jsonDecode(localSource.getKey(AppKeys.filterCache) != '' ? localSource.getKey(AppKeys.filterCache) : '{}');

    emit(
      state.copyWith(
        ageRange: SfRangeValues(
          double.tryParse(filter?['age.greaterThan'] ?? '22') ?? 22.0,
          double.tryParse(filter?['age.lessThan'] ?? '82') ?? 82.0,
        ),

        heightRange: SfRangeValues(
          double.tryParse(filter?['height.greaterThan'] ?? '140') ?? 140.0,
          double.tryParse(filter?['height.lessThan'] ?? '200') ?? 200.0,
        ),

        weightRange: SfRangeValues(
          double.tryParse(filter?['weight.greaterThan'] ?? '40') ?? 40.0,
          double.tryParse(filter?['weight.lessThan'] ?? '160') ?? 160.0,
        ),

        place: filter?['placeOfBirth.in']?.isNotEmpty ?? false
            ? PlaceOfBirth.fromJson(filter?['placeOfBirth.in'][0] ?? '{}')
            : null,

        parentPlace: (filter?['placeOfBirth.in']?.length ?? 0) > 1
            ? PlaceOfBirth.fromJson(filter?['placeOfBirth.in'][1] ?? '{}')
            : null,

        currentPlace: filter?['dwellingPlace.in']?.isNotEmpty ?? false
            ? PlaceOfBirth.fromJson(filter?['dwellingPlace.in']?[0] ?? '{}')
            : null,

        currentParentPlace: (filter?['dwellingPlace.in']?.length ?? 0) > 1
            ? PlaceOfBirth.fromJson(filter?['dwellingPlace.in'][1] ?? '{}')
            : null,

        maritalStatus: filter?['maritalStatus.in']?[0] ?? '',

        education: filter?['education.in']?[0] ?? '',

        knownLanguages: (filter?['knowledgeOfLanguages.in'] as List<dynamic>?)?.map((e) => e.toString()).toList(),

        isHealthy: filter?['isHealthy.equals'] ?? true,

        // Nationality

        nationality: (filter?['nationalityId.in'] as List<dynamic>?)?.map((e) {
              return Nationality.fromJson(e as Map<String, dynamic>);
            }).toList() ??
            [],

        // Gender Tags Selected
        genderTagsSelected:
            (filter?['genderTagsId.in'] as List<dynamic>?)?.map((e) => GenderTags.fromJson(e)).toList() ?? [],

        km: int.tryParse(filter?['km']?.toString() ?? '1000') ?? 1000,
      ),
    );
  }

  FutureOr<void> _onFilterClear(OnFilterClear event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        heightRange: SfRangeValues(140, 200),
        weightRange: SfRangeValues(40, 160),
        ageRange: SfRangeValues(22, 82),
        place: PlaceOfBirth(),
        parentPlace: PlaceOfBirth(),
        maritalStatus: '',
        education: '',
        knownLanguages: [],
        currentPlace: PlaceOfBirth(),
        currentParentPlace: PlaceOfBirth(),
        isHealthy: true,
        nationality: [],
        genderTagsSelected: [],
        nationalities: [],
        km: 0,
      ),
    );
  }

  void _onChangedKm(OnChangeKm event, Emitter<FilterState> emit) {
    emit(state.copyWith(km: event.km));
  }
}
