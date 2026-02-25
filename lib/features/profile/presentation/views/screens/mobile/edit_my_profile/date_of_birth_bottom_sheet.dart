import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';

import 'package:uchat/widgets/app_text.dart';

class DateOfBirthBottomSheet extends StatelessWidget {
  final DateTime? initialValue;

  const DateOfBirthBottomSheet({
    super.key,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingMyProfileDateOfBirthController());

    // Set initial value immediately, not in post frame callback
    controller.setInitialValue(initialValue);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.handleBack,
                  child: AppText.body1(
                    'Cancel'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimary,
                  ),
                ),
                AppText.title3(
                  'Date of birth'.tr,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: controller.handleFinish,
                  child: AppText.body1Bold(
                    'Done'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // iOS-style Date Picker
          Expanded(
            child: Obx(() => CupertinoTheme(
                  data: CupertinoTheme.of(context).copyWith(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: context.theme.appTexts.title1.copyWith(),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: controller.selectedDate.value,
                    minimumDate: controller.minimumDate,
                    maximumDate: controller.maximumDate,
                    onDateTimeChanged: controller.onDateChanged,
                    backgroundColor: Colors.transparent,
                    dateOrder: DatePickerDateOrder.dmy,
                    minimumYear: controller.minimumDate.year,
                    maximumYear: controller.maximumDate.year,
                  ),
                )),
          ),

          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
