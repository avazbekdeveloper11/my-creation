import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/home/home_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/like/like_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/main/main_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/user/user_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/user/user_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/home/home_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/like/like_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/profile_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/custom_bottom_bar.dart';

import '../components/bottom_sheet/custom_bottom_sheet.dart';

part 'mixin/main_mixin.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.args});

  final MainArgs? args;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<MainBloc>().add(
          MainEventChanged(
            BottomMenu.values[widget.args?.index ?? 0],
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocSelector<MainBloc, MainState, BottomMenu>(
        selector: (state) => state.bottomMenu,
        builder: (_, bottomMenu) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (v, result) async {
            if (bottomMenu.index != 0) {
              context.read<MainBloc>().add(MainEventChanged(BottomMenu.values[0]));
            }
          },
          child: Scaffold(
            body: IndexedStack(
              index: bottomMenu.index,
              children: const [
                HomePage(),
                LikePage(),
                UserPage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(
              currentIndex: bottomMenu.index,
              onTap: (index) {
                if (localSource.profileId.isEmpty && (index == 1 || index == 2)) {
                  showQuestionnaireRequired();
                  return;
                }
                if (index == 1) {
                  context.read<LikeBloc>().add(GetLikesEvent(isCache: false));
                }
                if (index == 2) {
                  context.read<UserBloc>().add(GetChatUsersEvent(isRefresh: true));
                }

                if (index == bottomMenu.index) {
                  context.read<HomeBloc>().add(
                        const HomeScroll(isScrollingTop: true),
                      );
                  return;
                }

                context.read<MainBloc>().add(MainEventChanged(BottomMenu.values[index]));
              },
            ),
          ),
        ),
      );
}
