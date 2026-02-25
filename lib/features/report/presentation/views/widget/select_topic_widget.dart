import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/features/report/presentation/controller/select_topic_controller.dart';
import 'package:easy_radio/easy_radio.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';

class SelectTopicWidget extends StatelessWidget {
  SelectTopicWidget({super.key});

  final SelectTopicController controller = Get.put<SelectTopicController>(SelectTopicController());

  final MainDialogController mainDialogController = Get.find<MainDialogController>();

  onInit() {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                padding: const EdgeInsets.only(top: AppSpace.space2, right: AppSpace.space4),
                child: Text(
                  'Please submit a detailed report of the problem you encountered. Your identity will remain anonymous, and we will investigate the matter thoroughly.'
                      .tr,
                )),
            Padding(
                padding: const EdgeInsets.only(top: AppSpace.space4),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => Container(
                            constraints: const BoxConstraints(
                              minHeight: 60,
                            ),
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1))),
                            child: Row(
                              children: [
                                Expanded(child: Text(controller.reportTopics[index])),
                                Padding(
                                  padding: const EdgeInsets.only(right: AppSpace.space4),
                                  child: EasyRadio<ReportTopic>(
                                    dotRadius: 6,
                                    radius: 12,
                                    activeFillColor: const Color(0xFF0056FD),
                                    activeBorderColor: const Color(0xFF0056FD),
                                    dotColor: Colors.white,
                                    value: ReportTopic.fromText(controller.reportTopics[index]),
                                    animateFillColor: true,
                                    groupValue: controller.selectedTopic.value,
                                    onChanged: (ReportTopic? value) {
                                      controller.setSelectedTopic =
                                          ReportTopic.fromText(controller.reportTopics[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                    itemCount: controller.reportTopics.length)),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(right: AppSpace.space4),
            child: Column(
              spacing: AppSpace.space4,
              children: [
                ButtonTheme(
                    child: AppFilledButton.primary(
                  context: context,
                  label: 'Continue'.tr,
                  onTap: () {
                    mainDialogController.handleConfirmReportTopic(controller.selectedTopic.value);
                  },
                )),
                ButtonTheme(
                    child: AppOutlinedButton.defaultButton(
                  context: context,
                  label: 'Cancel'.tr,
                  onTap: () {
                    Get.back();
                  },
                )),
              ],
            )),
      ],
    );
  }
}
