import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/entities/enum/call_status_type.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';

// import 'package:uchat/features/chat_room/data/data_sources/remote/room_api_service.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets/app/widget/call_app_bar_widget.dart';
import 'package:uchat/widgets/loading/loading.dart';

class AppBarWithCallHeader<T> extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions; // TODO this actions is probably unused. Remove ?
  final double? expandedHeight;
  final double? height;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final bool pinned;
  final bool floating;
  final bool snap;
  final double? titleRightPadding;
  final bool isHideSearchBar;
  final void Function()? onTap;
  final bool stretch;
  final Color? bgColor;
  final bool enableCallOverAppbar;
  final bool leadingCenter;
  final double? fontSize;
  final double? leadingWidth;
  final double paddingWidth;

  const AppBarWithCallHeader({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.expandedHeight,
    this.height,
    this.centerTitle = false,
    this.automaticallyImplyLeading = false,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.isHideSearchBar = true,
    this.onTap,
    this.titleRightPadding,
    this.stretch = false,
    this.bgColor,
    this.enableCallOverAppbar = true,
    this.fontSize,
    this.leadingCenter = false,
    this.leadingWidth = 50,
    this.paddingWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final callConditionList = [
        CallStatusType.calling,
      ];

      final outgoingCallConditionList = [
        CallStatusType.inProgress,
        CallStatusType.created,
      ];
      UChatLiveKitController? callCtl = UChatCallController.instance.callCtlList.firstOrNull;
      // try {
      //   callCtl = CallController.instance;
      // } catch (e) {
      //   callCtl = null;
      // }
      final currentUser = UserController.instance.currentUser.value;

      final userCallStatus = currentUser?.callStatus;
      final callOnSessionKeyId = currentUser?.callOnSessionKeyId;
      final currentSessionKeyId = currentUser?.currentSessionKeyId;
      final isSameCallDevice = callOnSessionKeyId != null && callOnSessionKeyId == currentSessionKeyId;

      final generalCase = callConditionList.contains(userCallStatus);
      // final outgoingCase = outgoingCallConditionList.contains(userCallStatus) && callCtl?.isIncomingCall() == false;
      final outgoingCase = outgoingCallConditionList.contains(userCallStatus);
      // Condition to show call status bar
      final isShowResetCallState = (generalCase || outgoingCase) &&
          // callCtl?.room == null &&
          // callCtl?.forceCloseResetCallStatusBtn() == false &&
          isSameCallDevice;

      // final isShowActiveCallStatus = callCtl?.showCallTapInChatRoom == true;
      // bool isShowCallStatusOverAppbar = isShowResetCallState || isShowActiveCallStatus;
      bool isShowCallStatusOverAppbar = isShowResetCallState;
      // if (callCtl?.disconnectState == true || callCtl?.noneState == true || GetPlatform.isDesktop) {
      //   isShowCallStatusOverAppbar = false;
      // }
      // final bg = bgColor ?? (isShowCallStatusOverAppbar ? const Color(0xff56F5B2) : UTheme.color.appBar);
      final bg = bgColor ?? UTheme.color.appBar;

      final barHeight = (height ?? 55.spMin) + (isShowCallStatusOverAppbar == true ? 25.spMin : 20.spMin);

      final widget = CallAppBarWidget(
        isShowCallStatusOverAppbar: isShowCallStatusOverAppbar && enableCallOverAppbar && callCtl != null,
        isShowResetCallState: isShowResetCallState,
        title: title ?? const SizedBox.shrink(),
        leading: leading,
        leadingWidth: leadingWidth,
        paddingWidth: paddingWidth,
        leadingCenter: leadingCenter,
        // callStatus: callCtl?.status(),
        roomName: callCtl?.callData.title,
        callStatus: callCtl?.callDuration() ?? '00:00',
        actions: actions ?? [],
        appBarPadding: const EdgeInsets.symmetric(horizontal: AppSize.size4),
        onTap: () async {
          if (callCtl == null) {
            await UChatLoading.show();
            try {
              await UChatCallController.instance.openExistingCall();
            } catch (e) {
              // ignore if error
            }
            await UChatLoading.hide();
          }
          callCtl?.openCallScreen();
        },
      );
      if (T == SliverAppBar) {
        return SliverAppBar(
          expandedHeight: expandedHeight,
          backgroundColor: bg,
          shadowColor: UTheme.color.appBarShadow,
          pinned: pinned,
          // floating: floating,
          snap: snap,
          stretch: stretch,
          elevation: 0,
          automaticallyImplyLeading: automaticallyImplyLeading,
          centerTitle: centerTitle,
          toolbarHeight: barHeight,
          flexibleSpace: widget,
          titleSpacing: leading == null ? 0 : null,
        );
      }
      return AppBar(
        backgroundColor: bg,
        shadowColor: UTheme.color.appBarShadow,
        elevation: 0,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        toolbarHeight: barHeight,
        flexibleSpace: widget,
        titleSpacing: leading == null ? 0 : null,
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10.spMin);
}
