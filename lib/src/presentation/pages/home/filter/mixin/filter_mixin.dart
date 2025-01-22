part of '../filter_page.dart';

mixin FilterMixin on State<FilterScreen> {
  @override
  void initState() {
    context.read<FilterBloc>().add(SetFilterEvent());
    super.initState();
  }

  void onFilter(FilterState state) {
    Map<String, dynamic> filter = {
      "height.greaterThan": state.heightRange.start.toString().replaceFirst('.0', ''),
      "height.lessThan": state.heightRange.end.toString().replaceFirst('.0', ''),
      "weight.greaterThan": state.weightRange.start.toString().replaceFirst('.0', ''),
      "weight.lessThan": state.weightRange.end.toString().replaceFirst('.0', ''),
      "education.in": [state.education],
      "isHealthy.equals": state.isHealthy,
      "age.greaterThan": state.ageRange.start.toString().replaceFirst('.0', ''),
      "age.lessThan": state.ageRange.end.toString().replaceFirst('.0', ''),
      "placeOfBirth.in": [state.place?.toJson() ?? '{}', state.parentPlace?.toJson() ?? '{}'],
      "dwellingPlace.in": [state.currentPlace?.toJson() ?? '{}', state.currentParentPlace?.toJson() ?? '{}'],
      "maritalStatus.in": [state.maritalStatus],
      "knowledgeOfLanguages.in": [...?state.knownLanguages],
      "nationalityId.in": [...?state.nationality?.map((e) => e.toJson())],
      "genderTagsId.in": [...?state.genderTagsSelected?.map((e) => e.toJson())],
      "km": state.km
    };

    if (state.education.isEmpty) {
      filter.remove("education.in");
    }
    if (state.place?.id == null) {
      filter.remove("placeOfBirth.in");
    }
    if (state.currentPlace?.id == null) {
      filter.remove("dwellingPlace.in");
    }
    if (state.maritalStatus.isEmpty) {
      filter.remove("maritalStatus.in");
    }
    if (state.knownLanguages?.isEmpty ?? true) {
      filter.remove("knowledgeOfLanguages.in");
    }
    if (state.nationality?.isEmpty ?? true) {
      filter.remove("nationalityId.in");
    }
    if (state.genderTagsSelected?.isEmpty ?? true) {
      filter.remove("genderTagsId.in");
    }
    if (state.ageRange.start == 22 && state.ageRange.end == 82) {
      filter.remove('age.lessThan');
      filter.remove('age.greaterThan');
    }
    if (state.heightRange.start == 140 && state.heightRange.end == 200) {
      filter.remove('height.lessThan');
      filter.remove('height.greaterThan');
    }
    if (state.isHealthy) {
      filter.remove('isHealthy.equals');
    }
    if (state.weightRange.start == 40 && state.weightRange.end == 160) {
      filter.remove('weight.lessThan');
      filter.remove('weight.greaterThan');
    }

    localSource.setKey(
      AppKeys.filterCache,
      jsonEncode(filter),
    );

    context.pop(filter);
  }

  void clearFilter() {
    customCupertinoModalPopup(
      context,
      title: 'confirm_filter_clear'.tr(),
      actionTitleOne: 'yes'.tr(),
      actionOne: () {
        localSource.deleteKey(AppKeys.filterCache);

        context
          ..read<FilterBloc>().add(OnFilterClear())
          ..pop()
          ..pop();
      },
      actionTwo: () => context.pop(),
    );
  }
}
