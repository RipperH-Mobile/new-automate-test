import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/features/report/presentation/views/widget/confirm_report_widget.dart';
import 'package:uchat/features/report/presentation/views/widget/leave_remark_widget.dart';
import 'package:uchat/features/report/presentation/views/widget/select_topic_widget.dart';

class MainDialog extends GetView<MainDialogController> {
  const MainDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          top: AppSpace.space4,
          bottom: AppSpace.space8,
        ),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpace.space6,
              ),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(
            left: AppSpace.space4,
            top: AppSpace.space4,
            bottom: AppSpace.space4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                    left: 20,
                    right: 20,
                  ),
                  height: 5.spMin,
                  width: 48.spMin,
                  decoration: BoxDecoration(
                    color: const Color(0xBDBDBDBD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  children: [
                    SelectTopicWidget(),
                    LeaveRemarkWidget(),
                    ConfirmReportWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
