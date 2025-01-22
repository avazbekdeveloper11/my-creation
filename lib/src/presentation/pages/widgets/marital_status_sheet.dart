import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

class MaritalStatusSheet extends StatelessWidget {
  const MaritalStatusSheet({super.key, required this.title, this.children});

  final String title;
  final List<String>? children;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) => previous.maritalStatus != current.maritalStatus,
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
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: children?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      bool isSelect = state.maritalStatus == children?[index];
                      return ListTile(
                        onTap: () {
                          if (isSelect) {
                            context.read<FilterBloc>().add(
                                  UnSelectMaritalEvent(status: children?[index] ?? ''),
                                );
                          } else {
                            context
                              ..read<FilterBloc>().add(
                                SelectMaritalEvent(status: children?[index] ?? ''),
                              )
                              ..pop();
                          }
                        },
                        title: Text((children?[index] ?? '').tr()),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MaritalStatusSheetProfile extends StatelessWidget {
  const MaritalStatusSheetProfile({super.key, required this.title, this.children});

  final String title;
  final List<String>? children;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      buildWhen: (previous, current) => previous.maritalStatus != current.maritalStatus,
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
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: children?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      bool isSelect = state.maritalStatus == children?[index];
                      return ListTile(
                        onTap: () {
                          if (isSelect) {
                            context.read<QuestionnaireBloc>().add(
                                  UnSelectMaritalProfileEvent(status: children?[index] ?? ''),
                                );
                          } else {
                            context
                              ..read<QuestionnaireBloc>().add(
                                SelectMaritalProfileEvent(status: children?[index] ?? ''),
                              )
                              ..pop();
                          }
                        },
                        title: Text((children?[index] ?? '').tr()),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
