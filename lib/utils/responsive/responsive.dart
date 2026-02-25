// import 'package:dual_screen/dual_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uchat/routes/app_pages.dart';
// // import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
// import 'package:uchat/utils/responsive/tablet_layout_controller.dart';

// // final _log = useLogger();

// class ResponsiveProvider extends StatelessWidget {
//   final Widget child;

//   const ResponsiveProvider({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   static bool isMobile() => Get.width < 650;

//   static bool isTablet() => Get.width >= 650;

//   static layoutBuilder({void Function()? mobile, void Function()? tablet}){
//     if (isTablet()) {
//       tablet?.call();
//     } else {
//       mobile?.call();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//           builder: (context, constraints) {
//             if (constraints.maxWidth >= 650) {
//               if ((constraints.maxWidth / 650) * 100 < 140) {
//                 // if max width less than 140% of 650 it should change pane size to 0.45 (45%) for fix left panel size
//                 TabletLayoutController.to.paneProp(0.45);
//               } else {
//                 TabletLayoutController.to.paneProp(0.40);
//               }
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 TabletLayoutController.to.pageController(PageController(
//                     initialPage:
//                         TabletLayoutController.to.rightPanelWidget.length - 1));
//               });
//               TabletLayoutController.to.paneProportion(TwoPanePriority.both);
//             } else {
//               if (Get.routing.current == Routes.HOME &&  TabletLayoutController.to.rightPanelWidget.length > 1) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   TabletLayoutController.to.pageController(PageController(
//                       initialPage: TabletLayoutController.to.rightPanelWidget.length - 1));
//                 });
//                 TabletLayoutController.to.paneProportion(TwoPanePriority.end);
//               } else {
//                 TabletLayoutController.to.paneProportion(TwoPanePriority.start);
//               }
//             }
//             return child;
//           },
//         );
//   }
// }

// class ResponsiveHelper extends StatelessWidget {
//   final Widget child;

//   const ResponsiveHelper({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   static bool isMobile() => Get.width < 650;

//   static bool isTablet() => Get.width >= 650;

//   static layoutBuilder({void Function()? mobile, void Function()? tablet}) {
//     if (isTablet()) {
//       tablet?.call();
//     } else {
//       mobile?.call();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth >= 650) {
//           final checker = [
//             Routes.SPLASH,
//             Routes.WELCOME,
//             Routes.LOGIN,
//             Routes.VERIFY_OTP,
//             Routes.HOME,
//             Routes.LOGOUT,
//             Routes.PASSCODE,
//           ];
//           if (!checker.contains(Get.routing.current)) {
//             // TODO Implement when Mobile to Tablet animation
//           }
//         } else {
//           // TODO Implement when Tablet to Mobile animation
//         }
//         return child;
//       },
//     );
//   }
// }
