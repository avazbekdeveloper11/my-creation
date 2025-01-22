import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

class GenderTagSheet extends StatelessWidget {
  const GenderTagSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) =>
          previous.genderTagsApiStatus != current.genderTagsApiStatus ||
          previous.genderTags != current.genderTags ||
          previous.genderTagsSelected != current.genderTagsSelected,
      builder: (context, state) {
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 0.7.sh,
                child: !state.genderTagsApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.genderTags?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            bool isSelected =
                                state.genderTagsSelected?.map((e) => e.id).contains(state.genderTags?[index].id) ??
                                    false;
                            return ListTile(
                              onTap: () {
                                if (isSelected) {
                                  context.read<FilterBloc>().add(UnSelectGenderTagsEvent(
                                      state.genderTags?[index].localization?.localizedValue ?? ''));
                                } else {
                                  context.read<FilterBloc>().add(SelectGenderTagsEvent(state.genderTags?[index]));
                                }
                              },
                              title: Text(
                                state.genderTags?[index].localization?.localizedValue ?? '',
                              ),
                              trailing: Visibility(
                                visible: isSelected,
                                child: Icon(
                                  Icons.check,
                                  color: AppColor.mainColor,
                                  size: 14.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GenderTagSheetProfile extends StatelessWidget {
  const GenderTagSheetProfile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      buildWhen: (previous, current) =>
          previous.genderTagsApiStatus != current.genderTagsApiStatus ||
          previous.genderTags != current.genderTags ||
          previous.genderTagsSelected != current.genderTagsSelected,
      builder: (context, state) {
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 0.7.sh,
                child: !state.genderTagsApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.genderTags?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            bool isSelected =
                                state.genderTagsSelected?.map((e) => e.id).contains(state.genderTags?[index].id) ??
                                    false;
                            return ListTile(
                              onTap: () {
                                if (isSelected) {
                                  context.read<QuestionnaireBloc>().add(UnSelectGenderTagsProfileEvent(
                                      state.genderTags?[index].localization?.localizedValue ?? ''));
                                } else {
                                  context
                                      .read<QuestionnaireBloc>()
                                      .add(SelectGenderTagsProfileEvent(state.genderTags?[index]));
                                }
                              },
                              title: Text(
                                state.genderTags?[index].localization?.localizedValue ?? '',
                              ),
                              trailing: Visibility(
                                visible: isSelected,
                                child: Icon(
                                  Icons.check,
                                  color: AppColor.mainColor,
                                  size: 14.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
