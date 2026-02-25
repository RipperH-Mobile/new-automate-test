import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ConfirmReportWidget extends StatelessWidget {
  ConfirmReportWidget({super.key});

  final MainDialogController mainDialogController = Get.find<MainDialogController>();

  String _buildReportTypeDetailText() {
    if (mainDialogController.reportUserCase.reportEntity.getReportTopic == ReportTopic.spam) {
      return ' There are repeated messages trying to deceive users into clicking on suspicious links.'.tr;
    } else if (mainDialogController.reportUserCase.reportEntity.getReportTopic == ReportTopic.harassment) {
      return ' here are repeated message unwanted behavior that causes distress or harm, often through bullying, threats, or intimidation.'
          .tr;
    } else if (mainDialogController.reportUserCase.reportEntity.getReportTopic == ReportTopic.inappropriateContent) {
      return ' There repeated message is material that is offensive, harmful, or unsuitable for certain audiences, including explicit, abusive, or offensive language and images.'
          .tr;
    } else {
      return '';
    }
  }

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
                'Confirm the report'.tr,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.5),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSpace.space2),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'Do you want to report that the '.tr,
                        style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: mainDialogController.displayName,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                          text: ' account has issues '.tr,
                          style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: mainDialogController.reportUserCase.reportEntity.getReportTopic.text,
                          style: TextStyle(fontSize: 14.spMin, color: Colors.red, fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: _buildReportTypeDetailText(),
                          style: TextStyle(
                            fontSize: 14.spMin,
                            color: Colors.red,
                          )),
                      TextSpan(text: '?', style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: AppSpace.space4,
            children: [
              if (mainDialogController.reportType != ReportType.reportGroup)
                ButtonTheme(
                    child: AppFilledButton.error(
                  context: context,
                  label: 'Report & Block '.tr + mainDialogController.displayName,
                  onTap: () async {
                    String typeReport = mainDialogController.reportUserCase.reportEntity.getReportTopic.text;
                    if (mainDialogController.reportType.value == ReportType.reportMessage) {
                      GetIt.I<TaxonomyService>().sendEvent(EventName.messageReported,
                          eventProperties: EventProperty.messageReported(typeReport, 'report & block'));
                    } else {
                      GetIt.I<TaxonomyService>().sendEvent(EventName.contactReported,
                          eventProperties: EventProperty.contactReported(typeReport, 'report & block',
                              mainDialogController.reportType.value == ReportType.reportGroup ? 'groups' : 'friends'));
                    }
                    await mainDialogController.handleReport();
                    await mainDialogController.handleBlock();
                    mainDialogController.closeDialog();
                  },
                )),
              if (mainDialogController.reportType == ReportType.reportGroup && mainDialogController.enableLeaveGroup)
                ButtonTheme(
                    child: AppFilledButton.error(
                  context: context,
                  label: 'Report & Leave group'.tr,
                  onTap: () async {
                    String typeReport = mainDialogController.reportUserCase.reportEntity.getReportTopic.text;
                    GetIt.I<TaxonomyService>().sendEvent(EventName.contactReported,
                        eventProperties: EventProperty.contactReported(typeReport, 'report & leave group', 'groups'));
                    late final String title;
                    late final String description;
                    if (mainDialogController.isOwnerInGroup == true) {
                      title = 'Leave group as owner'.tr;
                      description =
                          'If you leave this group, ownership will be transferred to the first member who joined after you. \n\nAre you sure you want to leave?'
                              .tr;
                    } else {
                      title = 'Leave this group'.tr;
                      description = 'Leaving this group will remove access to the member list and chat history.'.tr;
                    }
                    UChatNewDialog.showDialog(
                      context: Get.context!,
                      title: title,
                      description: description,
                      confirmText: 'Leave'.tr,
                      onConfirm: () async {
                        await mainDialogController.handleReport();
                        await mainDialogController.handleLeaveGroup();
                        mainDialogController.backToHomeIfNeeded();
                      },
                      confirmTextColor: Get.context!.theme.appColors.textError,
                      cancelTextColor: Get.context!.theme.appColors.textLight,
                      isDestructive: true,
                    );
                  },
                )),
              ButtonTheme(
                  child: AppFilledButton.primary(
                context: context,
                label: 'Report only'.tr,
                onTap: () async {
                  String typeReport = mainDialogController.reportUserCase.reportEntity.getReportTopic.text;
                  if (mainDialogController.reportType.value == ReportType.reportMessage) {
                    GetIt.I<TaxonomyService>().sendEvent(EventName.messageReported,
                        eventProperties: EventProperty.messageReported(typeReport, 'report only'));
                  } else {
                    GetIt.I<TaxonomyService>().sendEvent(EventName.contactReported,
                        eventProperties: EventProperty.contactReported(typeReport, 'report only',
                            mainDialogController.reportType.value == ReportType.reportGroup ? 'groups' : 'friends'));
                  }
                  await mainDialogController.handleReport();
                  mainDialogController.closeDialog();
                },
              )),
              ButtonTheme(
                child: AppOutlinedButton.defaultButton(
                  context: context,
                  label: 'Back'.tr,
                  onTap: () {
                    mainDialogController.onChangePage(-1);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
