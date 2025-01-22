import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/data/models/chat/visibilty_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/profile_repo/profile_repository.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: AppText('settings'.tr(), size: 16.sp, fontWeight: FontWeight.w700, textColor: AppColor.textColor),
          ),
          body: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text('who_can_see_my_photos'.tr(),
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildSettingItem(
                    [
                      SettingsItem(
                          title: 'no_one'.tr(),
                          leading: Icon(Icons.visibility_off_outlined, color: AppColor.mainColor),
                          trailing: Radio(
                            activeColor: AppColor.mainColor,
                            value: false,
                            groupValue: localSource.photoShowType,
                            onChanged: state.apiStatus.isLoading
                                ? (v) {}
                                : (v) {
                                    if (!localSource.photoShowType) return;
                                    context.read<ChatBloc>().add(
                                          ShowMyImage(
                                            VisibilityModel(
                                              id: localSource.profileId,
                                              profilePictureType: 'PRIVATE',
                                              sharedWithUsers: [],
                                            ),
                                          ),
                                        );
                                  },
                          ),
                          onPressed: state.apiStatus.isLoading
                              ? () {}
                              : () {
                                  if (!localSource.photoShowType) return;
                                  context.read<ChatBloc>().add(
                                        ShowMyImage(
                                          VisibilityModel(
                                            id: localSource.profileId,
                                            profilePictureType: 'PRIVATE',
                                            sharedWithUsers: [],
                                          ),
                                        ),
                                      );
                                }),
                      SettingsItem(
                          padding: EdgeInsets.only(bottom: 12),
                          title: 'all_users'.tr(),
                          leading: Icon(Icons.visibility_outlined, color: AppColor.mainColor),
                          trailing: Radio(
                            activeColor: AppColor.mainColor,
                            value: true,
                            groupValue: localSource.photoShowType,
                            onChanged: state.apiStatus.isLoading
                                ? (v) {}
                                : (v) {
                                    if (localSource.photoShowType) return;
                                    context.read<ChatBloc>().add(
                                          ShowMyImage(
                                            VisibilityModel(
                                              id: localSource.profileId,
                                              profilePictureType: 'PUBLIC',
                                              sharedWithUsers: [],
                                            ),
                                          ),
                                        );
                                  },
                          ),
                          onPressed: state.apiStatus.isLoading
                              ? () {}
                              : () {
                                  if (localSource.photoShowType) return;

                                  context.read<ChatBloc>().add(
                                        ShowMyImage(
                                          VisibilityModel(
                                            id: localSource.profileId,
                                            profilePictureType: 'PUBLIC',
                                            sharedWithUsers: [],
                                          ),
                                        ),
                                      );
                                }),
                      SettingsItem(
                        title: 'delete_profile'.tr(),
                        leading: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          customCupertinoModalPopup(
                            context,
                            title: 'delete_profile_confirmation'.tr(),
                            actionTitleOne: 'yes'.tr(),
                            actionOne: () async {
                              final Either<Failure, bool> result = await sl<ProfileRepository>().deleteAccount();

                              result.fold(
                                (failure) => Navigator.pop(context),
                                (success) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, success);
                                },
                              );
                            },
                            actionTwo: () => context.pop(),
                          );
                        },
                      ),
                    ][index],
                  ),
                  separatorBuilder: (context, index) => Container(
                    color: index == 1 ? Colors.transparent : Colors.black12,
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                  ),
                  itemCount: 3,
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    packageInfo.version.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem(SettingsItem item) => Padding(
        padding: item.padding,
        child: ListTile(
          onTap: item.onPressed,
          leading: item.leading,
          title: AppText(item.title, size: 14.sp, fontWeight: FontWeight.w500),
          subtitle: item.subtitle != null
              ? AppText(item.subtitle ?? '', size: 12.sp, textColor: AppColor.textColor.withOpacity(0.6))
              : null,
          trailing: item.trailing ?? Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 20.sp),
          // tileColor: gradientColors[1].withOpacity(0.05),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
      );
}

class SettingsItem {
  SettingsItem({
    required this.title,
    this.subtitle,
    required this.leading,
    this.trailing,
    this.padding = const EdgeInsets.all(0),
    required this.onPressed,
  });

  String title;
  String? subtitle;
  Widget leading;
  Widget? trailing;
  EdgeInsets padding;
  VoidCallback onPressed;
}
