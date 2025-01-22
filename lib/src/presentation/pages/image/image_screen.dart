import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/domain/repositories/image_repo/image_repository.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key, required this.list, required this.index, this.isAdmin = true});

  final List list;
  final int index;
  final bool isAdmin;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
          actions: [
            widget.isAdmin
                ? IconButton(
                    onPressed: () {
                      customCupertinoModalPopup(
                        context,
                        title: 'delete_image'.tr(),
                        actionTitleOne: 'yes'.tr(),
                        actionOne: () {
                          sl<ImageRepository>().deleteImage(widget.list[widget.index].id).then((value) {
                            if (value.isRight) {
                              context
                                ..pop()
                                ..pop('image_deleted');
                            }
                          });
                        },
                        actionTwo: () => context.pop(),
                      );
                    },
                    icon: Icon(
                      size: 26.sp,
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  )
                : SizedBox(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: kToolbarHeight.h + 40.h),
          child: ImageSlideshow(
            indicatorColor: Colors.blueAccent,
            onPageChanged: (value) => log('$value'),
            height: ScreenUtil().screenHeight * 0.8,
            width: ScreenUtil().screenWidth,
            initialPage: widget.index,
            indicatorBottomPadding: -10,
            children: List.generate(
              widget.list.length,
              (index) => CachedNetworkImage(
                imageUrl: widget.list[index].url,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) => Center(
                  child: SizedBox(
                    child: AppText(
                      'error_downloading'.tr(),
                      textAlign: TextAlign.center,
                      textColor: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
