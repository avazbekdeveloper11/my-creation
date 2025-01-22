part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isScrollingTop = false,
    this.apiStatus = ApiStatus.none,
    this.likeApiStatus = ApiStatus.none,
    this.placeApiStatus = ApiStatus.none,
    this.parentPlaceApiStatus = ApiStatus.none,
    this.users = const [],
    this.places = const [],
    this.parentPlaces = const [],
    this.ageRange = const SfRangeValues(22, 82),
    this.heightRange = const SfRangeValues(140, 200),
    this.weightRange = const SfRangeValues(40, 160),
    this.isHealthy = true,
    this.place = '',
    this.currentPlace = '',
    this.parentPlace = '',
    this.currentParentPlace = '',
    this.maritalStatus = '',
    this.knownLanguages = const [],
    this.nationalityApiStatus = ApiStatus.none,
    this.nationalities = const [],
    this.nationality,
    this.genderTagsApiStatus = ApiStatus.none,
    this.genderTags = const [],
    this.genderTagsSelected = const [],
    this.education = '',
  });

  final bool isScrollingTop;
  final ApiStatus apiStatus;
  final ApiStatus likeApiStatus;
  final ApiStatus placeApiStatus;
  final ApiStatus parentPlaceApiStatus;
  final List<UserModel>? users;
  final List<PlaceOfBirth>? places;
  final List<PlaceOfBirth>? parentPlaces;
  final SfRangeValues ageRange;
  final SfRangeValues heightRange;
  final SfRangeValues weightRange;
  final bool isHealthy;
  final String place;
  final String currentPlace;
  final String parentPlace;
  final String currentParentPlace;
  final String maritalStatus;
  final List<String>? knownLanguages;
  final ApiStatus nationalityApiStatus;
  final List<Nationality>? nationalities;
  final Nationality? nationality;
  final ApiStatus genderTagsApiStatus;
  final List<GenderTags>? genderTags;
  final List<GenderTags>? genderTagsSelected;
  final String education;

  HomeState copyWith({
    bool? isScrollingTop,
    ApiStatus? apiStatus,
    ApiStatus? likeApiStatus,
    ApiStatus? placeApiStatus,
    ApiStatus? parentPlaceApiStatus,
    List<UserModel>? users,
    List<PlaceOfBirth>? places,
    List<PlaceOfBirth>? parentPlaces,
    SfRangeValues? ageRange,
    SfRangeValues? heightRange,
    SfRangeValues? weightRange,
    bool? isHealthy,
    String? place,
    String? currentPlace,
    String? parentPlace,
    String? currentParentPlace,
    String? maritalStatus,
    List<String>? knownLanguages,
    ApiStatus? nationalityApiStatus,
    List<Nationality>? nationalities,
    Nationality? nationality,
    ApiStatus? genderTagsApiStatus,
    List<GenderTags>? genderTags,
    List<GenderTags>? genderTagsSelected,
    String? education,
  }) =>
      HomeState(
        isScrollingTop: isScrollingTop ?? this.isScrollingTop,
        apiStatus: apiStatus ?? this.apiStatus,
        likeApiStatus: likeApiStatus ?? this.likeApiStatus,
        placeApiStatus: placeApiStatus ?? this.placeApiStatus,
        parentPlaceApiStatus: parentPlaceApiStatus ?? this.parentPlaceApiStatus,
        users: users ?? this.users,
        places: places ?? this.places,
        parentPlaces: parentPlaces ?? this.parentPlaces,
        ageRange: ageRange ?? this.ageRange,
        heightRange: heightRange ?? this.heightRange,
        weightRange: weightRange ?? this.weightRange,
        isHealthy: isHealthy ?? this.isHealthy,
        place: place ?? this.place,
        currentPlace: currentPlace ?? this.currentPlace,
        parentPlace: parentPlace ?? this.parentPlace,
        currentParentPlace: currentParentPlace ?? this.currentParentPlace,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        knownLanguages: knownLanguages ?? this.knownLanguages,
        nationalityApiStatus: nationalityApiStatus ?? this.nationalityApiStatus,
        nationalities: nationalities ?? this.nationalities,
        nationality: nationality ?? this.nationality,
        genderTagsApiStatus: genderTagsApiStatus ?? this.genderTagsApiStatus,
        genderTags: genderTags ?? this.genderTags,
        genderTagsSelected: genderTagsSelected ?? this.genderTagsSelected,
        education: education ?? this.education,
      );

  @override
  List<Object?> get props => [
        isScrollingTop,
        apiStatus,
        likeApiStatus,
        placeApiStatus,
        parentPlaceApiStatus,
        users,
        places,
        parentPlaces,
        ageRange,
        heightRange,
        weightRange,
        isHealthy,
        place,
        currentPlace,
        currentParentPlace,
        parentPlace,
        maritalStatus,
        knownLanguages,
        nationalityApiStatus,
        nationalities,
        nationality,
        genderTagsApiStatus,
        genderTags,
        genderTagsSelected,
        education,
      ];
}
