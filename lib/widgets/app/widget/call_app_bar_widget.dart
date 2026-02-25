import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/animation/transition/top_transition.dart';
import 'package:uchat/widgets/app_text.dart';

class CallAppBarWidget extends StatelessWidget {
  final bool isShowCallStatusOverAppbar;
  final bool isShowResetCallState;
  final List<Widget> actions;
  final Widget? title;
  final Widget? leading;
  final void Function()? onTap;
  final String? callStatus;
  final String? roomName;
  final bool leadingCenter;
  final double? leadingWidth;
  final double paddingWidth;
  final EdgeInsets appBarPadding;

  const CallAppBarWidget({
    super.key,
    required this.isShowCallStatusOverAppbar,
    required this.isShowResetCallState,
    this.title,
    this.actions = const [],
    this.leading,
    this.onTap,
    this.callStatus,
    this.roomName,
    this.leadingCenter = false,
    this.leadingWidth,
    this.paddingWidth = 0,
    this.appBarPadding = EdgeInsets.zero,
  });

  UChatCallController get callCtl => UChatCallController.instance;

  Future<String> getRoomCallName() async {
    final callRoomName = await callCtl.config.authenticated.getStringWithDefault(
      key: callRoomNameKey,
      defaultValue: '',
    );

    return callRoomName;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            transitionBuilder: (context, animated) => fromTopTransitionBuilder(
              context,
              animated,
              curve: const Interval(0.0, 0.5),
            ),
            duration: const Duration(milliseconds: 150),
            child: !isShowCallStatusOverAppbar
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 42.spMin,
                      color: context.theme.appColors.backgroundGrayLightPressed,
                      child: SafeArea(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space8),
                            child: Row(
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
                                if (roomName == null)
                                  FutureBuilder(
                                      future: getRoomCallName(),
                                      builder: (context, sp) {
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
                                  Flexible(
                                    child: AppText.body2Bold(
                                      roomName!,
                                      context: context,
                                      textAlign: TextAlign.center,
                                      color: context.theme.appColors.textPrimaryInverse,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                AppSpace.space2.horizontalSpace,
                                AppText.body2Bold(
                                  '|',
                                  context: context,
                                  textAlign: TextAlign.center,
                                  color: context.theme.appColors.textPrimaryInverse,
                                ),
                                AppSpace.space2.horizontalSpace,
                                AppText.body2Bold(
                                  callStatus!,
                                  context: context,
                                  textAlign: TextAlign.center,
                                  color: context.theme.appColors.textPrimaryInverse,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),

          // Custom leading, title and actions
          Expanded(
            child: SafeArea(
              top: !(isShowCallStatusOverAppbar),
              child: Padding(
                padding: appBarPadding,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: leadingCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        if (leading != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: paddingWidth),
                              width: leadingWidth?.spMin,
                              height: leadingCenter ? null : 50.spMin,
                              child: leading ?? const SizedBox.shrink(),
                            ),
                          ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: leadingCenter ? Alignment.center : Alignment.centerLeft,
                            child: title ?? const SizedBox.shrink(),
                          ),
                        ),
                        if (actions.isNotEmpty)
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ...actions.map((e) => Flexible(child: e)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
