import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_big_text_field.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_text_field.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/masked_text_input_formatter.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/child_plan_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/city_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/counter_widget.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/education_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/gender_tag_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/home_there_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/know_lang_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/marital_status_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/more_select_widget.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/nationality_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/place_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/place_selector.dart';

import '../../components/app_button/app_button.dart';

part '../mixin/edit_profile_mixin.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profile});

  final ProfileModel? profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with EditProfileMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionnaireBloc, QuestionnaireState>(
      listenWhen: (p, c) => p.editProfileApiStatus != c.editProfileApiStatus,
      listener: (context, state) {
        if (state.editProfileApiStatus.isSuccess) {
          context.pop(true);
          context.showFloatingSnackBar(
            message: 'profile_updated_successfully'.tr(),
            backgroundColor: Colors.green,
          );
        } else if (state.editProfileApiStatus.isError) {
          context.showFloatingSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Visibility(
              visible: appBarShow,
              child: Text(
                'edit_anketa'.tr(),
              ),
            ),
            elevation: appBarShow ? null : 0,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SafeArea(
                child: Column(
                  children: [
                    AppUtils.kGap20,
                    Text(
                      'edit_anketa'.tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomTextField(
                        isRequired: true,
                        titleText: 'name'.tr(),
                        hintText: 'name_hint'.tr(),
                        controller: nameController,
                        focusNode: nameFocusNode,
                        nextFocus: heightFocusNode,
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        validator: (v) {
                          if (v?.isNotEmpty ?? false) {
                            return null;
                          } else {
                            return 'name_hint'.tr();
                          }
                        },
                      ),
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0.435.sw,
                            child: CustomTextField(
                              isRequired: true,
                              titleText: 'height'.tr(),
                              hintText: 'height_hint'.tr(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskedTextInputFormatter(mask: '###', separator: '***', filter: RegExp(r'[0-9]'))
                              ],
                              controller: heightController,
                              focusNode: heightFocusNode,
                              nextFocus: weightFocusNode,
                              autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                              validator: (v) {
                                if (v?.isNotEmpty ?? false) {
                                  return null;
                                } else {
                                  return 'height_hint'.tr();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 0.435.sw,
                            child: CustomTextField(
                              isRequired: true,
                              titleText: 'weight'.tr(),
                              hintText: 'weight_hint'.tr(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskedTextInputFormatter(mask: '###', separator: '***', filter: RegExp(r'[0-9]'))
                              ],
                              controller: weightController,
                              focusNode: weightFocusNode,
                              nextFocus: workPlaceFocusNode,
                              autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                              validator: (v) {
                                if (v?.isNotEmpty ?? false) {
                                  return null;
                                } else {
                                  return 'weight_hint'.tr();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      isRequired: true,
                      errorText:
                          (state.nationality?.id == null) && autoValidate ? 'please_complete_this_field'.tr() : '',
                      margin: AppUtils.kPaddingHorizontal16,
                      title: 'nationality'.tr(),
                      children: (state.nationality?.id?.isNotEmpty ?? false)
                          ? [state.nationality?.localization?.localizedValue ?? '']
                          : [],
                      onClose: (String? v) {
                        context.read<QuestionnaireBloc>().add(UnSelectNationalityProfileEvent(v));
                      },
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>()..add(GetNationalityEvent()),
                              child: NationalitySheetProfile(
                                title: 'nationality3'.tr(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppUtils.kGap20,
                    PlaceSelectorWidget(
                      isRequired: true,
                      errorText: state.parentPlace?.id == null && autoValidate ? 'please_complete_this_field'.tr() : '',
                      margin: AppUtils.kPaddingHorizontal16,
                      place: state.place,
                      parentPlace: state.parentPlace,
                      title: 'placeOfBirth'.tr(),
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>()..add(GetPlacesProfileEvent()),
                              child: PlaceBottomSheetProfile(
                                onTap: (place) {
                                  context.pop();
                                  customModalBottomSheet(
                                    context: context,
                                    builder: (context, controller) {
                                      return BlocProvider.value(
                                        value: sl<QuestionnaireBloc>()
                                          ..add(GetParentPlacesProfileEvent(place?.id ?? '')),
                                        child: CityBottomSheetProfile(
                                          onTap: (parent) {
                                            context
                                              ..read<QuestionnaireBloc>().add(
                                                SelectPlaceProfile(place: place, parentPlace: parent),
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
                    AppUtils.kGap20,
                    PlaceSelectorWidget(
                      isRequired: true,
                      errorText:
                          state.currentParentPlace?.id == null && autoValidate ? 'please_complete_this_field'.tr() : '',
                      margin: AppUtils.kPaddingHorizontal16,
                      place: state.currentPlace,
                      parentPlace: state.currentParentPlace,
                      title: 'dwellingPlace'.tr(),
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>()..add(GetPlacesProfileEvent()),
                              child: PlaceBottomSheetProfile(
                                onTap: (place) {
                                  context.pop();
                                  customModalBottomSheet(
                                    context: context,
                                    builder: (context, controller) {
                                      return BlocProvider.value(
                                        value: sl<QuestionnaireBloc>()
                                          ..add(GetParentPlacesProfileEvent(place?.id ?? '')),
                                        child: CityBottomSheetProfile(
                                          onTap: (parent) {
                                            context
                                              ..read<QuestionnaireBloc>().add(
                                                SelectCurrentPlaceProfile(
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
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      isRequired: true,
                      errorText: state.education.isEmpty && autoValidate ? 'please_complete_this_field'.tr() : '',
                      margin: AppUtils.kPaddingHorizontal16,
                      title: 'education'.tr(),
                      children: state.education.isNotEmpty ? [state.education] : [],
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>(),
                              child: EducationSheetProfile(
                                title: 'education'.tr(),
                                children: Constants.educationStatus,
                              ),
                            );
                          },
                        );
                      },
                      onClose: (value) {
                        context.read<QuestionnaireBloc>().add(UnSelectEducationStatusProfileEvent());
                      },
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHor16Ver12,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'health'.tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              height: 14 / 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: RadioListTile(
                        value: true,
                        tileColor: Colors.transparent,
                        activeColor: AppColor.mainColor.withOpacity(0.8),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        groupValue: state.isHealthy,
                        title: Text('healthy'.tr()),
                        onChanged: (value) {
                          context.read<QuestionnaireBloc>().add(OnChangedHealthyProfileEvent(true));
                        },
                      ),
                    ),
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: RadioListTile(
                        value: false,
                        tileColor: Colors.transparent,
                        activeColor: AppColor.mainColor.withOpacity(0.8),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        groupValue: state.isHealthy,
                        title: Text('unhealthy'.tr()),
                        onChanged: (bool? value) {
                          context.read<QuestionnaireBloc>().add(OnChangedHealthyProfileEvent(false));
                        },
                      ),
                    ),
                    AppUtils.kGap12,
                    AnimatedContainer(
                      height: state.isHealthy ? 0 : 62.h,
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: AppUtils.kPaddingHorizontal16,
                          child: CustomTextField(
                            isRequired: true,
                            titleText: 'healthy_title'.tr(),
                            hintText: 'healthy_hint'.tr(),
                            controller: healthyStatusController,
                            focusNode: healthyStatusFocusNode,
                            nextFocus: workPlaceFocusNode,
                            autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                          ),
                        ),
                      ),
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      isRequired: true,
                      errorText: state.maritalStatus.isEmpty && autoValidate ? 'please_complete_this_field'.tr() : '',
                      title: 'maritalStatus3'.tr(),
                      margin: AppUtils.kPaddingHorizontal16,
                      children: state.maritalStatus.isNotEmpty ? [state.maritalStatus] : [],
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>(),
                              child: MaritalStatusSheetProfile(
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
                        context.read<QuestionnaireBloc>().add(UnSelectMaritalProfileEvent(status: value));
                      },
                    ),
                    AnimatedContainer(
                      height: !((state.maritalStatus) == 'UNMARRIED') ? 80.h : 0,
                      width: 1.sw,
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: CounterWidget(
                          count: state.childCount,
                          title: 'numOfChildrenInFamily'.tr(),
                          addOnTap: () {
                            context.read<QuestionnaireBloc>().add(
                                  ChangeChildCountEvent(
                                    count: ((state.childCount ?? 0) + 1),
                                  ),
                                );
                          },
                          removeOnTap: () {
                            context.read<QuestionnaireBloc>().add(
                                  ChangeChildCountEvent(
                                    count: ((state.childCount ?? 0) - 1),
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomTextField(
                          isRequired: true,
                          titleText: 'workPlace'.tr(),
                          hintText: 'workPlaceHint'.tr(),
                          controller: workPlaceController,
                          focusNode: workPlaceFocusNode,
                          nextFocus: professionFocusNode,
                          autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                          validator: (v) {
                            if (v?.isNotEmpty ?? true) {
                              return null;
                            } else {
                              return 'please_complete_this_field'.tr();
                            }
                          }),
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      isRequired: true,
                      errorText: state.houseStatus.isEmpty && autoValidate ? 'please_complete_this_field'.tr() : '',
                      title: 'hasOwnDwelling'.tr(),
                      children: state.houseStatus.isNotEmpty ? [state.houseStatus] : [],
                      onClose: (v) {
                        context.read<QuestionnaireBloc>().add(ChangeHouseStatusEvent(status: ''));
                      },
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>(),
                              child: HouseThereBottomSheet(
                                title: 'hasOwnDwelling'.tr(),
                                children: [
                                  'NOT_SPECIFIED',
                                  'EXISTS',
                                  'DOES_NOT_EXIST',
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      title: 'gender_tag'.tr(),
                      margin: AppUtils.kPaddingHorizontal16,
                      onClose: (String v) {
                        context.read<QuestionnaireBloc>().add(UnSelectGenderTagsProfileEvent(v));
                      },
                      children: state.genderTagsSelected?.map((e) => e.localization?.localizedValue ?? '').toList(),
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>()..add(GetGenderTagsProfileEvent()),
                              child: GenderTagSheetProfile(
                                title: 'gender_tag'.tr(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomTextField(
                        isRequired: true,
                        titleText: 'profession'.tr(),
                        hintText: 'profession_hint'.tr(),
                        controller: professionController,
                        focusNode: professionFocusNode,
                        nextFocus: skillsFocusNode,
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        validator: (v) {
                          if (v?.isNotEmpty ?? false) {
                            return null;
                          } else {
                            return 'profession_hint'.tr();
                          }
                        },
                      ),
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      isRequired: true,
                      errorText:
                          (state.childPlan?.isEmpty ?? false) && autoValidate ? 'please_complete_this_field'.tr() : '',
                      title: 'childPlan'.tr(),
                      margin: AppUtils.kPaddingHorizontal16,
                      onClose: (String v) {
                        context.read<QuestionnaireBloc>().add(UnSelectGenderTagsProfileEvent(v));
                      },
                      children: (state.childPlan?.isNotEmpty ?? false) ? [state.childPlan.toString()] : [],
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>()..add(GetGenderTagsProfileEvent()),
                              child: ChildPlanBottomSheet(
                                title: 'childPlan'.tr(),
                                children: [
                                  'WANT_CHILDREN',
                                  'DONT_WANT_CHILDREN',
                                  'HAVE_CHILDREN_AND_WANT_MORE',
                                  'HAVE_CHILDREN_AND_DONT_WANT_MORE',
                                  'NOT_SURE_YET',
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppUtils.kGap12,
                    CounterWidget(
                      count: state.numberOfChildren,
                      title: 'numOfMembersInFamily'.tr(),
                      addOnTap: () {
                        context.read<QuestionnaireBloc>().add(
                              ChangeNumberOfChildrenEvent(
                                count: ((state.numberOfChildren ?? 0) + 1),
                              ),
                            );
                      },
                      removeOnTap: () {
                        context.read<QuestionnaireBloc>().add(
                              ChangeNumberOfChildrenEvent(
                                count: ((state.numberOfChildren ?? 0) - 1),
                              ),
                            );
                      },
                    ),
                    AnimatedContainer(
                      height: !((state.numberOfChildren ?? 0) <= 1) ? 80.h : 0,
                      width: 1.sw,
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: CounterWidget(
                          count: state.whatChild,
                          title: 'birthPositionInFamily'.tr(),
                          addOnTap: () {
                            if ((state.numberOfChildren ?? 0) > (state.whatChild ?? 0)) {
                              context.read<QuestionnaireBloc>().add(
                                    ChangeWhatChildEvent(
                                      count: ((state.whatChild ?? 0) + 1),
                                    ),
                                  );
                            }
                          },
                          removeOnTap: () {
                            context.read<QuestionnaireBloc>().add(
                                  ChangeWhatChildEvent(
                                    count: ((state.whatChild ?? 0) - 1),
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    AppUtils.kGap20,
                    MoreSelectWidget(
                      title: 'knowledgeOfLanguages'.tr(),
                      children: state.knownLanguages,
                      onClose: (String value) {
                        context.read<QuestionnaireBloc>().add(UnSelectLangProfileEvent(language: value));
                      },
                      onTap: () {
                        customModalBottomSheet(
                          context: context,
                          builder: (context, controller) {
                            return BlocProvider.value(
                              value: sl<QuestionnaireBloc>(),
                              child: KnowLangSheetProfile(
                                title: 'knowledgeOfLanguages'.tr(),
                                children: Constants.languages,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomBigTextField(
                        titleText: 'skills'.tr(),
                        hintText: 'skills_hint'.tr(),
                        controller: skillsController,
                        focusNode: skillsFocusNode,
                        nextFocus: bioFocusNode,
                      ),
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomBigTextField(
                        titleText: 'bio'.tr(),
                        hintText: 'bio_hint'.tr(),
                        controller: bioController,
                        focusNode: bioFocusNode,
                        nextFocus: requirementsFocusNode,
                      ),
                    ),
                    AppUtils.kGap20,
                    Padding(
                      padding: AppUtils.kPaddingHorizontal16,
                      child: CustomBigTextField(
                        titleText: 'requirements'.tr(),
                        hintText: 'requirements_hint'.tr(),
                        controller: requirementsController,
                      ),
                    ),
                    AppUtils.kGap16,
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            minimum: AppUtils.kPaddingHorizontal16.copyWith(bottom: 8.h),
            child: AppButton(
              colors: [AppColor.mainColor, AppColor.mainColor],
              width: 1.sw,
              onPressed: () {
                autoValidate = true;
                if ((formKey.currentState?.validate() ?? false) &&
                    state.houseStatus.isNotEmpty &&
                    state.maritalStatus.isNotEmpty &&
                    state.education.isNotEmpty &&
                    (state.currentParentPlace?.id?.isNotEmpty ?? false) &&
                    (state.parentPlace?.id?.isNotEmpty ?? false) &&
                    (state.nationality?.id?.isNotEmpty ?? false) &&
                    (state.childPlan?.isNotEmpty ?? false)) {
                  context.read<QuestionnaireBloc>().add(
                        EditProfileEvent(
                          name: nameController.text.trim(),
                          height: heightController.text.trim(),
                          weight: weightController.text.trim(),
                          workPlace: workPlaceController.text.trim(),
                          profession: professionController.text.trim(),
                          skills: skillsController.text.trim(),
                          bio: bioController.text.trim(),
                          requirements: requirementsController.text.trim(),
                          healthIssues: healthyStatusController.text.trim(),
                          attachments: widget.profile?.attachments,
                          sharedWithUsers: widget.profile?.sharedWithUsers,
                        ),
                      );
                } else {
                  if (nameController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      60,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      nameFocusNode.requestFocus();
                    });
                  } else if (heightController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      170,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      heightFocusNode.requestFocus();
                    });
                  } else if (weightController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      170,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      weightFocusNode.requestFocus();
                    });
                  } else if (workPlaceController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      940,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      workPlaceFocusNode.requestFocus();
                    });
                  } else if (professionController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      1150,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      professionFocusNode.requestFocus();
                    });
                  } else if (skillsController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      1470,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      skillsFocusNode.requestFocus();
                    });
                  } else if (bioController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      1480,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      bioFocusNode.requestFocus();
                    });
                  } else if (requirementsController.text.isEmpty) {
                    _scrollController
                        .animateTo(
                      1490,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    )
                        .then((v) {
                      requirementsFocusNode.requestFocus();
                    });
                  }
                }
              },
              title: 'save'.tr(),
              child: state.editProfileApiStatus.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
