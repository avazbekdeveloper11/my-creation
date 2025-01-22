part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeScroll extends HomeEvent {
  const HomeScroll({
    required this.isScrollingTop,
  });

  final bool isScrollingTop;

  @override
  List<Object?> get props => [isScrollingTop];
}

class GetUsersEvent extends HomeEvent {
  const GetUsersEvent({
    this.isSuccessLike = false,
    this.filter,
  });

  final bool isSuccessLike;
  final Map<String, dynamic>? filter;

  @override
  List<Object?> get props => [isSuccessLike, filter];
}

class LikeUserEvent extends HomeEvent {
  final String? profileId;
  final Map<String, dynamic>? filter;

  const LikeUserEvent(
    this.profileId,
    this.filter,
  );

  @override
  List<Object?> get props => [profileId];
}

class DislikeUserEvent extends HomeEvent {
  final String? profileId;
  final Map<String, dynamic>? filter;

  const DislikeUserEvent(this.profileId, this.filter);

  @override
  List<Object?> get props => [profileId];
}

// class OnChangedAgeEvent extends HomeEvent {
//   final SfRangeValues ageRange;
//
//   const OnChangedAgeEvent(this.ageRange);
//
//   @override
//   List<Object?> get props => [ageRange];
// }
//
// class OnChangedHeightEvent extends HomeEvent {
//   final SfRangeValues heightRange;
//
//   const OnChangedHeightEvent(this.heightRange);
//
//   @override
//   List<Object?> get props => [heightRange];
// }

// class OnChangedWeightEvent extends HomeEvent {
//   final SfRangeValues weightRange;
//
//   const OnChangedWeightEvent(this.weightRange);
//
//   @override
//   List<Object?> get props => [weightRange];
// }

// class OnChangedHealthyEvent extends HomeEvent {
//   final bool isHealthy;
//
//   const OnChangedHealthyEvent(this.isHealthy);
//
//   @override
//   List<Object?> get props => [isHealthy];
// }

// class GetPlacesEvent extends HomeEvent {
//   const GetPlacesEvent();
//
//   @override
//   List<Object?> get props => [];
// }

// class GetParentPlacesEvent extends HomeEvent {
//   const GetParentPlacesEvent(this.parentId);
//
//   final String parentId;
//
//   @override
//   List<Object?> get props => [parentId];
// }

// class SelectPlace extends HomeEvent {
//   const SelectPlace({required this.place, required this.parentPlace});
//
//   final String place;
//   final String parentPlace;
//
//   @override
//   List<Object?> get props => [place, parentPlace];
// }

// class SelectCurrentPlace extends HomeEvent {
//   const SelectCurrentPlace({required this.currentPlace, required this.currentParentPlace});
//
//   final String currentPlace;
//   final String currentParentPlace;
//
//   @override
//   List<Object?> get props => [currentPlace, currentParentPlace];
// }

// class SelectMaritalEvent extends HomeEvent {
//   const SelectMaritalEvent({required this.status});
//
//   final String status;
//
//   @override
//   List<Object?> get props => [status];
// }
//
// class UnSelectMaritalEvent extends HomeEvent {
//   const UnSelectMaritalEvent({required this.status});
//
//   final String status;
//
//   @override
//   List<Object?> get props => [status];
// }

// class SelectLangEvent extends HomeEvent {
//   const SelectLangEvent({required this.language});
//
//   final String language;
//
//   @override
//   List<Object?> get props => [language];
// }
//
// class UnSelectLangEvent extends HomeEvent {
//   const UnSelectLangEvent({required this.language});
//
//   final String language;
//
//   @override
//   List<Object?> get props => [language];
// }
//
// class GetNationalityEvent extends HomeEvent {
//   const GetNationalityEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class SelectNationalityEvent extends HomeEvent {
//   const SelectNationalityEvent(this.nationality);
//
//   final Nationality? nationality;
//
//   @override
//   List<Object?> get props => [nationality];
// }
//
// class GetGenderTagsEvent extends HomeEvent {
//   const GetGenderTagsEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class SelectGenderTagsEvent extends HomeEvent {
//   const SelectGenderTagsEvent(this.genderTags);
//
//   final GenderTags? genderTags;
//
//   @override
//   List<Object?> get props => [genderTags];
// }
//
// class UnSelectGenderTagsEvent extends HomeEvent {
//   const UnSelectGenderTagsEvent(this.name);
//
//   final String? name;
//
//   @override
//   List<Object?> get props => [name];
// }
//
// class SelectEducationStatusEvent extends HomeEvent {
//   const SelectEducationStatusEvent(this.value);
//
//   final String value;
//
//   @override
//   List<Object?> get props => [value];
// }

// class UnSelectEducationStatusEvent extends HomeEvent {
//   const UnSelectEducationStatusEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class OnFilterClear extends HomeEvent {
//   const OnFilterClear();
//
//   @override
//   List<Object?> get props => [];
// }
