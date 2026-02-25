import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets.dart';

import 'home_responsive_util.dart';

class HomeVerticalNavBarDesktop extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onPressed;
  final int allUnreadCount;
  final int allInviteCount;
  final int allNotificationUnreadCount;
  final ContactInterface contact;

  const HomeVerticalNavBarDesktop({
    super.key,
    required this.onPressed,
    required this.selectedIndex,
    required this.contact,
    this.allUnreadCount = 0,
    this.allInviteCount = 0,
    this.allNotificationUnreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final labelFontSize = ResponsiveUtil.scaledFontSize(context, 12);
      final labelTextStyle = TextStyle(
        fontSize: labelFontSize,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A1A),
      );

      return NavigationRail(
        selectedIndex: selectedIndex,
        minWidth: 20.spMin,
        minExtendedWidth: 90.spMin,
        onDestinationSelected: onPressed,
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: labelTextStyle,
        unselectedLabelTextStyle: labelTextStyle.copyWith(
          color: const Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
        leading: SizedBox(height: 20.spMin),
        trailing: Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.spMin,
                horizontal: 5.spMin,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppBarNavIcon(
                    width: double.infinity,
                    height: 60.spMin,
                    bgColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onPressed(5);
                    },
                    icon: const AssetImage(
                      'assets/images/bookmark_icon.png',
                    ),
                  ),
                  AppBarNavIcon(
                    width: double.infinity,
                    height: 60.spMin,
                    bgColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onPressed(6);
                    },
                    icon: const AssetImage(
                      'assets/images/v2/setting_icon.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        destinations: <NavigationRailDestination>[
          NavigationRailDestination(
            icon: iconBuilder(path: 'assets/images/v2/home_unselect.png'),
            selectedIcon: iconBuilder(path: 'assets/images/v2/home_select.png'),
            label: Text(
              'Home'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 2.5.spMin,
              ),
            ),
          ),
          NavigationRailDestination(
            icon: iconBuilder(
              path: 'assets/images/v2/chat_unselect.png',
              badgeNumber: allUnreadCount,
            ),
            selectedIcon: iconBuilder(
              path: 'assets/images/v2/chat_select.png',
              badgeNumber: allUnreadCount,
            ),
            label: Text(
              'Chats'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 2.5.spMin,
              ),
            ),
          ),
          NavigationRailDestination(
            icon: iconBuilder(
              path: 'assets/images/v2/add_friend_icon.png',
              badgeNumber: allInviteCount,
            ),
            selectedIcon: iconBuilder(
              path: 'assets/images/v2/add_friend_icon.png',
              badgeNumber: allInviteCount,
            ),
            label: Text(
              'Add Friend'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 2.5.spMin,
              ),
            ),
          ),
          NavigationRailDestination(
            icon: iconBuilder(
              path: 'assets/images/noti_white_icon.png',
              badgeNumber: allNotificationUnreadCount,
            ),
            selectedIcon: iconBuilder(
              path: 'assets/images/noti_blue_icon.png',
              badgeNumber: allNotificationUnreadCount,
            ),
            label: Text(
              'Notification'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 2.5.spMin,
              ),
            ),
          ),
          NavigationRailDestination(
            icon: profileIconBuilder(),
            selectedIcon: profileIconBuilder(),
            label: Text(
              'My Profile'.tr,
              style: TextStyle(
                fontSize: 11,
                height: 2.5.spMin,
              ),
            ),
          ),
          NavigationRailDestination(
            disabled: true,
            icon: Container(),
            selectedIcon: Container(),
            label: const Text(''),
          ),
          NavigationRailDestination(
            disabled: true,
            icon: Container(),
            selectedIcon: Container(),
            label: const Text(''),
          ),
        ],
      );
    });
  }

  Widget profileIconBuilder() {
    bool isProfilePage = selectedIndex == 4;
    Color borderColor = isProfilePage ? const Color(0xFF0056FF) : const Color(0xFF333333);

    return SizedBox(
      width: 60.spMin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Avatar(
            radius: 18.spMin,
            hasAvatar: contact.hasAvatar,
            url: contact.avatarUrl,
            id: contact.id,
            backgroundColor: borderColor,
          ),
        ],
      ),
    );
  }

  Widget iconBuilder({
    required String path,
    double? iconWidth,
    double? iconHeight,
    int badgeNumber = 0,
    double? badgeSize,
    double badgePosition = 0.0,
  }) {
    String badgeContent = badgeNumber < 1000 ? badgeNumber.toString() : '999+';
    BorderRadius badgeRadius = BorderRadius.circular(7.5);

    final iconWidget = Image.asset(
      path,
      width: iconWidth ?? 24.spMin,
      height: iconHeight ?? 24.spMin,
      cacheWidth: 60.cacheSize,
    );

    return SizedBox(
      width: 60.spMin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              iconWidget,
              Positioned(
                top: 0,
                right: 0,
                child: badges.Badge(
                  showBadge: badgeNumber > 0,
                  badgeContent: Text(
                    badgeContent,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0.spMin,
                      vertical: 2.0.spMin,
                    ),
                    shape: badges.BadgeShape.square,
                    borderRadius: badgeRadius,
                    badgeColor: const Color(0xFFFF1552),
                  ),
                  // position: badges.BadgePosition.topEnd(end: badgeEndPosition),
                  child: iconWidget,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
