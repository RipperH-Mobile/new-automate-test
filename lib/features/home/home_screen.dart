import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';
import 'package:uchat/features/call_log/presentation/views/screens/mobile/call_log_screen.dart';
import 'package:uchat/features/central_notification/presentation/controller/central_notification_controller.dart';
import 'package:uchat/features/central_notification/presentation/view/central_notification_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/chat_room_list_screen.dart';
import 'package:uchat/features/contact/presentation/views/screens/mobile/contacts_screen.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/features/home/presentation/widgets/quick_switch_background.dart';
import 'package:uchat/features/setting/presentation/views/screens/setting_screen.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

import 'call_appbar.dart';
import 'home_responsive_util.dart';
import 'presentation/view/widgets/splash_overlay.dart';
import 'presentation/widgets/troubleshoot_expandable_menu.dart';

// final _log = useLogger();

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  double get bottomBarWidth => 70.spMin;

  double get bottomBarHeight => 55.spMin;

  EdgeInsetsGeometry get bottomBarPadding => EdgeInsets.only(
        top: GetPlatform.isIOS ? 10.spMin : 0.spMin,
      );

  static final List<Widget> widgetPanes = <Widget>[
    const ContactsScreen(),
    const ChatListScreen(),
    const CallLogScreen(),
    const CentralNotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'home-screen',
      builder: (ctl) {
        if (ctl.isShowSplash || UserController.instance.currentUser() == null) {
          return Obx(() {
            final mainTask =
                (UserController.instance.loadingTaskNumber() / UserController.instance.totalNumberTasks).floor() * 100;
            final state = UserController.instance.loadingStatePercentage.value;

            return SplashOverlay(
              loadingPercentage: '${min(mainTask <= 0 ? 100 : mainTask, state)}%',
              showUpdating: ctl.isShowUpdatingOverlay,
              loadingStatus: UserController.instance.loadingTaskStatus(),
            );
          });
        }

        if (controller.paneIndex.value >= widgetPanes.length) {
          controller.onNavigationTapped(0);
        }

        if (GetPlatform.isAndroid) {
          final wg = CallAppBar(
            child: Scaffold(
              body: Obx(() {
                return Stack(
                  children: [
                    IndexedStack(
                      index: controller.paneIndex.value,
                      children: widgetPanes,
                    ),
                    if (controller.isShowPopupMenu.value)
                      _PopupMenu(
                        animationController: controller.animationController,
                      ),
                    if (controller.isShowQuickSwitch.value)
                      QuickSwitchBackground(animationController: controller.quickSwitchAnimationCtl),
                  ],
                );
              }),
              // This is to prevent white space at the bottom of the screen when backing from chat room while keyboard
              // is open on Android.
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Obx(() {
                return _buildBottomNavigation(
                  context,
                  controller.paneIndex.value,
                );
              }),
            ).fadeIn(
              duration: const Duration(milliseconds: 300),
            ),
          );

          return _buildTroubleshootEasyAccess(wg, context);
        }

        final wg = CallAppBar(
          child: CupertinoTabScaffold(
            resizeToAvoidBottomInset: false,
            controller: controller.cupertinoController,
            tabBar: _buildCupertinoBottomNavigation(context),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      IndexedStack(
                        index: controller.paneIndex.value,
                        children: widgetPanes,
                      ),
                      Obx(() {
                        if (controller.isShowPopupMenu.value) {
                          return _PopupMenu(
                            animationController: controller.animationController,
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      Obx(() {
                        if (controller.isShowQuickSwitch.value) {
                          return QuickSwitchBackground(animationController: controller.quickSwitchAnimationCtl);
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  );
                },
              );
            },
          ).fadeIn(
            duration: const Duration(milliseconds: 300),
          ),
        );

        return _buildTroubleshootEasyAccess(wg, context);
      },
    );
  }

  Widget _buildTroubleshootEasyAccess(Widget child, BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'troubleshoot-easy-access',
      builder: (ctl) {
        if (ctl.enableTroubleshootEasyAccess) {
          return FloatingDraggableWidget(
            mainScreenWidget: child,
            onDragEvent: ctl.saveTroubleshootEasyAccessPosition,
            floatingWidget: const TroubleshootExpandableMenu(),
            floatingWidgetHeight: 56,
            floatingWidgetWidth: 56,
            dx: ctl.troubleshootEasyAccessX,
            dy: ctl.troubleshootEasyAccessY,
            autoAlign: true,
            autoAlignType: AlignmentType.both,
          );
        }

        return child;
      },
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    int currentIndex,
  ) {
    final isMobile = UChatScreenUtil.instance.isMobile;
    double iconSize = ResponsiveUtil.scaledIconSize(context);
    double labelFontSize = ResponsiveUtil.scaledFontSize(context, 12);
    double topPadding = ResponsiveUtil.scaledPadding(context, 10);
    return Container(
      decoration: isMobile
          ? const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  blurRadius: 15.0,
                ),
              ],
            )
          : null,
      child: BottomNavigationBar(
        showSelectedLabels: isMobile,
        showUnselectedLabels: isMobile,
        type: BottomNavigationBarType.fixed,
        items: _buildBottomNavigationBarItems(context, iconSize, topPadding),
        // add non transparent background color to CupertinoTabBar to force widget
        // to not be under bottom navigation bar
        backgroundColor: isMobile ? context.theme.appColors.backgroundNeutralLightest : Colors.transparent,
        elevation: isMobile ? null : 0,
        selectedItemColor: const Color(0xFF1A1A1A),
        unselectedItemColor: const Color(0xFF333333),
        selectedLabelStyle: TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: labelFontSize),
        currentIndex: currentIndex,
        onTap: (index) => controller.onNavigationTapped(index, context),
      ),
    );
  }

  CupertinoTabBar _buildCupertinoBottomNavigation(BuildContext context) {
    double iconSize = ResponsiveUtil.scaledIconSize(context);
    // double labelFontSize = ResponsiveUtil.scaledFontSize(context, 12);
    double topPadding = ResponsiveUtil.scaledPadding(context, 0);
    return CupertinoTabBar(
      items: _buildBottomNavigationBarItems(context, iconSize, topPadding),
      // add non transparent background color to CupertinoTabBar to force widget
      // to not be under bottom navigation bar
      // height: ResponsiveUtil.scaledBarSize(context),
      height: (MediaQuery.of(context).size.height < 900) ? 75.spMin : ResponsiveUtil.scaledBarSize(context),
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      activeColor: const Color(0xFF1A1A1A),
      inactiveColor: const Color(0xFF333333),
      currentIndex: controller.paneIndex.value,
      onTap: (index) => controller.onNavigationTapped(index, context),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    Widget icon,
    int badgeNumber,
    double badgeEndPosition, {
    bool isShowBadgeNumber = false,
  }) {
    final isIOS = Platform.isIOS;

    /// To arrange the [badgeContent] in the proper position
    double rightPosition = -4.spMin;
    if (badgeNumber >= 10 && badgeNumber < 100) {
      rightPosition = isIOS ? -11.spMin : -8.spMin;
    } else if (badgeNumber >= 100 && badgeNumber < 1000) {
      rightPosition = isIOS ? -18.spMin : -13.spMin;
    } else if (badgeNumber >= 1000) {
      rightPosition = isIOS ? -26.spMin : -18.spMin;
    }

    final textStyle = context.theme.appTexts.body1.copyWith(
      color: context.theme.appColors.textErrorInverse,
      fontSize: 10.spMin,
      height: isIOS ? 0 : null,
      fontWeight: FontWeight.w900,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        badgeNumber > 0
            ? isShowBadgeNumber
                ? Positioned(
                    top: isIOS ? -1.5.spMin : -4.5.spMin,
                    right: rightPosition,
                    child: Container(
                      padding: EdgeInsets.only(left: 2.5.spMin, right: 2.5.spMin, top: 1.spMin, bottom: 1.5.spMin),
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundError,
                        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                        border: Border.all(
                          width: 1.5,
                          color: context.theme.appColors.borderLighter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedFlipCounter(
                            value: badgeNumber > 999 ? 999 : badgeNumber,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            textStyle: textStyle,
                          ),
                          if (badgeNumber > 999)
                            Text(
                              '+',
                              style: isIOS ? textStyle.copyWith(height: 1) : textStyle,
                            ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: 0.spMin,
                    right: -4.spMin,
                    child: Container(
                      width: 6.spMin,
                      height: 6.spMin,
                      decoration: BoxDecoration(
                        color: context.theme.appColors.iconError,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildChatBadge(BuildContext context, Widget icon) {
    return Obx(() {
      final badgeNumber = ChatListController.instance.allUnreadCount;
      return _buildBadge(context, icon, badgeNumber, -10, isShowBadgeNumber: true);
    });
  }

  Widget _buildCallBadge(BuildContext context, Widget icon) {
    return Obx(() {
      final badgeNumber = CallLogScreenController.instance.newCallCount.value;
      return _buildBadge(context, icon, badgeNumber, -5);
    });
  }

  Widget _buildNotificationBadge(BuildContext context, Widget icon) {
    return Obx(() {
      final badgeNumber = CentralNotificationController.instance.notiUnreadCount.value;
      return _buildBadge(context, icon, badgeNumber, -5);
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
    BuildContext context,
    double iconSize,
    double topPadding,
  ) {
    // create a bottom navigation bar item
    final isMobile = UChatScreenUtil.instance.isMobile;

    BottomNavigationBarItem buildItem(
      Widget activeIcon,
      Widget inactiveIcon,
      String label, {
      Widget Function(Widget)? badgeBuilder,
      Function()? onLongPress,
    }) {
      Widget buildIcon(Widget icon, bool isActive) {
        if (badgeBuilder != null) {
          icon = badgeBuilder(icon);
        }

        final span = TextSpan(
          text: label,
          style: context.theme.appTexts.caption2.copyWith(
            color: context.theme.appColors.textDarkest,
          ),
        );
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: 70.spMin);
        final numLines = tp.computeLineMetrics().length;

        if (numLines > 1) {
          controller.bottomMenuLabelSize.value = 9;
        }

        return GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            height: bottomBarHeight,
            color: Colors.transparent,
            padding: bottomBarPadding,
            child: RotatedBox(
              quarterTurns: isMobile ? 0 : -1,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isActive)
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: icon,
                          ).tada(),
                        ),
                      )
                    else
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: icon,
                          ),
                        ),
                      ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.appTexts.caption2.copyWith(
                        color: context.theme.appColors.textDarkest,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return BottomNavigationBarItem(
        activeIcon: buildIcon(activeIcon, true),
        icon: buildIcon(inactiveIcon, false),
        label: GetPlatform.isAndroid ? '' : null, // Android requires a label to show the icon, null throw error
      );
    }

    // item for the profile menu
    BottomNavigationBarItem profileItem = BottomNavigationBarItem(
      label: GetPlatform.isAndroid ? '' : null, // Android requires a label to show the icon, null throw error
      icon: GestureDetector(
        onLongPress: () {
          controller.showQuickSwitchBottomSheet(context);
        },
        child: Container(
          width: bottomBarWidth,
          height: bottomBarHeight,
          padding: bottomBarPadding,
          child: Obx(
            () {
              final user = UserController.instance.currentUser();

              bool isProfilePage = controller.paneIndex.value == 4;
              Color bgColor = isProfilePage ? context.theme.appColors.backgroundDarkNeutral : const Color(0xFF333333);

              return RotatedBox(
                quarterTurns: isMobile ? 0 : -1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Avatar(
                        radius: (AppSize.size6 / 2).spMin,
                        hasAvatar: user?.hasAvatar,
                        url: user?.avatarUrl,
                        id: user?.id,
                        backgroundColor: bgColor,
                        borderWidth: isProfilePage ? 0.5 : 0,
                        borderColor: isProfilePage ? context.theme.appColors.backgroundDarkNeutral : null,
                      ),
                    ),
                    Text(
                      'Menu'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.appTexts.caption2.copyWith(
                        color: context.theme.appColors.textDarkest,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    final iconButtonSize = AppSize.size6.spMin;

    return <BottomNavigationBarItem>[
      buildItem(
        Assets.vectors.contactActiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        Assets.vectors.contactInactiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        'Contact'.tr,
      ),
      buildItem(
        Assets.vectors.chatActiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        Assets.vectors.chatInactiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        'Chat'.tr,
        badgeBuilder: (icon) => _buildChatBadge(context, icon),
      ),
      buildItem(
        Assets.vectors.callActiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        Assets.vectors.callInactiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        'Call'.tr,
        badgeBuilder: (icon) => _buildCallBadge(context, icon),
      ),
      buildItem(
        Assets.vectors.centralNotiActiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        Assets.vectors.centralNotiInactiveIcon.svg(height: iconButtonSize, width: iconButtonSize),
        'Notifications'.tr,
        badgeBuilder: (icon) => _buildNotificationBadge(context, icon),
      ),
      profileItem
    ];
  }
}

class _PopupMenu extends StatefulWidget {
  const _PopupMenu({required this.animationController});

  final AnimationController animationController;

  @override
  State<_PopupMenu> createState() => _PopupWithSpringState();
}

class _PopupWithSpringState extends State<_PopupMenu> {
  late Animation<double> _scaleAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _blurAnim;

  @override
  void initState() {
    super.initState();

    _scaleAnim = Tween<double>(
      //NOTE.start popup scale with small 0.1
      //NOTE.end popup scale to normal size
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeOutBack,
    ));

    _slideAnim = Tween<Offset>(
      //NOTE.start popup position from bottom right
      //NOTE.end popup position to normal
      begin: const Offset(0.4, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeOutBack,
    ));
    _blurAnim = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HomeController.instance.onNavigationTapped(4);
      },
      child: Stack(
        children: [
          ///NOTE.Blur background
          AnimatedBuilder(
            animation: _blurAnim,
            builder: (_, __) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color:
                    _blurAnim.value != 0 ? context.theme.appColors.backgroundDarkNeutral.withValues(alpha: 0.2) : null,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurAnim.value,
                    sigmaY: _blurAnim.value,
                  ),
                  child: Container(color: Colors.transparent),
                ),
              );
            },
          ),

          ///NOTE.Popup menu with spring effect
          Align(
            alignment: Alignment.bottomRight,
            child: SlideTransition(
              position: _slideAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: const SettingScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
