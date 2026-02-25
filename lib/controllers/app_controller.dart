import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/services/premium_package_service.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/navigation/navigation_coordinator.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/screens/premium_packages/refund_and_ban/controllers/refund_and_ban_controller.dart';
import 'package:uchat/screens/premium_packages/refund_and_ban/screens/premium_package_refund_and_ban.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/announcement/maintenance_dialog.dart';
import 'package:uchat/widgets/sheet/share_to_uchat_controller.dart';

final _log = useLogger();

class AppController extends GetxController {
  static AppController get instance => Get.find();

  StreamSubscription? _userCheckedSubscription;
  StreamSubscription? _isSocketConnectedSub;
  StreamSubscription? _passcodeCheckedSub;

  final hasRunCheckAppVersion = false.obs;

  final maintenanceError = ''.obs;
  final isCanUpdate = false.obs;
  final hasCheckPasscode = false.obs;

  // `/room/:id/call` when :id is a uuid
  final roomCallRegex =
      RegExp(r'^/room/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/call$');

  bool bottomSheetQr = false;

  final isShowingDialog = false.obs;
  final isAlreadyShowedDialog = false.obs;

  final configGeneral = ConfigDb().general;

  final reviewPoint = 0.obs;
  final reviewText = ''.obs;
  final reviewTextController = TextEditingController();
  final reviewFocus = FocusNode();

  // final canSendReview = false.obs;

  @override
  void onInit() async {
    _passcodeCheckedSub = eventBus.on<PasscodeCheckedEvent>().listen(
      (event) async {
        if (maintenanceError.isNotEmpty) {
          ContactsController.instance.isContactsMaintenanceWasOn(true);
          ConnectivityController.instance.isConnectMaintenanceWasOn(true);

          showMaintenanceDialog(maintenanceError());
        }

        hasCheckPasscode(true);
      },
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.logAppOpen();
    initBackgroundDownloader();

    super.onInit();
  }

  @override
  void onClose() async {
    _userCheckedSubscription?.cancel();
    _isSocketConnectedSub?.cancel();
    _passcodeCheckedSub?.cancel();

    await FileDownloaderService.instance.dispose();
    reviewTextController.dispose();
    reviewFocus.dispose();
    super.onClose();
  }

  void initGoogleMap() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString('apiUrl', AppEnv.apiUrl);
        prefs.setString('googleApiKey', AppEnv.googleApiKey);
        if (Platform.isIOS) {
          // try to init google map in native ios with google api key set in share prefs
          GetIt.I<NativeMethodChannelService>().invokeMethod('initGoogleMap');
        }
      },
    );
  }

  void showMaintenanceDialog(String message) async {
    if (!Get.isRegistered<AppController>()) return;

    if (!GetIt.I<NavigationCoordinator>().firstRouteToIsCalled || isShowingDialog() || isAlreadyShowedDialog()) return;

    try {
      isShowingDialog(true);
      isAlreadyShowedDialog(true);

      await Get.dialog(
        MaintenanceDialog(
          isAnnouncement: false,
          maintenanceText: message,
        ),
      );
    } catch (e) {
      _log.e('Open maintenance dialog', e);
    }

    isShowingDialog(false);
  }

  Future<void> initBackgroundDownloader() async {
    await FileDownloaderService.instance.initial();
  }

  void initDefaultDesktopSaveTargetDirectoryPath() async {
    final fileServiceInstance = FileService.instance;

    if (UChatScreenUtil.instance.isDesktopPlatform) {
      await fileServiceInstance.setDefaultDesktopSaveTargetDirectoryPath();
    }
  }

  ShareToUChatController get shareCtl {
    if (!Get.isRegistered<ShareToUChatController>()) {
      Get.put(ShareToUChatController());
    }

    return Get.find<ShareToUChatController>();
  }

  void showDialogReviewPremium() {
    DateTime? reviewTime = UserController.instance.currentUser()?.premiumPackage?.nextReviewAt;
    DateTime? reviewAt = UserController.instance.currentUser()?.premiumPackage?.reviewAt;
    if (reviewTime != null &&
        (DateTime.now().isAtSameMomentAs(reviewTime) || DateTime.now().isAfter(reviewTime)) &&
        reviewAt == null) {
      UChatDialog.showDialog(
        barrierDismissible: false,
        title: 'Enjoying UChat Premium?'.tr,
        description: 'Hi there! We\'d love to know if you\'re having a great experience with Premium Package.'.tr,
        buttonDirection: Axis.vertical,
        confirmText: 'Rate UChat Premium'.tr,
        cancelText: 'Remind me later'.tr,
        closeDialogOnConfirm: false,
        onConfirm: () {
          Get.back();
          showPremiumReviewDialog();
        },
        onCancel: () {
          PremiumPackageService().sendRemindMeLater();
        },
      );
    }
  }

  Future<void> showRefundAndBan() async {
    final reviewTime = UserController.instance.currentUser()?.premiumPackage?.nextRefundReasonAt;
    final premiumPackageName = UserController.instance.currentUser()?.premiumPackage?.premiumPackageName;
    final periodType = UserController.instance.currentUser()?.premiumPackage?.periodType;

    if (premiumPackageName != null &&
        periodType != null &&
        reviewTime != null &&
        (DateTime.now().isAtSameMomentAs(reviewTime) || DateTime.now().isAfter(reviewTime))) {
      await Future.delayed(const Duration(milliseconds: 1000));
      Get.bottomSheet(
          GetBuilder<RefundAndBanController>(
            init: RefundAndBanController(),
            builder: (ctl) {
              return PremiumPackageRefundAndBan(premiumPackageName, periodType.displayName);
            },
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          barrierColor: const Color(0xff000000).withValues(alpha: 0.8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          backgroundColor: const Color(0xffFFFFFF));
    }
  }

  // TODO: Move to screen page
  void showPremiumReviewDialog() {
    Get.bottomSheet(
      ignoreSafeArea: false,
      isScrollControlled: true,
      SafeArea(
        bottom: false,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.spMin),
            topRight: Radius.circular(18.spMin),
          ),
          child: SizedBox(
            height: Get.height * 0.7,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              // appBar: Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10.spMin, horizontal: 20.spMin),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Icon(
              //         Icons.close_rounded,
              //         color: Colors.transparent,
              //       ),
              //       Text(
              //         'Rate UChat Premium'.tr,
              //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.spMin),
              //       ),
              //       GestureDetector(
              //         child: const Icon(Icons.close_rounded),
              //         onTap: () {
              //           Get.back();
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.spMin, horizontal: 20.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.close_rounded,
                          color: Colors.transparent,
                        ),
                        Text(
                          'Rate UChat Premium'.tr,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.spMin),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.close_rounded),
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                            height: 1,
                            color: Colors.black38,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.spMin, horizontal: 40.spMin),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'How was your experience?'.tr,
                                  style: const TextStyle(color: Color(0xFF4D4D4D), fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20.spMin,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.spMin),
                                  child: Obx(() {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        reviewPoint.value >= 1
                                            ? buildPremiumReviewStarBlue(point: 1)
                                            : buildPremiumReviewStar(point: 1),
                                        reviewPoint.value >= 2
                                            ? buildPremiumReviewStarBlue(point: 2)
                                            : buildPremiumReviewStar(point: 2),
                                        reviewPoint.value >= 3
                                            ? buildPremiumReviewStarBlue(point: 3)
                                            : buildPremiumReviewStar(point: 3),
                                        reviewPoint.value >= 4
                                            ? buildPremiumReviewStarBlue(point: 4)
                                            : buildPremiumReviewStar(point: 4),
                                        reviewPoint.value >= 5
                                            ? buildPremiumReviewStarBlue(point: 5)
                                            : buildPremiumReviewStar(point: 5),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.black38,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.spMin, horizontal: 20.spMin),
                            child: Text(
                              'Please tell us about your experience.'.tr,
                              style: const TextStyle(color: Color(0xFF4D4D4D), fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.spMin),
                            child: Container(
                              height: 188.spMin,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: reviewTextController,
                                focusNode: reviewFocus,
                                keyboardType: TextInputType.multiline,
                                expands: true,
                                maxLines: null,
                                maxLength: 20000,
                                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                textAlignVertical: TextAlignVertical.top,
                                onChanged: onChangedReviewText,
                                style: TextStyle(
                                  color: UTheme.color.scaffoldOnBackground,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintStyle: TextStyle(
                                    color: UTheme.color.inputHint,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  hintMaxLines: 3,
                                  hintText: 'Enter Your Opinion'.tr,
                                  counterText: '',
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFE6E6E6),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFE6E6E6),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  fillColor: const Color(0xFFF9F9F9),
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.spMin),
                  child: buildBottomButton(),
                ),
              ),
            ),
          ),
        ),
      ),
    ).whenComplete(clearReview);
  }

  Widget buildPremiumReviewStar({required int point}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.spMin),
      child: GestureDetector(
        child: ImageIcon(
          const AssetImage('assets/images/v2/icon_star.png'),
          size: 40.spMin,
          color: const Color(0xFFe6e6e6),
        ),
        onTap: () {
          reviewPoint.value = point;
        },
      ),
    );
  }

  Widget buildPremiumReviewStarBlue({required int point}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.spMin),
      child: GestureDetector(
        child: ImageIcon(
          const AssetImage('assets/images/v2/icon_star_blue.png'),
          size: 40.spMin,
          color: const Color(0xFF0057FF),
        ),
        onTap: () {
          reviewPoint.value = point;
        },
      ),
    );
  }

  Widget buildBottomButton() {
    return Obx(() {
      return Container(
        height: 80.spMin,
        padding: EdgeInsets.fromLTRB(
          20.spMin,
          20.spMin,
          20.spMin,
          0.spMin,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: SizedBox(
          width: Get.width,
          child: TextButton(
            onPressed: reviewPoint.value > 0
                ? () {
                    PremiumPackageService().sendReview(
                      request: SendReviewRequest(
                        rating: reviewPoint.value,
                        description: reviewText.value,
                      ),
                    );
                    UChatLoading.showTextAndIcon(
                      status: 'Sent'.tr,
                      assetPath: 'assets/images/v2/icon_sent.png',
                    );
                    Get.back();
                  }
                : () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                reviewPoint.value > 0 ? const Color(0xff0057ff) : const Color(0xFFF2F2F2),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(
              'Done'.tr,
              style: reviewPoint.value > 0
                  ? TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.spMin)
                  : TextStyle(color: const Color(0xFF999999), fontWeight: FontWeight.w600, fontSize: 16.spMin),
            ),
          ),
        ),
      );
    });
  }

  void onChangedReviewText(String? text) {
    final text = reviewTextController.value.text.trim();
    reviewText.value = text;
  }

  void clearReview() {
    reviewPoint.value = 0;
    reviewText.value = '';
    reviewTextController.clear();
    PremiumPackageService().sendRemindMeLater();
  }

  UserController get userCtl {
    return Get.find<UserController>();
  }
}
