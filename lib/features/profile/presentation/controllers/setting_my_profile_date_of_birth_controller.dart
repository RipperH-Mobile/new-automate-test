import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class SettingMyProfileDateOfBirthController extends GetxController {
  final userCtl = Get.find<UserController>();

  UserEntity? get user => userCtl.currentUser();

  final selectedDate = Rx<DateTime>(DateTime.now());
  final isChanged = false.obs;

  DateTime? initialValue;

  // Date constraints: 100 years in the past from today, maximum is 13 years ago
  DateTime get minimumDate {
    final now = DateTime.now();
    return DateTime(now.year - 100, now.month, now.day); // 100 years ago
  }

  DateTime get maximumDate {
    final now = DateTime.now();
    return DateTime(now.year - 13, now.month, now.day); // 13 years ago
  }

  void setInitialValue(DateTime? value) {
    DateTime dateToSet;

    if (value != null) {
      // Use the provided value (from preview or user's existing date)
      dateToSet = value;
      initialValue = value;
    } else if (user?.dBirthdate != null) {
      // Use user's existing birthdate
      dateToSet = user!.dBirthdate!;
      initialValue = user!.dBirthdate!;
    } else {
      // If no birthdate set, default to today
      dateToSet = DateTime.now();
      initialValue = null; // No initial value means first time setting
    }

    // Ensure the date is within valid bounds
    if (dateToSet.isBefore(minimumDate)) {
      dateToSet = minimumDate;
    } else if (dateToSet.isAfter(maximumDate)) {
      dateToSet = maximumDate;
    }

    // Set the date immediately without delay
    selectedDate.value = dateToSet;

    // Reset change tracking
    isChanged.value = false;

    // Force update to ensure CupertinoDatePicker uses correct initial date
    update();
  }

  void onDateChanged(DateTime newDate) {
    // Ensure the new date is within bounds
    if (newDate.isBefore(minimumDate)) {
      newDate = minimumDate;
    } else if (newDate.isAfter(maximumDate)) {
      newDate = maximumDate;
    }

    selectedDate.value = newDate;

    // Check if date has changed from initial value
    bool hasChanged = false;

    if (initialValue == null) {
      // First time setting - any selection is a change
      hasChanged = true;
    } else {
      // Compare with initial value
      hasChanged = !_isSameDate(newDate, initialValue);
    }

    isChanged.value = hasChanged;
  }

  bool _isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) return true;
    if (date1 == null || date2 == null) return false;

    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void handleBack() async {
    if (isChanged.value) {
      await UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Discard edit'.tr,
        description: 'Are you sure you want to discard your changes?'.tr,
        cancelText: 'Cancel'.tr,
        confirmText: 'Confirm'.tr,
        cancelTextColor: Get.context!.theme.appColors.textLight,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
        isDestructive: true,
        onCancel: () => Get.back(),
        onConfirm: () => Get.back(),
        barrierDismissible: false,
      );
    } else {
      Get.back();
    }
  }

  void handleFinish() {
    Get.back(result: selectedDate.value);
  }
}
