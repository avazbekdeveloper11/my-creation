import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

class NationalitySheet extends StatelessWidget {
  const NationalitySheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) =>
          previous.nationalityApiStatus != current.nationalityApiStatus || previous.nationality != current.nationality,
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
                child: !state.nationalityApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.nationalities?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            bool isSelect = (state.nationality?.contains(state.nationalities?[index]) ?? false);
                            return ListTile(
                              onTap: () {
                                if (isSelect) {
                                  context.read<FilterBloc>().add(
                                        UnSelectNationalityEvent(
                                          state.nationalities?[index].localization?.localizedValue,
                                        ),
                                      );
                                } else {
                                  context.read<FilterBloc>().add(
                                        SelectNationalityEvent(state.nationalities?[index]),
                                      );
                                }
                              },
                              title: Text(state.nationalities?[index].localization?.localizedValue ?? ''),
                              trailing: Visibility(
                                visible: isSelect,
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

class NationalitySheetProfile extends StatelessWidget {
  const NationalitySheetProfile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      buildWhen: (previous, current) =>
          previous.nationalityApiStatus != current.nationalityApiStatus || previous.nationality != current.nationality,
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
                child: !state.nationalityApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.nationalities?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            bool isSelect = state.nationality == state.nationalities?[index];
                            return ListTile(
                              onTap: () {
                                if (isSelect) {
                                  context.read<QuestionnaireBloc>().add(
                                        UnSelectNationalityProfileEvent(
                                          state.nationalities?[index].localization?.localizedValue,
                                        ),
                                      );
                                } else {
                                  context.read<QuestionnaireBloc>().add(
                                        SelectNationalityProfileEvent(state.nationalities?[index]),
                                      );
                                  context.pop();
                                }
                              },
                              title: Text(state.nationalities?[index].localization?.localizedValue.toString() ?? ''),
                              trailing: Visibility(
                                visible: isSelect,
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
