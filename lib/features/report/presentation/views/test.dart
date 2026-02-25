import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Test Screen'),
        AppFilledButton.primary(
          context: context,
          label: 'Try Me'.tr,
          onTap: () => {
            MainDialogController.handleOpenDialog(
              context: context,
              reportType: ReportType.reportUser,
              displayName: 'Kathy',
            ),
          },
        ),
      ],
    );
  }
}
