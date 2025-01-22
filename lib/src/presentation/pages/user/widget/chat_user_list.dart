import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/chat/chat_model.dart';

import '../../../bloc/user/user_bloc.dart';

class ChatUserList extends StatelessWidget {
  const ChatUserList({
    super.key,
    required this.apiStatus,
    required this.users,
  });

  final ApiStatus apiStatus;
  final List<MatchesModel>? users;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(GetChatUsersEvent(isRefresh: true));
      },
      child: CustomScrollView(
        slivers: [
          AppUtils.kSliverGap16,
          if (apiStatus.isSuccess)
            if (users?.isNotEmpty ?? false)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        if (index != 0)
                          Divider(
                            color: Colors.grey,
                            height: 24.h,
                          ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (users?[index].chat?.chatId != null) {
                              context.push(Routes.chat, extra: users?[index]).then(
                                (v) {
                                  context.read<UserBloc>().add(GetChatUsersEvent(isRefresh: true));
                                },
                              );
                            } else {
                              context.showFloatingSnackBar(message: 'chat id null {${users?[index].chat?.id}}');
                            }
                          },
                          child: Row(
                            children: [
                              AppUtils.kGap12,
                              CircleAvatar(
                                radius: 24.r,
                                backgroundColor: users?[index].oppositeProfile?.user?.gender == 'MALE'
                                    ? AppColor.mainMenColor
                                    : AppColor.mainWomenColor,
                                backgroundImage: users?[index].oppositeProfile?.user?.images?.firstOrNull?.url != null
                                    ? CachedNetworkImageProvider(
                                        users?[index].oppositeProfile?.user?.images?.firstOrNull?.url ?? '',
                                      )
                                    : null,
                                child: users?[index].oppositeProfile?.user?.images?.firstOrNull?.url == null
                                    ? Center(
                                        child: AppText(
                                          users?[index].oppositeProfile?.user?.firstName?[0].toUpperCase() ?? '',
                                          size: 20.sp,
                                          textColor: AppColor.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    : null,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8, right: 12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            users?[index].oppositeProfile?.name ?? '',
                                            style: TextStyle(
                                              color: users?[index].status == 'OPEN'
                                                  ? Colors.black
                                                  : users?[index].status == 'CLOSED'
                                                      ? Colors.grey
                                                      : Colors.red.shade500,
                                              fontWeight: users?[index].status == 'OPEN'
                                                  ? FontWeight.w700
                                                  : users?[index].status == 'CLOSED'
                                                      ? FontWeight.w400
                                                      : FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          // todo busy
                                          // Visibility(
                                          //   visible: users?[index].isOppositeBusy ?? false,
                                          //   child: Container(
                                          //     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                          //     decoration: BoxDecoration(
                                          //       borderRadius: AppUtils.kBorderRadius8,
                                          //       color: AppColor.mainColor.withOpacity(0.4),
                                          //     ),
                                          //     child: Text(
                                          //       'busy'.tr(),
                                          //       style: TextStyle(
                                          //         fontSize: 12.sp,
                                          //         color: AppColor.mainColor,
                                          //         fontWeight: FontWeight.w500,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          AppUtils.kGap12,
                                          // Text('20:20'),
                                        ],
                                      ),
                                      // Text(
                                      //   'Salom yaxshimisiz ?',
                                      //   overflow: TextOverflow.ellipsis,
                                      //   maxLines: 1,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // users?[index].status == 'CLOSED' || users?[index].status == 'NOT_OPEN_YET'
                              //     ? SizedBox()
                              //     : ReverseTimerWidget(
                              //         chatCreatedTime: users?[index].updatedDate ?? '',
                              //         totalHours: users?[index].chatDurationInHour ?? 0,
                              //       ),
                              12.horizontalSpace,
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: users?.length ?? 0,
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
                      image: AssetImage('assets/images/not_found_chat.png'),
                      width: 180.w,
                      height: 180.w,
                    ),
                    AppUtils.kGap12,
                    Text('chat_not_found'.tr()),
                  ],
                ),
              )
          else if (apiStatus.isError)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/not_found_chat.png'),
                    width: 180.w,
                    height: 180.w,
                  ),
                  AppUtils.kGap12,
                  Text('chat_not_found'.tr()),
                ],
              ),
            )
          else
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
