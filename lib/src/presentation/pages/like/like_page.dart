import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:sovchilar_mobile/src/data/models/like/likes_model.dart';

import 'package:sovchilar_mobile/src/presentation/bloc/like/like_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/home/widget/user_tile.dart';

import '../components/bottom_sheet/custom_bottom_sheet.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'likes'.tr(),
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<LikeBloc>().add(const GetLikesEvent());
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                AppUtils.kSliverGap16,
                if (state.apiStatus.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (state.userLikesModel?.isNotEmpty ?? false)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final LikesModel? user = state.userLikesModel?[index];
                        final LikesProfile? profile = user?.profile;

                        if (profile == null) return const SizedBox.shrink();

                        return Padding(
                          padding: AppUtils.kPaddingHorizontal16,
                          child: Column(
                            children: [
                              if (index != 0) Divider(height: 8.h),
                              UserTile(
                                onTap: () => context
                                    .pushNamed(
                                  Routes.userDetailScreen,
                                  extra: UserModel(id: profile.id, viewed: profile.viewed),
                                )
                                    .then(
                                  (v) {
                                    context.read<LikeBloc>().add(GetLikesEvent(isCache: false));
                                  },
                                ),
                                onLikePressed: selectedIndex == index && state.likeApiStatus.isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        if (profile.liked ?? false) {
                                          customCupertinoModalPopup(
                                            context,
                                            title: 'confirm_unlike'.tr(),
                                            actionTitleOne: 'yes'.tr(),
                                            actionOne: () {
                                              context
                                                ..pop()
                                                ..read<LikeBloc>().add(
                                                  DislikeUserEvent(profile.id ?? ''),
                                                );
                                            },
                                            actionTwo: () {
                                              context.pop();
                                            },
                                          );
                                        } else {
                                          context.read<LikeBloc>().add(LikeUserEvent(profile.id ?? ''));
                                        }
                                      },
                                index: index,
                                selectedIndex: selectedIndex,
                                isLoading: (selectedIndex == index && state.likeApiStatus.isLoading),
                                user: UserModel(
                                  liked: profile.liked,
                                  id: profile.id,
                                  name: profile.name,
                                  maritalStatus: profile.maritalStatus,
                                  placeOfBirth: user?.likedProfile?.placeOfBirth,
                                  dwellingPlace: user?.likedProfile?.dwellingPlace,
                                  dateOfBirth: user?.likedProfile?.dateOfBirth ?? '',
                                  user: User(
                                    id: user?.id,
                                    age: profile.user?.age ?? 0,
                                    status: user?.status,
                                    createdDate: user?.createdDate,
                                    profile: Profile(
                                      id: user?.profile?.id ?? '',
                                    ),
                                  ),
                                  viewed: profile.viewed,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: state.userLikesModel?.length ?? 0,
                    ),
                  )
                else
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/user_is_empty.png'),
                          width: 200,
                          height: 200,
                        ),
                        AppUtils.kGap12,
                        Text('not_available'.tr()),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
