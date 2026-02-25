import 'dart:async';

import 'package:get/get.dart';

class ToastWithUndoController extends GetxController {
  ToastWithUndoController();

  final countdown = 5.obs;
  Timer? countdownTimer;

  @override
  void onReady() {
    setupCountdownTimer();
    super.onReady();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  void restartCountdown() {
    countdown(5);
    setupCountdownTimer();
  }

  void setupCountdownTimer() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
        update(['countdown_text']);
      } else {
        timer.cancel();
        Get.delete<ToastWithUndoController>();
      }
    });
  }
}
