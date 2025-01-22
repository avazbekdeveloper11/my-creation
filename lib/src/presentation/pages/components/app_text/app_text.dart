// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';

class AppText extends StatelessWidget {
  AppText(
    this.text, {
    super.key,
    this.size,
    this.textColor,
    this.textAlign,
    this.fontWeight,
    this.textDecoration,
    this.fontFamily,
    this.maxLines,
    this.wordSpacing,
    this.height,
    this.textOverflow,
  });
  String text;
  double? size;
  Color? textColor;
  FontWeight? fontWeight;
  int? maxLines;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
  String? fontFamily;
  double? wordSpacing;
  double? height;
  TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
            color: textColor ?? AppColor.textColor,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: size ?? 14.sp,
            fontFamily: fontFamily,
            // ?? 'Lexend',
            wordSpacing: wordSpacing,
            height: height,
            decoration: textDecoration),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      );
}
