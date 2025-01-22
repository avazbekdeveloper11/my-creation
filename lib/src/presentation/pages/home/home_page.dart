import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mnc_identifier_face/mnc_identifier_face.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/home/home_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/image/image_upload_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'widget/user_tile.dart';

part 'mixin/home_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onLongPress: () {
            localSource.changeChuck();
            localSource.chuck
                ? context.showFloatingSnackBar(message: 'Chuck is ON', backgroundColor: Colors.green)
                : context.showFloatingSnackBar(message: 'Chuck is OFF', backgroundColor: Colors.red);
            Future.delayed(
              Duration(seconds: 3),
              () {
                if (!kDebugMode) {
                  exit(0);
                }
              },
            );
          },
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                height: 60,
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              2.horizontalSpace,
              Text(
                Constants.appName,
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.tuneVerticalVariant),
            onPressed: () {
              context.push(Routes.filter).then(
                (value) {
                  final Map<String, dynamic> filter = localSource.filter;

                  if (filter.isNotEmpty) {
                    context.read<HomeBloc>().add(GetUsersEvent(filter: filter));
                  } else {
                    context.read<HomeBloc>().add(GetUsersEvent());
                  }
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColor.mainBackColor,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: listener,
        listenWhen: (previous, current) => previous.isScrollingTop != current.isScrollingTop,
        buildWhen: (previous, current) =>
            previous.isScrollingTop != current.isScrollingTop ||
            previous.apiStatus != current.apiStatus ||
            previous.likeApiStatus != current.likeApiStatus ||
            previous.users != current.users,
        builder: (context, state) {
          final List<UserModel>? users = state.users;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(
                    GetUsersEvent(
                      filter: localSource.filter,
                    ),
                  );
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                AppUtils.kSliverGap16,
                if (state.apiStatus.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (users?.isNotEmpty ?? false)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: AppUtils.kPaddingHorizontal16,
                          child: Column(
                            children: [
                              if (index != 0) Divider(height: 8.h),
                              UserTile(
                                index: index,
                                selectedIndex: selectedIndex,
                                user: users?[index],
                                isLoading: state.likeApiStatus.isLoading,
                                onTap: () {
                                  context.pushNamed(Routes.userDetailScreen, extra: users?[index]).then(
                                    (v) {
                                      context.read<HomeBloc>().add(GetUsersEvent(filter: localSource.filter));
                                    },
                                  );
                                },
                                onLikePressed: () {
                                  selectedIndex = index;
                                  if (localSource.profileId.isEmpty) {
                                    return showQuestionnaireRequired();
                                  }
                                  if ((users?[index].liked ?? false)) {
                                    customCupertinoModalPopup(
                                      context,
                                      title: 'confirm_unlike'.tr(),
                                      actionTitleOne: 'yes'.tr(),
                                      actionOne: () {
                                        context
                                          ..pop()
                                          ..read<HomeBloc>()
                                              .add(DislikeUserEvent(users?[index].id, localSource.filter));
                                      },
                                      actionTwo: () {
                                        context.pop();
                                      },
                                    );
                                  } else {
                                    context.read<HomeBloc>().add(LikeUserEvent(users?[index].id, localSource.filter));
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: users?.length ?? 0,
                    ),
                  )
                else
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/user_is_empty.png',
                          width: 200,
                          height: 200,
                        ),
                        AppUtils.kGap12,
                        Text(localSource.filter.isNotEmpty ? 'nothing_found'.tr() : 'not_available'.tr()),
                      ],
                    ),
                  ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SizedBox(height: 2),
                ),
                AppUtils.kSliverGap16,
              ],
            ),
          );
        },
      ),
    );
  }
}
