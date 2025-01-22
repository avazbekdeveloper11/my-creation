part of 'questionnaire_bloc.dart';

sealed class QuestionnaireEvent extends Equatable {
  const QuestionnaireEvent();
}

class GetNationalityEvent extends QuestionnaireEvent {
  const GetNationalityEvent();

  @override
  List<Object?> get props => [];
}

class SelectNationalityProfileEvent extends QuestionnaireEvent {
  const SelectNationalityProfileEvent(this.nationality);

  final Nationality? nationality;

  @override
  List<Object?> get props => [nationality];
}

class UnSelectNationalityProfileEvent extends QuestionnaireEvent {
  const UnSelectNationalityProfileEvent(this.nationality);

  final String? nationality;

  @override
  List<Object?> get props => [nationality];
}

///
class GetPlacesProfileEvent extends QuestionnaireEvent {
  const GetPlacesProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetParentPlacesProfileEvent extends QuestionnaireEvent {
  const GetParentPlacesProfileEvent(this.parentId);

  final String parentId;

  @override
  List<Object?> get props => [parentId];
}

class SelectPlaceProfile extends QuestionnaireEvent {
  const SelectPlaceProfile({required this.place, required this.parentPlace});

  final PlaceOfBirth? place;
  final PlaceOfBirth? parentPlace;

  @override
  List<Object?> get props => [place, parentPlace];
}

class SelectCurrentPlaceProfile extends QuestionnaireEvent {
  const SelectCurrentPlaceProfile({required this.currentPlace, required this.currentParentPlace});

  final PlaceOfBirth? currentPlace;
  final PlaceOfBirth? currentParentPlace;

  @override
  List<Object?> get props => [currentPlace, currentParentPlace];
}

class SelectEducationStatusProfileEvent extends QuestionnaireEvent {
  const SelectEducationStatusProfileEvent(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class UnSelectEducationStatusProfileEvent extends QuestionnaireEvent {
  const UnSelectEducationStatusProfileEvent();

  @override
  List<Object?> get props => [];
}

class OnChangedHealthyProfileEvent extends QuestionnaireEvent {
  final bool isHealthy;

  const OnChangedHealthyProfileEvent(this.isHealthy);

  @override
  List<Object?> get props => [isHealthy];
}

class SelectMaritalProfileEvent extends QuestionnaireEvent {
  const SelectMaritalProfileEvent({required this.status});

  final String status;

  @override
  List<Object?> get props => [status];
}

class UnSelectMaritalProfileEvent extends QuestionnaireEvent {
  const UnSelectMaritalProfileEvent({required this.status});

  final String status;

  @override
  List<Object?> get props => [status];
}

class GetGenderTagsProfileEvent extends QuestionnaireEvent {
  const GetGenderTagsProfileEvent();

  @override
  List<Object?> get props => [];
}

class SelectGenderTagsProfileEvent extends QuestionnaireEvent {
  const SelectGenderTagsProfileEvent(this.genderTags);

  final GenderTags? genderTags;

  @override
  List<Object?> get props => [genderTags];
}

class UnSelectGenderTagsProfileEvent extends QuestionnaireEvent {
  const UnSelectGenderTagsProfileEvent(this.name);

  final String? name;

  @override
  List<Object?> get props => [name];
}

class SelectLangProfileEvent extends QuestionnaireEvent {
  const SelectLangProfileEvent({required this.language});

  final String language;

  @override
  List<Object?> get props => [language];
}

class UnSelectLangProfileEvent extends QuestionnaireEvent {
  const UnSelectLangProfileEvent({required this.language});

  final String language;

  @override
  List<Object?> get props => [language];
}

class ChangeHouseStatusEvent extends QuestionnaireEvent {
  const ChangeHouseStatusEvent({required this.status});

  final String status;

  @override
  List<Object?> get props => [status];
}

class SelectChildPlanEvent extends QuestionnaireEvent {
  const SelectChildPlanEvent({required this.plan});

  final String plan;

  @override
  List<Object?> get props => [plan];
}

class ChangeChildCountEvent extends QuestionnaireEvent {
  const ChangeChildCountEvent({required this.count});

  final int count;

  @override
  List<Object?> get props => [count];
}

class ChangeNumberOfChildrenEvent extends QuestionnaireEvent {
  const ChangeNumberOfChildrenEvent({required this.count});

  final int count;

  @override
  List<Object?> get props => [count];
}

class ChangeWhatChildEvent extends QuestionnaireEvent {
  const ChangeWhatChildEvent({required this.count});

  final int count;

  @override
  List<Object?> get props => [count];
}

class ClearEvent extends QuestionnaireEvent {
  const ClearEvent();

  @override
  List<Object?> get props => [];
}

class CreateQuestionnaireEvent extends QuestionnaireEvent {
  const CreateQuestionnaireEvent({
    required this.name,
    required this.height,
    required this.weight,
    required this.workPlace,
    required this.profession,
    required this.skills,
    required this.bio,
    required this.requirements,
    required this.healthIssues,
  });

  final String name;
  final String height;
  final String weight;
  final String workPlace;
  final String profession;
  final String skills;
  final String bio;
  final String requirements;
  final String? healthIssues;

  @override
  List<Object?> get props => [
        name,
        height,
        weight,
        workPlace,
        profession,
        skills,
        bio,
        requirements,
        healthIssues,
      ];
}

class AutoFillEvent extends QuestionnaireEvent {
  const AutoFillEvent(this.user);

  final UserModel user;

  @override
  List<Object?> get props => [user];
}

class EditProfileEvent extends QuestionnaireEvent {
  const EditProfileEvent({
    required this.name,
    required this.height,
    required this.weight,
    required this.workPlace,
    required this.profession,
    required this.skills,
    required this.bio,
    required this.requirements,
    required this.healthIssues,
    required this.attachments,
    required this.sharedWithUsers,
  });

  final String name;
  final String height;
  final String weight;
  final String workPlace;
  final String profession;
  final String skills;
  final String bio;
  final String requirements;
  final String? healthIssues;
  final List<Attachments>? attachments;
  final List<String>? sharedWithUsers;

  @override
  List<Object?> get props => [
        name,
        height,
        weight,
        workPlace,
        profession,
        skills,
        bio,
        requirements,
        healthIssues,
        attachments,
        attachments,
      ];
}

class SetUserData extends QuestionnaireEvent {
  const SetUserData({
    this.place,
    this.parentPlace,
    this.currentPlace,
    this.currentParentPlace,
  });

  final PlaceOfBirth? place;
  final PlaceOfBirth? parentPlace;
  final PlaceOfBirth? currentPlace;
  final PlaceOfBirth? currentParentPlace;

  @override
  List<Object?> get props => [
        place,
        parentPlace,
        currentPlace,
        currentParentPlace,
      ];
}

class FillDataEvent extends QuestionnaireEvent {
  const FillDataEvent({required this.profileModel});

  final ProfileModel? profileModel;

  @override
  List<Object?> get props => [profileModel];
}
