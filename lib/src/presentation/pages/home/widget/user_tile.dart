import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    this.user,
    this.onTap,
    this.onLikePressed,
    this.image,
    this.gender,
    this.isLoading = false,
    required this.index,
    this.selectedIndex,
  });

  final UserModel? user;
  final Function()? onTap;
  final Function()? onLikePressed;
  final String? image;
  final String? gender;
  final bool isLoading;
  final int index;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final bool viewed = user?.viewed ?? false;

    return Container(
      width: 1.sw,
      padding: AppUtils.kPaddingAll12.copyWith(right: 8.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColor.white),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppUtils.kGap4,
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: user?.user?.gender == 'MALE' ? AppColor.mainMenColor : AppColor.mainWomenColor,
                        child: AppText(
                          (user?.name ?? '').split('').firstOrNull?.toUpperCase().toString() ?? '',
                          size: 20.sp,
                          textColor: AppColor.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppUtils.kGap12,
                      Text(
                        user?.name ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: viewed ? FontWeight.w500 : FontWeight.w600,
                          color: viewed ? AppColor.textColor.withOpacity(0.5) : AppColor.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppUtils.kGap12,
                      Text(
                        '${(user?.user?.age ?? '')}'
                        ' y.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: viewed ? FontWeight.w400 : FontWeight.w500,
                          color: viewed ? AppColor.textColor.withOpacity(0.5) : AppColor.textColor,
                        ),
                      ),
                    ],
                  ),
                  AppUtils.kGap8,
                  if (user?.placeOfBirth?.children?.firstOrNull?.children?.firstOrNull?.localization?.localizedValue
                          .isNotEmpty ??
                      false)
                    Row(
                      children: [
                        AppUtils.kGap12,
                        Text(
                          '${'placeOfBirth3'.tr()}: ',
                          style: TextStyle(
                            fontWeight: viewed ? FontWeight.w400 : FontWeight.w500,
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              user?.placeOfBirth?.children?.firstOrNull?.children?.firstOrNull?.localization
                                      ?.localizedValue ??
                                  '',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: viewed ? FontWeight.w400 : FontWeight.w500,
                                color: viewed ? AppColor.textColor.withOpacity(0.5) : AppColor.textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (user?.dwellingPlace?.children?.firstOrNull?.children?.firstOrNull?.localization?.localizedValue
                          .isNotEmpty ??
                      false)
                    Row(
                      children: [
                        AppUtils.kGap12,
                        Text(
                          '${'dwPlace3'.tr()}: ',
                          style: TextStyle(
                            fontWeight: viewed ? FontWeight.w400 : FontWeight.w500,
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            user?.dwellingPlace?.children?.firstOrNull?.children?.firstOrNull?.localization
                                    ?.localizedValue ??
                                '',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: viewed ? FontWeight.w400 : FontWeight.w500,
                              color: viewed ? AppColor.textColor.withOpacity(0.5) : AppColor.textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: isLoading ? () {} : onLikePressed,
                icon: isLoading && index == selectedIndex
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: AppColor.likeFemaleIconColor),
                      )
                    : Icon(
                        user?.liked ?? false ? Icons.favorite : Icons.favorite_border,
                        size: 24.sp,
                        color: AppColor.likeFemaleIconColor,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
