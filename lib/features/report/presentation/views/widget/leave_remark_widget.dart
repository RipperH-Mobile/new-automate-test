import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/report/presentation/controller/leave_remark_controller.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class LeaveRemarkWidget extends StatelessWidget {
  LeaveRemarkWidget({super.key});

  final LeaveRemarkController controller = Get.find<LeaveRemarkController>();
  final MainDialogController mainDialogController = Get.find<MainDialogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: AppSpace.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report a Problem'.tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.5),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: AppSpace.space2, bottom: AppSpace.space3),
                    child: Text(
                      'Please submit a detailed report of the problem you encountered. Your identity will remain anonymous, and we will investigate the matter thoroughly.'
                          .tr,
                    )),
                TextField(
                  controller: controller.reportRemarkTextController,
                  focusNode: controller.reportRemarkFocus,
                  keyboardType: TextInputType.multiline,
                  onTapOutside: (event) => {
                    controller.reportRemarkFocus.unfocus(),
                  },
                  // expands: true,
                  inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxMessageInputLength)],
                  maxLines: 12,
                  minLines: 12,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                    hintText: 'Enter your problem'.tr,
                    counterText: '',
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFFE5E7EB),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSpace.space2),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFFE5E7EB),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              spacing: AppSpace.space4,
              children: [
                Obx(() {
                  if (controller.reportRemarkText.value.isEmpty) {
                    return ButtonTheme(
                        child: AppFilledButton.defaultButton(
                      context: context,
                      label: 'Continue'.tr,
                      onTap: () {},
                    ));
                  } else {
                    return ButtonTheme(
                        child: AppFilledButton.primary(
                      context: context,
                      label: 'Continue'.tr,
                      onTap: () {
                        mainDialogController.handleLeaveRemark(controller.reportRemarkText.value);
                      },
                    ));
                  }
                }),
                ButtonTheme(
                    child: AppOutlinedButton.defaultButton(
                  context: context,
                  label: 'Back'.tr,
                  onTap: () {
                    mainDialogController.onChangePage(-1);
                  },
                )),
              ],
            ),
          ],
        ));
  }
}
