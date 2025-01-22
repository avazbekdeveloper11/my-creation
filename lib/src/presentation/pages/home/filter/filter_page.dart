import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/city_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/custom_slider.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/more_select_widget.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/place_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/place_selector.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/marital_status_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/know_lang_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/nationality_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/gender_tag_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/education_sheet.dart';

import '../../../../data/models/home/user_model.dart';

part 'mixin/filter_mixin.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with FilterMixin {
  bool isHealthy = true;

  @override
  Widget build(BuildContext context) => BlocBuilder<FilterBloc, FilterState>(
        buildWhen: (previous, current) =>
            previous.isHealthy != current.isHealthy ||
            previous.ageRange != current.ageRange ||
            previous.heightRange != current.heightRange ||
            previous.weightRange != current.weightRange ||
            previous.nationality != current.nationality ||
            previous.education != current.education ||
            previous.genderTagsSelected != current.genderTagsSelected ||
            previous.currentPlace != current.currentParentPlace ||
            previous.maritalStatus != current.maritalStatus ||
            previous.knownLanguages != current.knownLanguages ||
            previous.place != current.place && previous.parentPlace != current.parentPlace ||
            previous.km != current.km,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              title: AppText('filter'.tr(), size: 14.sp, fontWeight: FontWeight.w600),
              actions: [
                IconButton(
                  onPressed: clearFilter,
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      CustomSlider(
                        title: 'age3'.tr(),
                        values: state.ageRange,
                        min: 22,
                        max: 82,
                        interval: 5,
                        onChangeEnd: (v) {},
                        onChanged: (v) {
                          context.read<FilterBloc>().add(OnChangedAgeEvent(v));
                        },
                      ),
                      CustomSlider(
                        title: 'height3'.tr(),
                        values: state.heightRange,
                        min: 140,
                        max: 200,
                        interval: 10,
                        onChangeEnd: (v) {},
                        onChanged: (v) {
                          context.read<FilterBloc>().add(OnChangedHeightEvent(v));
                        },
                      ),
                      CustomSlider(
                        title: 'weight3'.tr(),
                        min: 40,
                        max: 160,
                        interval: 20,
                        values: state.weightRange,
                        onChangeEnd: (v) {},
                        onChanged: (v) {
                          context.read<FilterBloc>().add(OnChangedWeightEvent(v));
                        },
                      ),
                      AppUtils.kGap12,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'Masofa (km)',
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 1000,
                        divisions: 100,
                        value: state.km.toDouble(),
                        label: '${state.km} km',
                        activeColor: AppColor.mainColor,
                        onChanged: (v) => context.read<FilterBloc>().add(OnChangeKm(v.toInt())),
                      ),
                      RadioListTile(
                        value: true,
                        activeColor: AppColor.mainColor.withOpacity(0.8),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        groupValue: state.isHealthy,
                        title: Text('healthy'.tr()),
                        onChanged: (value) {
                          context.read<FilterBloc>().add(OnChangedHealthyEvent(true));
                        },
                      ),
                      RadioListTile(
                        value: false,
                        activeColor: AppColor.mainColor.withOpacity(0.8),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        groupValue: state.isHealthy,
                        title: Text('unhealthy'.tr()),
                        onChanged: (bool? value) {
                          context.read<FilterBloc>().add(OnChangedHealthyEvent(false));
                        },
                      ),
                      8.verticalSpace,
                      PlaceSelectorWidget(
                        hasClear: true,
                        onClear: () {
                          context.read<FilterBloc>().add(
                                SelectPlace(place: PlaceOfBirth(), parentPlace: PlaceOfBirth()),
                              );
                        },
                        place: state.place,
                        parentPlace: state.parentPlace,
                        title: 'placeOfBirth3'.tr(),
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>()..add(GetPlacesEvent()),
                                child: PlaceBottomSheet(
                                  onTap: (PlaceOfBirth? place) {
                                    context.pop();
                                    customModalBottomSheet(
                                      context: context,
                                      builder: (context, controller) {
                                        return BlocProvider.value(
                                          value: sl<FilterBloc>()..add(GetParentPlacesEvent(place?.id ?? '')),
                                          child: CityBottomSheet(
                                            onTap: (PlaceOfBirth? parent) {
                                              context
                                                ..read<FilterBloc>().add(
                                                  SelectPlace(place: place, parentPlace: parent),
                                                )
                                                ..pop();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      12.verticalSpace,
                      PlaceSelectorWidget(
                        hasClear: true,
                        onClear: () {
                          context.read<FilterBloc>().add(
                                SelectCurrentPlace(currentParentPlace: PlaceOfBirth(), currentPlace: PlaceOfBirth()),
                              );
                        },
                        place: state.currentPlace,
                        parentPlace: state.currentParentPlace,
                        title: 'dwPlace3'.tr(),
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>()..add(GetPlacesEvent()),
                                child: PlaceBottomSheet(
                                  onTap: (PlaceOfBirth? place) {
                                    context.pop();
                                    customModalBottomSheet(
                                      context: context,
                                      builder: (context, controller) {
                                        return BlocProvider.value(
                                          value: sl<FilterBloc>()..add(GetParentPlacesEvent(place?.id ?? '')),
                                          child: CityBottomSheet(
                                            onTap: (PlaceOfBirth? parent) {
                                              context
                                                ..read<FilterBloc>().add(
                                                  SelectCurrentPlace(
                                                    currentPlace: place,
                                                    currentParentPlace: parent,
                                                  ),
                                                )
                                                ..pop();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      12.verticalSpace,
                      MoreSelectWidget(
                        title: 'maritalStatus3'.tr(),
                        children: state.maritalStatus.isNotEmpty ? [state.maritalStatus] : [],
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>(),
                                child: MaritalStatusSheet(
                                  title: 'maritalStatus3'.tr(),
                                  children: [
                                    'UNMARRIED',
                                    'DIVORCED_THROUGH_COURT',
                                    'DIVORCED_NOT_THROUGH_COURT',
                                    'WIDOW',
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        onClose: (value) {
                          context.read<FilterBloc>().add(UnSelectMaritalEvent(status: value));
                        },
                      ),
                      12.verticalSpace,
                      MoreSelectWidget(
                        title: 'education'.tr(),
                        children: state.education.isNotEmpty ? [state.education] : [],
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>(),
                                child: EducationSheet(
                                  title: 'education'.tr(),
                                  children: Constants.educationStatus,
                                ),
                              );
                            },
                          );
                        },
                        onClose: (value) {
                          context.read<FilterBloc>().add(UnSelectEducationStatusEvent());
                        },
                      ),
                      12.verticalSpace,
                      MoreSelectWidget(
                        title: 'knowledgeLanguages3'.tr(),
                        children: state.knownLanguages,
                        onClose: (String value) {
                          context.read<FilterBloc>().add(UnSelectLangEvent(language: value));
                        },
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>(),
                                child: KnowLangSheet(
                                  title: 'knowledgeLanguages3'.tr(),
                                  children: Constants.languages,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      12.verticalSpace,
                      MoreSelectWidget(
                        title: 'nationality3'.tr(),
                        children: (state.nationality?.isNotEmpty ?? false)
                            ? [...?state.nationality?.map((e) => e.localization?.localizedValue ?? '')]
                            : [],
                        onClose: (String? v) {
                          context.read<FilterBloc>().add(UnSelectNationalityEvent(v));
                        },
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>()..add(GetNationalityEvent()),
                                child: NationalitySheet(
                                  title: 'nationality3'.tr(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      12.verticalSpace,
                      MoreSelectWidget(
                        title: 'gender_tag'.tr(),
                        onClose: (String v) {
                          context.read<FilterBloc>().add(UnSelectGenderTagsEvent(v));
                        },
                        children: state.genderTagsSelected?.map((e) => e.localization?.localizedValue ?? '').toList(),
                        onTap: () {
                          customModalBottomSheet(
                            context: context,
                            builder: (context, controller) {
                              return BlocProvider.value(
                                value: sl<FilterBloc>()..add(GetGenderTagsEvent(isFilter: true)),
                                child: GenderTagSheet(
                                  title: 'gender_tag'.tr(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: AppButton(
                colors: [AppColor.mainColor, AppColor.mainColor],
                onPressed: () => onFilter(state),
                title: 'do_filter'.tr(),
                height: 36.h,
              ),
            ),
          );
        },
      );
}
