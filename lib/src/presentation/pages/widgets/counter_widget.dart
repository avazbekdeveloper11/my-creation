import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.title,
    this.addOnTap,
    this.removeOnTap,
    this.count,
  });

  final String title;
  final Function()? addOnTap;
  final Function()? removeOnTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppUtils.kPaddingHor16Ver12,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: AppUtils.kPaddingHorizontal16,
          child: Row(
            children: [
              IconButton(
                onPressed: removeOnTap,
                icon: Icon(Icons.remove),
              ),
              AppUtils.kGap12,
              Container(
                padding: AppUtils.kPaddingHor16Ver8,
                decoration: BoxDecoration(
                  color: AppColor.iconsColor.withOpacity(0.05),
                  borderRadius: AppUtils.kBorderRadius12,
                ),
                child: Text(
                  count != null ? count.toString() : 'NOT_SPECIFIED'.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              AppUtils.kGap12,
              IconButton(
                onPressed: addOnTap,
                icon: Icon(Icons.add),
              )
            ],
          ),
        ),
      ],
    );
  }
}
