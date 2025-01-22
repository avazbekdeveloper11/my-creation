import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

class KnowLangSheet extends StatelessWidget {
  const KnowLangSheet({super.key, required this.title, this.children = const []});

  final String title;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) => previous.knownLanguages != current.knownLanguages,
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
                    itemCount: children.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      bool isSelect = -1 != state.knownLanguages?.lastIndexWhere((e) => e == children[index]);
                      return ListTile(
                        onTap: () {
                          if (isSelect) {
                            context.read<FilterBloc>().add(
                                  UnSelectLangEvent(language: children[index]),
                                );
                          } else {
                            context.read<FilterBloc>().add(
                                  SelectLangEvent(language: children[index]),
                                );
                          }
                        },
                        title: Text(children[index].toString().tr()),
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

class KnowLangSheetProfile extends StatelessWidget {
  const KnowLangSheetProfile({super.key, required this.title, this.children = const []});

  final String title;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      buildWhen: (previous, current) => previous.knownLanguages != current.knownLanguages,
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
                    itemCount: children.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      bool isSelect = -1 != state.knownLanguages?.lastIndexWhere((e) => e == children[index]);
                      return ListTile(
                        onTap: () {
                          if (isSelect) {
                            context.read<QuestionnaireBloc>().add(
                                  UnSelectLangProfileEvent(language: children[index]),
                                );
                          } else {
                            context.read<QuestionnaireBloc>().add(
                                  SelectLangProfileEvent(language: children[index]),
                                );
                          }
                        },
                        title: Text(children[index].toString().tr()),
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
