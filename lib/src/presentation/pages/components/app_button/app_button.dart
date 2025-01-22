// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';

import '../app_text/app_text.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.fontSize,
    this.borderRadius,
    this.child,
    this.isEnabled = true,
    this.colors,
  });

  VoidCallback onPressed;
  String title;
  Widget? child;
  double? height;
  double? width;
  double? fontSize;
  BorderRadius? borderRadius;
  bool isEnabled;
  List<Color>? colors;

  @override
  Widget build(BuildContext context) => Container(
        height: height ?? 50,
        width: width ?? 150,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors ?? (isEnabled ? gradientColors : [Colors.grey, Colors.grey.shade400]),
          ),
        ),
        child: TextButton(
          onPressed: isEnabled ? onPressed : () {},
          child: child ??
              AppText(
                title,
                fontWeight: FontWeight.w600,
                textColor: AppColor.white,
                size: fontSize ?? 13.sp,
              ),
        ),
      );
}

Widget loadingWidget() =>
    const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: AppColor.white));
