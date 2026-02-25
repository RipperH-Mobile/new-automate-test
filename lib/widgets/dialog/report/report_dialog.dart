import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

import 'report_controller.dart';

class ReportDialog extends GetView<ReportController> {
  final Color actionRowMenuBackgroundColor;
  final Color actionRowMenuArrowColor;

  const ReportDialog({
    super.key,
    this.actionRowMenuBackgroundColor = const Color(0xFFF9F9F9),
    this.actionRowMenuArrowColor = const Color(0xFFCCCCCC),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Close keyboard on tap
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.isMobile)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                      bottom: 25,
                      left: 20,
                      right: 20,
                    ),
                    height: 6.spMin,
                    width: 65.spMin,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              if (controller.isMobile)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.getReportDialogTitle(),
                        style: TextStyle(
                          fontSize: 20.spMin,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: controller.closeReportModal,
                        child: Text(
                          'Cancel'.tr,
                          style: TextStyle(
                            color: UTheme.color.primary,
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: controller.closeReportModal,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(
                        width: 20.spMin,
                      ),
                      Expanded(
                        child: Text(
                          controller.getReportDialogTitle(),
                          style: TextStyle(
                            fontSize: 20.spMin,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: controller.handleCloseAllReportDialogs,
                        child: SizedBox(
                          width: 30.spMin,
                          child: Image.asset(
                            UChatAssetPath.clearIcon,
                            cacheWidth: 30.cacheSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (controller.isMobile)
                SizedBox(
                  height: 10.spMin,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: .7.sw,
                  child: Text(
                    controller.getReportDialogDescription(),
                    style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.spMin,
              ),
              Expanded(
                child: _buildReportBug(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget for report bug.
  Widget _buildReportBug() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Identify the problem'.tr,
            style: TextStyle(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 140.spMin,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextField(
            controller: controller.reportRemarkTextController,
            focusNode: controller.reportRemarkFocus,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxMessageInputLength)],
            keyboardType: TextInputType.multiline,
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            onChanged: controller.onChangedRemark,
            style: TextStyle(
              color: UTheme.color.scaffoldOnBackground,
              fontSize: 14.spMin,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintStyle: TextStyle(
                color: UTheme.color.inputHint,
                fontWeight: FontWeight.w400,
                fontSize: 14.spMin,
              ),
              hintMaxLines: 3,
              hintText: 'For example, encountering a problem of not being able to send messages to friends'.tr,
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
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Close keyboard on tap
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        Container(
          padding: controller.isMobile
              ? const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                )
              : const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 24,
                ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 15,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  return ElevatedButton(
                    key: const ValueKey('confirm'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor: const Color(0xFFF2F2F2),
                      backgroundColor: UTheme.color.primary,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      fixedSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.canSendReport.value ? controller.handleSendOtherReport : null,
                    child: Text(
                      'Send report'.tr,
                      style: TextStyle(
                        color: controller.canSendReport.value ? Colors.white : const Color(0xFFB3B3B3),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.spMin,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
