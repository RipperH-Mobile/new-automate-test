// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uchat/core/extensions/theme_extensions.dart';
// import 'package:uchat/core/theme/app_space.dart';
// import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
// import 'package:uchat/features/call/views/widgets/element/call_title.dart';
// import 'package:uchat/features/call/utils/enum.dart';
// import 'package:uchat/features/call/utils/type.dart';
// import 'package:uchat/widgets/button/app_control_button.dart';

// const appBarHeight = 150.0;

// class CallAppBarMobile<C extends UChatLiveKitController?> extends StatelessWidget implements PreferredSizeWidget {
//   final C? controller;
//   final StringWidgetBuilder? status;
//   final StringWidgetBuilder? titleWidget;

//   const CallAppBarMobile({
//     super.key,
//     required this.controller,
//     this.status,
//     this.titleWidget,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(appBarHeight);

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null) {
//       return callAppBarVoice(
//         context,
//       );
//     }
//     return Obx(
//       () {
//         if (controller?.fullScreen() == true) {
//           return const SizedBox.shrink();
//         }
//         final uiState = controller?.uiState();
//         final isDisconnected = controller?.isDisconnected();
//         final title = '${controller!.callData.title}';
//         final txtStatus = controller!.isRecording() ? controller!.callDuration() : controller!.status();
//         return buildAppBar(
//           uiState!,
//           isDisconnected!,
//           context,
//           title,
//           txtStatus,
//         );
//       },
//     );
//   }

//   Widget buildAppBar(
//     UiCallState uiState,
//     bool isDisconnected,
//     context,
//     String? title,
//     String? txtStatus,
//   ) {
//     switch (uiState) {
//       case UiCallState.video:
//         return callAppBarVideo(isDisconnected);
//       case UiCallState.voice:
//       case UiCallState.outgoing:
//       case UiCallState.incoming:
//       case UiCallState.group:
//       case UiCallState.ringing:
//     }
//     return callAppBarVoice(
//       context,
//       title: title,
//       txtStatus: txtStatus,
//     );
//   }

//   AppBar callAppBarVideo(bool isDisconnected) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       title: CallTitleWidget(
//         title: controller?.callData.title ?? '',
//       ),
//       centerTitle: false,
//       leading: isDisconnected == true
//           ? null
//           : IconButton(
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//     );
//   }

//   AppBar callAppBarVoice(
//     BuildContext context, {
//     String? title,
//     String? txtStatus,
//   }) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       toolbarHeight: appBarHeight,
//       centerTitle: true,
//       leading: Padding(
//         padding: const EdgeInsets.only(
//           top: AppSpace.space2,
//           left: AppSpace.space4,
//         ),
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: AppControlButton.back(
//             context: context,
//             actionColor: context.theme.appColors.textPrimaryInverse,
//             iconColor: context.theme.appColors.iconPrimaryInverse,
//           ),
//         ),
//       ),
//       leadingWidth: AppSpace.space24,
//       flexibleSpace: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: AppSpace.space2,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppSpace.space16,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // const SizedBox(
//                     //   height: 35 + 10,
//                     // ),
//                     if (titleWidget != null)
//                       titleWidget!(context, title ?? 'Unknown user'.tr)
//                     else
//                       CallTitleWidget(
//                         title: title ?? 'Unknown user'.tr,
//                       ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     if (status != null)
//                       status!(
//                         context,
//                         txtStatus ?? '',
//                       ),
//                     // const SizedBox(
//                     //   height: 15,
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class CallAppBarMobile extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final bool showBackButton;
  final bool enableBackButton;
  final VoidCallback? onBack;

  const CallAppBarMobile({
    super.key,
    this.title,
    this.action,
    this.showBackButton = true,
    this.enableBackButton = true,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(
                top: AppSpace.space3,
                left: AppSpace.space4,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: enableBackButton ? 1 : 0.5,
                  child: AppControlButton.back(
                    context: context,
                    actionColor: context.theme.appColors.textPrimaryInverse,
                    iconColor: context.theme.appColors.iconPrimaryInverse,
                    onTap: () {
                      if (enableBackButton) {
                        if (onBack != null) {
                          onBack!();
                        } else {
                          Get.back();
                        }
                      }
                    },
                  ),
                ),
              ),
            )
          : null,
      actions: [
        if (action != null)
          Padding(
            padding: const EdgeInsets.only(
              right: AppSpace.space4,
            ),
            child: Align(
              alignment: Alignment.center,
              child: action!,
            ),
          ),
      ],
      leadingWidth: AppSpace.space24,
      title: title,
      titleSpacing: 0,
      // flexibleSpace: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.only(
      //       top: AppSpace.space2,
      //       left: AppSpace.space16,
      //       right: AppSpace.space16,
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.min,
      //       children: [

      //         if (title != null)
      //           title!
      //         else
      //           CallTitleWidget(
      //             title: 'Unknown user'.tr,
      //           ),

      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
