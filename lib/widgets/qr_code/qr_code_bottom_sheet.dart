import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/features/add_contact/presentation/widgets/my_qr_code.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/qr_code/qr_code_controller.dart';

class QrCodeBottomSheet {
  static Future<void> show({
    required String username,
    required String displayName,
    String? title,
  }) async {
    await Get.bottomSheet(
      GetBuilder<QrCodeController>(
        init: QrCodeController(
          username: username,
          displayName: displayName,
        ),
        builder: (ctl) {
          return _QrCodeScreen(
            title: title,
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  static Future<void> showFromUserEntity(UserEntity user) async {
    if (user.username?.isEmpty == true || user.displayName?.isEmpty == true) {
      return;
    }
    await Get.bottomSheet(
      GetBuilder<QrCodeController>(
        init: QrCodeController(
          username: user.username!,
          displayName: user.displayName!,
          onClickSave: () {
            GetIt.I<TaxonomyService>().sendEvent(EventName.clickSaveMyQR);
          },
          onClickShare: () {
            GetIt.I<TaxonomyService>().sendEvent(EventName.clickShareMyQR);
          },
          onSaved: () {
            GetIt.I<TaxonomyService>().sendEvent(EventName.myQRSaved);
          },
        ),
        builder: (ctl) {
          return _QrCodeScreen(
            title: 'My QR Code'.tr,
          );
        },
      ),
      isScrollControlled: true,
    );
  }
}

class _QrCodeScreen extends GetView<QrCodeController> {
  final String? title;
  const _QrCodeScreen({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF25282B),
              Color(0xFF48515C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                AppSpace.space4,
                75.spMin,
                AppSpace.space4,
                AppSpace.space10,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFDDE1E8),
                    Color(0xFFFFFFFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppRadius.rounded3xl,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: AppSize.size8,
                      ),
                      AppText.button2Bold(
                        title ?? 'QR code'.tr,
                        color: context.theme.appColors.textDarkest,
                        lineHeight: 1,
                        context: context,
                      ),
                      SizedBox(
                        height: AppSize.size8,
                        width: AppSize.size8,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: controller.handleBack,
                          child: Assets.vectors.xClose.svg(
                            colorFilter: ColorFilter.mode(
                              context.theme.appColors.icon,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    return FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(Get.width / 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                          child: RepaintBoundary(
                            key: controller.qrCodeGlobalKey,
                            child: MyQrCode(
                              qrCodeData: controller.qrCodeData.value,
                              width: 1000,
                              height: 1000,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(
                                AppSpace.space8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Column(
                    children: [
                      AppText.title2(
                        controller.displayName,
                        color: context.theme.appColors.textDarkest,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        context: context,
                      ),
                      AppSpace.space1.verticalSpace,
                      AppText.body3(
                        controller.username,
                        color: context.theme.appColors.textLight,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppText.body3(
                    'Use this QR code for other to scan\nand add you as a friend'.tr,
                    color: context.theme.appColors.textLightest,
                    textAlign: TextAlign.center,
                    context: context,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        'Share'.tr,
                        Assets.vectors.qrShareIcon.svg(),
                        controller.handleShareQr,
                        context,
                      ),
                      AppSpace.space3.horizontalSpace,
                      _buildButton(
                        'Save'.tr,
                        Assets.vectors.qrDownloadIcon.svg(),
                        () => controller.handleDownloadQr(context),
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Widget icon, void Function() onTap, BuildContext context) {
    return SizedBox(
      width: 154.spMin,
      child: AppFilledButton.black(
        context: context,
        label: text,
        icon: icon,
        size: AppButtonSize.medium,
        style: AppButtonStyle.fullRounded,
        onTap: onTap,
      ),
    );
  }
}
