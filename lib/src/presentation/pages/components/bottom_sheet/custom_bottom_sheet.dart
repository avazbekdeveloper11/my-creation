import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/pages/main/main_page.dart';
import '../../../../core/extension/extension.dart';

Future<T?> customCupertinoModalPopup<T>(
  BuildContext context, {
  String title = '',
  String actionTitleOne = '',
  String actionTitleTwo = '',
  required void Function() actionOne,
  void Function()? actionTwo,
}) async =>
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColor.black,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: actionOne,
            child: Text(
              actionTitleOne,
              style: TextStyle(color: AppColor.mainColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          if (actionTitleTwo.isNotEmpty) ...{
            CupertinoActionSheetAction(
              onPressed: actionTwo ?? () {},
              child: Text(
                actionTitleTwo,
                style: TextStyle(color: AppColor.mainColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          }
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'cancel'.tr(),
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

typedef WidgetScrollBuilder = Widget Function(
  BuildContext context,
  ScrollController? controller,
);

Future<T?> customModalBottomSheet<T>({
  required BuildContext context,
  required WidgetScrollBuilder builder,
  bool isScrollControlled = false,
  bool enableDrag = true,
  bool isDismissible = true,
}) async =>
    showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      enableDrag: enableDrag,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: context.kSize.height * 0.9,
        minHeight: context.kSize.height * 0.2,
      ),
      builder: (_) {
        if (isScrollControlled) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.5,
            expand: false,
            snap: true,
            builder: (context, controller) => builder(context, controller),
          );
        } else {
          return builder(context, null);
        }
      },
    );

Future<void> showQuestionnaireRequired() async {
  if (localSource.requiredQuestionnaire && localSource.profileId.isEmpty && localSource.accessToken.isNotEmpty) {
    customModalBottomSheet(
      context: rootNavigatorKey.currentContext!,
      builder: (_, controller) => Container(
        height: 0.23.sh,
        width: 1.sw,
        margin: AppUtils.kPaddingAllB16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppUtils.kBorderRadiusTop16,
        ),
        child: Column(
          children: [
            Text(
              'questionnaire_required'.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.verticalSpace,
            Text(
              'questionnaire_text'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            SafeArea(
              child: AppButton(
                colors: [AppColor.mainColor, AppColor.mainColor],
                width: 1.sw,
                onPressed: () {
                  rootNavigatorKey.currentContext!.pop();
                  rootNavigatorKey.currentContext!.push(
                    Routes.main,
                    extra: MainArgs(
                      index: 3,
                    ),
                  );
                },
                title: 'navigate_profile'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
