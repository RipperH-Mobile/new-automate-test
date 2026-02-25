import 'package:flutter/services.dart';

class VibrateUtil {
  Future<void> vibrateLight() async {
    await HapticFeedback.lightImpact();
  }

  Future<void> vibrateSuccess() async {
    await HapticFeedback.heavyImpact();
  }

  Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }

  Future<void> vibrateSelection() async {
    await HapticFeedback.mediumImpact();
  }

  Future<void> vibrateError() async {
    await HapticFeedback.heavyImpact();
  }

  Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }
}
