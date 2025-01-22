import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

import '../../../data/models/home/user_model.dart';

class PlaceSelectorWidget extends StatelessWidget {
  const PlaceSelectorWidget({
    super.key,
    required this.title,
    this.onTap,
    this.place,
    this.parentPlace,
    this.margin,
    this.isRequired = false,
    this.errorText,
    this.hasClear = false,
    this.onClear,
  });

  final String title;
  final PlaceOfBirth? place;
  final PlaceOfBirth? parentPlace;
  final Function()? onTap;
  final EdgeInsets? margin;
  final bool isRequired;
  final String? errorText;
  final bool hasClear;
  final Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1.sw,
          margin: margin ?? EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColor.iconsColor.withOpacity(0.05),
            borderRadius: AppUtils.kBorderRadius8,
            border: (errorText?.isNotEmpty ?? false) ? Border.all(color: Colors.red, width: 1.5) : null,
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: AppUtils.kBorderRadius8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 14 / 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: isRequired ? ' *' : '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    height: 14 / 12,
                                    color: AppColor.errorColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          2.verticalSpace,
                          ((place?.localization?.localizedValue.isNotEmpty ?? false) &&
                                  (parentPlace?.localization?.localizedValue.isNotEmpty ?? false))
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      place?.localization?.localizedValue ?? '',
                                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    2.horizontalSpace,
                                    Icon(Icons.arrow_forward_rounded, size: 12.sp),
                                    2.horizontalSpace,
                                    Text(
                                      parentPlace?.localization?.localizedValue ?? '',
                                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              : AppUtils.kGap,
                        ],
                      ),
                      hasClear && (place?.localization?.localizedValue.isNotEmpty ?? false)
                          ? InkWell(
                              onTap: onClear,
                              child: Icon(Icons.close),
                            )
                          : Icon(Icons.arrow_forward_ios_sharp, size: 14.sp)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        (errorText?.isNotEmpty ?? false)
            ? Padding(
                padding: margin?.copyWith(top: 4.h) ?? EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 4.h),
                child: Text(
                  errorText.toString(),
                  style: TextStyle(color: Colors.red, fontSize: 11.sp),
                ),
              )
            : AppUtils.kGap,
      ],
    );
  }
}
