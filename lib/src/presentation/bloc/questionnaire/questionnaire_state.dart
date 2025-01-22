part of 'questionnaire_bloc.dart';

class QuestionnaireState extends Equatable {
  const QuestionnaireState({
    this.apiStatus = ApiStatus.none,
    this.nationalityApiStatus = ApiStatus.none,
    this.nationalities = const [],
    this.nationality,
    this.currentPlace,
    this.currentParentPlace,
    this.parentPlaceApiStatus = ApiStatus.none,
    this.placeApiStatus = ApiStatus.none,
    this.places = const [],
    this.place,
    this.parentPlaces = const [],
    this.parentPlace,
    this.education = '',
    this.isHealthy = true,
    this.maritalStatus = '',
    this.genderTagsSelected = const [],
    this.genderTags = const [],
    this.genderTagsApiStatus = ApiStatus.none,
    this.knownLanguages = const [],
    this.houseStatus = '',
    this.childPlan = '',
    this.childCount = 0,
    this.numberOfChildren = 1,
    this.whatChild = 1,
    this.createQuestionnaireApiStatus = ApiStatus.none,
    this.editProfileApiStatus = ApiStatus.none,
    this.setUserDataApiStatus = ApiStatus.none,
    this.message = '',
    this.photoLimit = 0,
  });

  final ApiStatus apiStatus;
  final ApiStatus nationalityApiStatus;
  final List<Nationality>? nationalities;
  final Nationality? nationality;
  final PlaceOfBirth? currentPlace;
  final PlaceOfBirth? currentParentPlace;
  final ApiStatus parentPlaceApiStatus;
  final ApiStatus placeApiStatus;
  final List<PlaceOfBirth>? places;
  final PlaceOfBirth? place;
  final List<PlaceOfBirth>? parentPlaces;
  final PlaceOfBirth? parentPlace;
  final String education;
  final bool isHealthy;
  final String maritalStatus;
  final List<GenderTags>? genderTagsSelected;
  final List<GenderTags>? genderTags;
  final ApiStatus genderTagsApiStatus;
  final List<String>? knownLanguages;
  final String houseStatus;
  final String? childPlan;
  final int? childCount;
  final int? numberOfChildren;
  final int? whatChild;
  final ApiStatus createQuestionnaireApiStatus;
  final ApiStatus editProfileApiStatus;
  final ApiStatus setUserDataApiStatus;
  final String message;
  final int photoLimit;

  QuestionnaireState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? nationalityApiStatus,
    List<Nationality>? nationalities,
    Nationality? nationality,
    PlaceOfBirth? currentPlace,
    PlaceOfBirth? currentParentPlace,
    ApiStatus? parentPlaceApiStatus,
    ApiStatus? placeApiStatus,
    List<PlaceOfBirth>? places,
    PlaceOfBirth? place,
    List<PlaceOfBirth>? parentPlaces,
    PlaceOfBirth? parentPlace,
    String? education,
    bool? isHealthy,
    String? maritalStatus,
    List<GenderTags>? genderTagsSelected,
    List<GenderTags>? genderTags,
    ApiStatus? genderTagsApiStatus,
    List<String>? knownLanguages,
    String? houseStatus,
    String? childPlan,
    int? childCount,
    int? numberOfChildren,
    int? whatChild,
    ApiStatus? createQuestionnaireApiStatus,
    ApiStatus? editProfileApiStatus,
    ApiStatus? setUserDataApiStatus,
    String? message,
    int? photoLimit,
  }) {
    return QuestionnaireState(
      apiStatus: apiStatus ?? this.apiStatus,
      nationalityApiStatus: nationalityApiStatus ?? this.nationalityApiStatus,
      nationalities: nationalities ?? this.nationalities,
      nationality: nationality ?? this.nationality,
      currentPlace: currentPlace ?? this.currentPlace,
      currentParentPlace: currentParentPlace ?? this.currentParentPlace,
      parentPlaceApiStatus: parentPlaceApiStatus ?? this.parentPlaceApiStatus,
      placeApiStatus: placeApiStatus ?? this.placeApiStatus,
      places: places ?? this.places,
      place: place ?? this.place,
      parentPlaces: parentPlaces ?? this.parentPlaces,
      parentPlace: parentPlace ?? this.parentPlace,
      education: education ?? this.education,
      isHealthy: isHealthy ?? this.isHealthy,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      genderTagsSelected: genderTagsSelected ?? this.genderTagsSelected,
      genderTags: genderTags ?? this.genderTags,
      genderTagsApiStatus: genderTagsApiStatus ?? this.genderTagsApiStatus,
      knownLanguages: knownLanguages ?? this.knownLanguages,
      houseStatus: houseStatus ?? this.houseStatus,
      childPlan: childPlan ?? this.childPlan,
      childCount: childCount ?? this.childCount,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      whatChild: whatChild ?? this.whatChild,
      createQuestionnaireApiStatus: createQuestionnaireApiStatus ?? this.createQuestionnaireApiStatus,
      editProfileApiStatus: editProfileApiStatus ?? this.editProfileApiStatus,
      setUserDataApiStatus: setUserDataApiStatus ?? this.setUserDataApiStatus,
      message: message ?? this.message,
      photoLimit: photoLimit ?? this.photoLimit,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        nationalityApiStatus,
        nationalities,
        nationality,
        currentPlace,
        currentParentPlace,
        parentPlaceApiStatus,
        placeApiStatus,
        places,
        place,
        parentPlaces,
        parentPlace,
        education,
        isHealthy,
        maritalStatus,
        genderTagsSelected,
        genderTags,
        genderTagsApiStatus,
        knownLanguages,
        houseStatus,
        childPlan,
        childCount,
        numberOfChildren,
        whatChild,
        createQuestionnaireApiStatus,
        editProfileApiStatus,
        setUserDataApiStatus,
        message,
        photoLimit,
      ];
}
