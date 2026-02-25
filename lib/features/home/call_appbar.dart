import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/loading/loading.dart';

class CallAppBar extends GetView<UserController> {
  final Widget child;

  const CallAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isShowCallStatusOverAppbar = UChatCallController.instance.isShowCallStatusOverAppbar;

        return SafeArea(
          top: isShowCallStatusOverAppbar,
          bottom: false,
          left: false,
          right: false,
          child: Scaffold(
            appBar: isShowCallStatusOverAppbar
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(42),
                    child: CallAppBarWidget(
                      child: child,
                    ),
                  )
                : null,
            resizeToAvoidBottomInset: false,
            body: child,
          ),
        );
      },
    );
  }
}

class CallAppBarWidget extends GetView<UChatCallController> {
  final Widget child;

  const CallAppBarWidget({super.key, required this.child});

  static double callAppBarHeight = 42.spMin;

  Future<String> getRoomCallName() async {
    final callRoomName = await controller.config.authenticated.getStringWithDefault(
      key: callRoomNameKey,
      defaultValue: '',
    );

    return callRoomName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundGrayLightPressed,
      child: GestureDetector(
        onTap: () async {
          if (controller.callCtlList().firstOrNull == null) {
            await UChatLoading.show();
            try {
              await UChatCallController.instance.openExistingCall();
            } catch (e) {
              // ignore if error
            }
            await UChatLoading.hide();
          }
          controller.callCtlList().firstOrNull?.openCallScreen();
        },
        child: Container(
          height: CallAppBarWidget.callAppBarHeight,
          color: context.theme.appColors.backgroundGrayLightPressed,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space8),
                child: controller.connectivityCtl.isOffline
                    ? _buildConnectingWidget(context)
                    : _buildDurationWidget(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildConnectingWidget(BuildContext context) {
    return Center(
      child: AppText.body2Bold(
        'Connecting'.tr,
        context: context,
        textAlign: TextAlign.center,
        color: context.theme.appColors.textPrimaryInverse,
      ),
    );
  }

  _buildDurationWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.vectors.messageCallIcon.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.textPrimaryInverse,
            BlendMode.srcIn,
          ),
          width: 15,
          height: 15,
        ),
        AppSpace.space2.horizontalSpace,
        if (controller.callCtlList().firstOrNull?.callData.title == null)
          FutureBuilder(
              future: getRoomCallName(),
              builder: (_, sp) {
                if (sp.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator(
                    radius: 7,
                  );
                }
                return Flexible(
                  child: AppText.body2Bold(
                    sp.data ?? 'Unknown'.tr,
                    context: context,
                    textAlign: TextAlign.center,
                    color: context.theme.appColors.textPrimaryInverse,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                );
              })
        else
          Obx(() {
            return Flexible(
              child: AppText.body2Bold(
                controller.callCtlList().firstOrNull?.callData.title ?? 'Unknown'.tr,
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textPrimaryInverse,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            );
          }),
        AppSpace.space2.horizontalSpace,
        AppText.body2Bold(
          '|',
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textPrimaryInverse,
        ),
        AppSpace.space2.horizontalSpace,
        Obx(
          () {
            return AppText.body2Bold(
              controller.callCtlList().firstOrNull?.callDuration() ?? '00:00',
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textPrimaryInverse,
            );
          },
        )
      ],
    );
  }
}
