part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();
}

class OnChangedAgeEvent extends FilterEvent {
  final SfRangeValues ageRange;

  const OnChangedAgeEvent(this.ageRange);

  @override
  List<Object?> get props => [ageRange];
}

class OnChangedHeightEvent extends FilterEvent {
  final SfRangeValues heightRange;

  const OnChangedHeightEvent(this.heightRange);

  @override
  List<Object?> get props => [heightRange];
}

class OnChangedWeightEvent extends FilterEvent {
  final SfRangeValues weightRange;

  const OnChangedWeightEvent(this.weightRange);

  @override
  List<Object?> get props => [weightRange];
}

class OnChangedHealthyEvent extends FilterEvent {
  final bool isHealthy;

  const OnChangedHealthyEvent(this.isHealthy);

  @override
  List<Object?> get props => [isHealthy];
}

class GetPlacesEvent extends FilterEvent {
  const GetPlacesEvent();

  @override
  List<Object?> get props => [];
}

class GetParentPlacesEvent extends FilterEvent {
  const GetParentPlacesEvent(this.parentId);

  final String parentId;

  @override
  List<Object?> get props => [parentId];
}

class SelectPlace extends FilterEvent {
  const SelectPlace({required this.place, required this.parentPlace});

  final PlaceOfBirth? place;
  final PlaceOfBirth? parentPlace;

  @override
  List<Object?> get props => [place, parentPlace];
}

class SelectCurrentPlace extends FilterEvent {
  const SelectCurrentPlace({required this.currentPlace, required this.currentParentPlace});

  final PlaceOfBirth? currentPlace;
  final PlaceOfBirth? currentParentPlace;

  @override
  List<Object?> get props => [currentPlace, currentParentPlace];
}

class SelectMaritalEvent extends FilterEvent {
  const SelectMaritalEvent({required this.status});

  final String status;

  @override
  List<Object?> get props => [status];
}

class UnSelectMaritalEvent extends FilterEvent {
  const UnSelectMaritalEvent({required this.status});

  final String status;

  @override
  List<Object?> get props => [status];
}

class SelectLangEvent extends FilterEvent {
  const SelectLangEvent({required this.language});

  final String language;

  @override
  List<Object?> get props => [language];
}

class UnSelectLangEvent extends FilterEvent {
  const UnSelectLangEvent({required this.language});

  final String language;

  @override
  List<Object?> get props => [language];
}

class GetNationalityEvent extends FilterEvent {
  const GetNationalityEvent();

  @override
  List<Object?> get props => [];
}

class SelectNationalityEvent extends FilterEvent {
  const SelectNationalityEvent(this.nationality);

  final Nationality? nationality;

  @override
  List<Object?> get props => [nationality];
}

class UnSelectNationalityEvent extends FilterEvent {
  const UnSelectNationalityEvent(this.nationality);

  final String? nationality;

  @override
  List<Object?> get props => [nationality];
}

class GetGenderTagsEvent extends FilterEvent {
  const GetGenderTagsEvent({this.isFilter = false});

  final bool isFilter;

  @override
  List<Object?> get props => [isFilter];
}

class SelectGenderTagsEvent extends FilterEvent {
  const SelectGenderTagsEvent(this.genderTags);

  final GenderTags? genderTags;

  @override
  List<Object?> get props => [genderTags];
}

class UnSelectGenderTagsEvent extends FilterEvent {
  const UnSelectGenderTagsEvent(this.name);

  final String? name;

  @override
  List<Object?> get props => [name];
}

class SelectEducationStatusEvent extends FilterEvent {
  const SelectEducationStatusEvent(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class UnSelectEducationStatusEvent extends FilterEvent {
  const UnSelectEducationStatusEvent();

  @override
  List<Object?> get props => [];
}

class SetFilterEvent extends FilterEvent {
  const SetFilterEvent();

  @override
  List<Object?> get props => [];
}

class OnFilterClear extends FilterEvent {
  const OnFilterClear();

  @override
  List<Object?> get props => [];
}

class OnChangeKm extends FilterEvent {
  const OnChangeKm(this.km);

  final int km;

  @override
  List<Object?> get props => [km];
}
