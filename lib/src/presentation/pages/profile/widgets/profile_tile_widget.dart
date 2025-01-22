import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return (title.isEmpty || title == '0')
        ? SizedBox()
        : Padding(
            padding: AppUtils.kPaddingHorizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtils.kGap12,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.textColor.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
