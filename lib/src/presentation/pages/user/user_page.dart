import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/user/user_bloc.dart';

import 'widget/chat_user_list.dart';

part 'mixin/user_mixin.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<UserPage> with UserMixin, TickerProviderStateMixin {
  @override
  void initState() {
    initController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (p, c) =>
          p.apiStatus != c.apiStatus || p.usersOpened != c.usersOpened || p.usersClosed != c.usersClosed,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('chat'.tr()),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 40.h),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColor.white,
                indicatorSize: TabBarIndicatorSize.tab,
                padding: AppUtils.kPaddingHorizontal16.copyWith(bottom: 4.h),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
                indicator: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      'active'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      'not_active'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ChatUserList(
                apiStatus: state.apiStatus,
                users: state.usersOpened,
              ),
              ChatUserList(
                apiStatus: state.apiStatus,
                users: state.usersClosed,
              ),
            ],
          ),
        );
      },
    );
  }
}
