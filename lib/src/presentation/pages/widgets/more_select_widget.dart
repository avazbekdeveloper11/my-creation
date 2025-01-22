import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

class MoreSelectWidget extends StatelessWidget {
  const MoreSelectWidget({
    super.key,
    required this.title,
    this.children,
    this.onTap,
    this.onClose,
    this.margin,
    this.isRequired = false,
    this.errorText,
  });

  final String title;
  final List<String>? children;
  final Function()? onTap;
  final Function(String value)? onClose;
  final EdgeInsets? margin;
  final bool isRequired;
  final String? errorText;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_sharp, size: 14.sp)
                    ],
                  ),
                ),
              ),
              (children?.isNotEmpty ?? false)
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 8.h),
                      child: Wrap(
                        spacing: 8.h,
                        runSpacing: 8.h,
                        children: List.generate(
                          children?.length ?? 0,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColor.mainColor.withOpacity(0.8),
                              borderRadius: AppUtils.kBorderRadius8,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                4.horizontalSpace,
                                Flexible(
                                  child: Text(
                                    (children?[index] ?? '').tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis, // Matnni cheklash va "..." ko'rsatish
                                  ),
                                ),
                                8.horizontalSpace,
                                InkWell(
                                  onTap: () {
                                    onClose?.call((children?[index] ?? ''));
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : AppUtils.kGap,
            ],
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
