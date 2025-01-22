import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.theme.shadowColor,
              blurRadius: 2,
              spreadRadius: 0.1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 8,
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            children: [
              BottomMenuItem(
                onTap: () {
                  onTap?.call(0);
                },
                isSelected: currentIndex == 0,
                label: 'home',
                icon: MdiIcons.home,
              ),
              BottomMenuItem(
                onTap: () {
                  onTap?.call(1);
                },
                isSelected: currentIndex == 1,
                label: 'likes_bt',
                icon: Icons.favorite,
              ),
              BottomMenuItem(
                onTap: () {
                  onTap?.call(2);
                },
                isSelected: currentIndex == 2,
                label: 'chat',
                icon: MdiIcons.messageReplyTextOutline,
              ),
              BottomMenuItem(
                onTap: () {
                  onTap?.call(3);
                },
                isSelected: currentIndex == 3,
                label: 'profile',
                icon: MdiIcons.account,
              ),
            ],
          ),
        ),
      );
}

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    required this.isSelected,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Semantics(
          child: InkResponse(
            onTap: onTap,
            customBorder: const CircleBorder(),
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColor.mainColor : context.theme.bottomNavigationBarTheme.unselectedItemColor,
                ),
                Text(
                  label.tr(),
                  style: context.theme.bottomNavigationBarTheme.selectedLabelStyle?.copyWith(
                    color: isSelected ? AppColor.mainColor : context.theme.bottomNavigationBarTheme.unselectedItemColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
