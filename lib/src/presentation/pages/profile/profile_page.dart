import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/main/main_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/widgets/profile_tile_widget.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/change_language_widget.dart';

import '../components/app_text/app_text.dart';
import 'image_upload/image_upload_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, c) => p.apiStatus != c.apiStatus || p.profileModel != c.profileModel,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'personal_info'.tr(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await customModalBottomSheet<void>(
                    context: context,
                    builder: (_, controller) => const ChangeLanguageWidget(),
                  );
                },
                icon: const Icon(Icons.language),
              ),
              IconButton(
                onPressed: () => context.push(Routes.settings).then(
                  (e) {
                    if (e == true) {
                      localSource.clear();
                      context.goNamed(Routes.auth);
                    }
                  },
                ),
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () => customCupertinoModalPopup(
                  context,
                  title: 'logOut'.tr(),
                  actionTitleOne: 'yes'.tr(),
                  actionOne: () {
                    localSource.clear().then(
                      (v) {
                        context.read<MainBloc>().add(
                              const MainEventChanged(BottomMenu.home),
                            );
                        context.goNamed(Routes.auth);
                      },
                    );
                  },
                  actionTwo: () => context.pop(),
                ),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: localSource.profileId.isEmpty
              ? Padding(
                  padding: AppUtils.kPaddingAll16,
                  child: AppButton(
                    colors: [AppColor.mainColor, AppColor.mainColor],
                    onPressed: () {
                      localSource.setRequiredQuestionnaire(value: false);
                      context.push(Routes.createQuestionnaire);
                    },
                    title: 'fillProfile'.tr(),
                    width: 1.sw,
                    height: 42.h,
                    borderRadius: BorderRadius.circular(10.r),
                    fontSize: 14,
                  ),
                )
              : state.apiStatus.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.apiStatus.isError
                      ? Center(child: Text(state.message))
                      : SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                12.verticalSpace,
                                Padding(
                                  padding: AppUtils.kPaddingHorizontal16,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              state.profileModel?.name.toString() ?? '',
                                              size: 20.sp,
                                              textColor: AppColor.textColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              children: [
                                                Icon(Icons.phone, color: AppColor.textColor, size: 16.sp),
                                                SizedBox(width: 8.w),
                                                AppText(
                                                  localSource.phone.toUzbekPhoneFormat(),
                                                  textColor: AppColor.textColor,
                                                  size: 13.sp,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppUtils.kGap12,
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .push(
                                              Routes.editProfile,
                                              extra: state.profileModel,
                                            )
                                                .then((v) {
                                              if ((v as bool?) ?? false) {
                                                context.read<ProfileBloc>().add(GetProfileEvent(isCache: false));
                                              }
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: AppColor.mainColor,
                                            child: Icon(
                                              Icons.border_color_outlined,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                20.verticalSpace,
                                ImagesWidget(
                                  padding: AppUtils.kPaddingHorizontal16,
                                  onThen: () {
                                    context.read<ProfileBloc>().add(
                                          GetProfileEvent(
                                            isCache: false,
                                            isLoading: false,
                                          ),
                                        );
                                  },
                                  photoLimit: state.profileModel?.photoLimit ?? 0,
                                ),
                                20.verticalSpace,
                                Padding(
                                  padding: AppUtils.kPaddingHorizontal16,
                                  child: Text('other_info'.tr()),
                                ),
                                8.verticalSpace,

                                /// place of birth
                                ProfileTileWidget(
                                  title: state.profileModel?.placeOfBirth?.children?.firstOrNull?.children?.firstOrNull
                                          ?.localization?.localizedValue ??
                                      '',
                                  subTitle: 'placeOfBirth'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.dwellingPlace?.children?.firstOrNull?.children?.firstOrNull
                                          ?.localization?.localizedValue ??
                                      '',
                                  subTitle: 'dwellingPlace'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.user?.age?.toString() ?? '',
                                  subTitle: 'age'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.nationality?.localization?.localizedValue ?? '',
                                  subTitle: 'nationality'.tr(),
                                ),

                                ProfileTileWidget(
                                  title: localSource.gender == 'MALE'
                                      ? (state.profileModel?.maritalStatus ?? '').tr()
                                      : (state.profileModel?.maritalStatus ?? '').tr(),
                                  subTitle: 'martialStatus'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: (state.profileModel?.education?.toString() ?? '').tr(),
                                  subTitle: 'education'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.profession ?? '',
                                  subTitle: 'profession'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.workPlace ?? '',
                                  subTitle: 'workPlace'.tr(),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ProfileTileWidget(
                                      title: (state.profileModel?.height.toString().isNotEmpty ?? false)
                                          ? '${state.profileModel?.height?.toInt()} ${'sm'.tr()}'
                                          : '',
                                      subTitle: 'height'.tr(),
                                    ),
                                    Spacer(flex: 4),
                                    ProfileTileWidget(
                                      title: (state.profileModel?.weight?.toString().isNotEmpty ?? false)
                                          ? '${state.profileModel?.weight?.toInt()} ${'kg'.tr()}'
                                          : '',
                                      subTitle: 'weight'.tr(),
                                    ),
                                    Spacer(flex: 6),
                                  ],
                                ),

                                ProfileTileWidget(
                                  title: (state.profileModel?.ownDwelling?.toString() ?? '') == 'NOT_SPECIFIED'
                                      ? ''
                                      : (state.profileModel?.ownDwelling?.toString() ?? '').tr(),
                                  subTitle: 'hasOwnDwelling'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: (state.profileModel?.genderTags?.map((e) => e.localization?.localizedValue))
                                          ?.join(', ') ??
                                      '',
                                  subTitle: 'gender_tag'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: (state.profileModel?.childPlanInFuture?.toString() ?? '').tr(),
                                  subTitle: 'childPlan'.tr(),
                                ),

                                ProfileTileWidget(
                                  title: (state.profileModel?.numOfMembersInFamily?.toString() ?? '').tr(),
                                  subTitle: 'numOfMembersInFamily'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: (state.profileModel?.birthPositionInFamily?.toString() ?? '').tr(),
                                  subTitle: 'birthPositionInFamily'.tr(),
                                ),

                                /// todo gender tags
                                // /// genderTags
                                // _info("${profile.genderTags?.map((e) => e.hashtag)}"
                                //     .replaceAll("(", "")
                                //     .replaceAll(")", "")),
                                // _title("Gendertags"),

                                ProfileTileWidget(
                                  title: (state.profileModel?.healthIssues ?? '').tr(),
                                  subTitle: 'health'.tr(),
                                ),

                                ProfileTileWidget(
                                  title: state.profileModel?.bio ?? '',
                                  subTitle: 'bio'.tr(),
                                ),

                                ProfileTileWidget(
                                  title: (state.profileModel?.requirements ?? ''),
                                  subTitle: 'requirements'.tr(),
                                ),
                                ProfileTileWidget(
                                  title: state.profileModel?.skills ?? '',
                                  subTitle: 'skills'.tr(),
                                ),
                                40.verticalSpace,
                              ],
                            ),
                          ),
                        ),
        );
      },
    );
  }
}
