import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

class HouseThereBottomSheet extends StatelessWidget {
  const HouseThereBottomSheet({super.key, required this.title, this.children});

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
                      bool isSelect = state.houseStatus == children?[index];
                      return ListTile(
                        onTap: () {
                          if (isSelect) {
                            context.read<QuestionnaireBloc>().add(
                                  ChangeHouseStatusEvent(status: ''),
                                );
                          } else {
                            context
                              ..read<QuestionnaireBloc>().add(
                                ChangeHouseStatusEvent(status: children?[index] ?? ''),
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
