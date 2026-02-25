import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/screens/setting_privacy_policy/setting_privacy_policy_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SettingPrivacyPolicyScreen extends GetView<SettingPrivacyPolicyController> {
  const SettingPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      appBar: AppBarDefault(
        title: 'Privacy Policy'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: SafeArea(
        child: Obx(
          () {
            if (controller.fileUrl.value.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space4,
                bottom: AppSpace.space4,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                child: SfPdfViewer.network(
                  controller.fileUrl.value,
                  headers: HttpCaller().apiHeader,
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                  scrollDirection: PdfScrollDirection.vertical,
                  pageSpacing: AppSpace.space0,
                  canShowScrollHead: false,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
