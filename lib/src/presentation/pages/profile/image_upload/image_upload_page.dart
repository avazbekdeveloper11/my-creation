import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/image/image_upload_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/main/main_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/photo_picker/photo_picker.dart';
import 'package:sovchilar_mobile/src/presentation/pages/image/image_screen.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key, required this.photoLimit});

  final int photoLimit;

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageUploadBloc, ImageUploadState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('upload_images_for_profile'.tr()),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagesWidget(photoLimit: widget.photoLimit),
              Gap(160.h),
              Padding(
                padding: AppUtils.kPaddingHorizontal16,
                child: AppButton(
                  colors: [AppColor.mainColor, AppColor.mainColor],
                  width: 1.sw,
                  isEnabled: state.images.isNotEmpty,
                  onPressed: state.images.isNotEmpty
                      ? () {
                          context.pushReplacement(
                            Routes.main,
                            extra: MainArgs(index: 3),
                          );
                          context.showFloatingSnackBar(
                            message: 'profile_created_successfully'.tr(),
                            backgroundColor: Colors.green,
                          );
                        }
                      : () {},
                  title: 'save'.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImagesWidget extends StatefulWidget {
  const ImagesWidget({super.key, this.padding, this.onThen, required this.photoLimit});

  final EdgeInsets? padding;
  final Function()? onThen;
  final int photoLimit;

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageUploadBloc, ImageUploadState>(
      listenWhen: (c, p) =>
          c.apiStatus != p.apiStatus || c.imageUploadStatus != p.imageUploadStatus || c.message != p.message,
      listener: (context, state) {
        if (state.imageUploadStatus.isSuccess) {
          if (widget.onThen != null) {
            widget.onThen!();
          }
        }
        if (state.apiStatus.isError || state.imageUploadStatus.isError) {
          context.showFloatingSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 70.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: widget.padding ?? AppUtils.kPaddingHorizontal16,
                      child: Row(
                        children: List.generate(
                          state.images.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: index == state.images.length - 1 ? 0 : 12.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ImageScreen(list: state.images, index: index),
                                  ),
                                ).then(
                                  (value) {
                                    if (value == 'image_deleted') {
                                      context.read<ImageUploadBloc>().add(const GetImageUrlEvent());
                                    }
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: AppUtils.kBorderRadius12,
                                child: SizedBox(
                                  height: 70.h,
                                  width: 70.w,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: state.images[index].url ?? '',
                                    errorWidget: (context, err, obj) => Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                    placeholder: (context, err) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: state.imageUploadStatus.isLoading
                      ? Center(
                          child: CircularProgressIndicator(backgroundColor: AppColor.mainColor),
                        )
                      : SizedBox(),
                )
              ],
            ),
            AppUtils.kGap12,
            !state.imageUploadStatus.isLoading && state.images.isEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: widget.padding ?? AppUtils.kPaddingHorizontal16,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'upload_photo_message'.tr(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : AppUtils.kGap,
            ListTile(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              contentPadding: widget.padding ?? AppUtils.kPaddingHorizontal16,
              title: Row(
                children: [
                  Text(
                    'all_images'.tr(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  AppUtils.kGap8,
                  ImageCountIndicator(
                    count: state.images.length,
                    maxCount: widget.photoLimit,
                  ),
                  Spacer(),
                  Text(
                    'upload_image'.tr(),
                    style: TextStyle(color: AppColor.mainColor, fontSize: 10.sp),
                  ),
                ],
              ),
              tileColor: Colors.transparent,
              onTap: () {
                // if (state.images.length >= widget.photoLimit) {
                //   context.showFloatingSnackBar(
                //       message:
                //           'you_can_upload_only_15_images'.tr().replaceFirst('{count}', (widget.photoLimit).toString()));
                //   return;
                // }
                pickImageDialog(
                  context,
                  onCameraPressed: () async {
                    context.pop();
                    await _picker.pickImage(source: ImageSource.camera).then(
                      (value) {
                        if (value != null) {
                          context.read<ImageUploadBloc>().add(
                                UploadImageEvent(
                                  file: File(value.path),
                                ),
                              );
                        }
                      },
                    );
                  },
                  onGalleryPressed: () async {
                    context.pop();
                    await _picker.pickImage(source: ImageSource.gallery).then(
                      (value) {
                        if (value != null) {
                          context.read<ImageUploadBloc>().add(UploadImageEvent(file: File(value.path)));
                        }
                      },
                    );
                  },
                );
              },
              trailing: Icon(Icons.upload, color: AppColor.mainColor),
            ),
          ],
        );
      },
    );
  }
}

class ImageCountIndicator extends StatelessWidget {
  final int count;
  final int maxCount;

  const ImageCountIndicator({
    super.key,
    required this.count,
    this.maxCount = 15,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (count / maxCount).clamp(0.0, 1.0);

    final Color backgroundColor = Color.lerp(Colors.red, Colors.green, progress)!;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 23.w,
          height: 23.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 2.5,
            color: backgroundColor,
            backgroundColor: Colors.grey[300],
          ),
        ),
        CircleAvatar(
          radius: 9.r,
          backgroundColor: backgroundColor,
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 9.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
