import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';

void pickImageDialog(
  BuildContext context, {
  required VoidCallback onCameraPressed,
  required VoidCallback onGalleryPressed,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
    builder: (context) => Container(
      height: 150.h,
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          AppText('choose'.tr(), size: 14.sp, fontWeight: FontWeight.w600),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: onCameraPressed,
                child: Column(
                  children: [
                    Icon(MdiIcons.camera, size: 34.sp, color: gradientColors[1]),
                    SizedBox(height: 8.h),
                    AppText('camera'.tr(), textColor: gradientColors[1], size: 12.sp, fontWeight: FontWeight.w600)
                  ],
                ),
              ),
              MaterialButton(
                onPressed: onGalleryPressed,
                child: Column(
                  children: [
                    Icon(
                      MdiIcons.fileImagePlus,
                      size: 34.sp,
                      color: gradientColors[1],
                    ),
                    SizedBox(height: 8.h),
                    AppText('gallery'.tr(), textColor: gradientColors[1], size: 12.sp, fontWeight: FontWeight.w600)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
