import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/home/home_detail/home_detail_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/widgets/profile_tile_widget.dart';

import 'widgets/custom_carousel_with_indicator.dart';

class HomeDetailsPage extends StatefulWidget {
  const HomeDetailsPage({
    super.key,
  });

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> with SingleTickerProviderStateMixin {
  _HomeDetailsPageState() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDetailBloc, HomeDetailState>(
      builder: (context, state) {
        return PopScope(
          canPop: true,
          child: Scaffold(
            appBar: AppBar(
              title: AppText('about_user'.tr(), fontWeight: FontWeight.w600),
              centerTitle: true,
            ),
            body: state.apiStatus.isSuccess
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.imageStatus.isSuccess
                              ? (state.images?.isNotEmpty ?? false)
                                  ? CustomCarouselWithIndicator(images: state.images)
                                  : SizedBox()
                              : SizedBox(),
                          ProfileTileWidget(
                            title: state.user?.name ?? '',
                            subTitle: 'name3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.placeOfBirth?.children?.firstOrNull?.children?.firstOrNull?.localization
                                    ?.localizedValue ??
                                '',
                            subTitle: 'placeOfBirth3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.dwellingPlace?.children?.firstOrNull?.children?.firstOrNull?.localization
                                    ?.localizedValue ??
                                '',
                            subTitle: 'dwPlace3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.user?.age?.toString() ?? '',
                            subTitle: 'age3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.nationality?.localization?.localizedValue ?? '').tr(),
                            subTitle: 'nationality3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.maritalStatus ?? '').tr(),
                            subTitle: 'maritalStatus3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.education?.toString() ?? '').tr(),
                            subTitle: 'education'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.profession ?? '',
                            subTitle: 'profession'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.workPlace ?? '',
                            subTitle: 'workPlace3'.tr(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProfileTileWidget(
                                title: '${state.user?.height?.toInt()} ${'sm'.tr()}',
                                subTitle: 'height3'.tr(),
                              ),
                              Spacer(flex: 4),
                              ProfileTileWidget(
                                title: '${state.user?.weight?.toInt()} kg',
                                subTitle: 'weight3'.tr(),
                              ),
                              Spacer(flex: 6),
                            ],
                          ),
                          ProfileTileWidget(
                            title: (state.user?.ownDwelling?.toString() ?? '') == 'NOT_SPECIFIED'
                                ? ''
                                : (state.user?.ownDwelling?.toString() ?? '').tr(),
                            subTitle: 'hasOwnDwelling3'.tr(),
                          ),
                          ProfileTileWidget(
                            title:
                                (state.user?.genderTags?.map((e) => e.localization?.localizedValue))?.join(', ') ?? '',
                            subTitle: 'gender_tag'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.childPlanInFuture?.toString() ?? '').tr(),
                            subTitle: 'childPlan3'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.healthIssues ?? '').tr(),
                            subTitle: 'health'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.bio ?? '',
                            subTitle: 'bio'.tr(),
                          ),
                          ProfileTileWidget(
                            title: (state.user?.requirements ?? ''),
                            subTitle: 'requirements'.tr(),
                          ),
                          ProfileTileWidget(
                            title: state.user?.skills ?? '',
                            subTitle: 'skills'.tr(),
                          ),
                          Gap(100),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            // bottomNavigationBar: SafeArea(
            //   minimum: AppUtils.kPaddingHorizontal16.copyWith(bottom: 8.h),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(backgroundColor: AppColor.mainColor),
            //     child: Text('chat'),
            //     onPressed: () {
            //       context.push(
            //         Routes.chat,
            //         extra: MatchesModel(
            //           status: state.user?.status,
            //           id: state.user?.id,
            //           createdDate: '',
            //           chat: ChatModel,
            //           oppositeProfile: OppositeProfile(
            //               id: state.user?.id,
            //               name: state.user?.name,
            //               user: User(id: state.user?.id),
            //               profilePictureType: state.user?.profilePictureType),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
