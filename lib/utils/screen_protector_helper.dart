import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class ScreenProtectorHelper {
  static String? roomId;
  static bool isBottomSheetVisible = false;

  static Future<void> turnOn(String id) async {
    try {
      // For debug and test purpose, If this is true do not set protect screen record to true.
      bool? isRecordEnable =
          await ConfigDb().authenticated.getBool(key: ConfigDb.getEnableScreenRecordInSecretChatConfigKey());
      if (isRecordEnable == true) return;
    } catch (e, stackTrace) {
      _log.e('get enableScreenRecord setting error.', e, stackTrace);
    }

    try {
      roomId = id;
      await ScreenProtector.protectDataLeakageWithColor(Colors.black);
      if (GetPlatform.isAndroid) {
        await ScreenProtector.protectDataLeakageOn();
      } else {
        await ScreenProtector.preventScreenshotOn();
      }
      ScreenProtector.addListener(
        _onScreenshotTaken,
        _onScreenRecordingChanged,
      );

      // Check if screen recording is already active
      await _checkScreenRecording();
    } catch (e, stackTrace) {
      _log.e('ScreenProtector turnOn error.', e, stackTrace);
    }
  }

  static Future<void> turnOff() async {
    try {
      ScreenProtector.removeListener();
      if (GetPlatform.isIOS) {
        await ScreenProtector.preventScreenshotOff();
      }
      await ScreenProtector.protectDataLeakageOff();
    } catch (e, stackTrace) {
      _log.e('ScreenProtector turnOff error.', e, stackTrace);
    }
  }

  static Future<void> _checkScreenRecording() async {
    bool isRecording = await ScreenProtector.isRecording();
    if (isRecording) {
      await _onScreenshotOrRecordingTaken();
    }
  }

  static Future<void> _onScreenshotOrRecordingTaken() async {
    if (isBottomSheetVisible) {
      return; // Prevent showing multiple bottom sheets
    }
    isBottomSheetVisible = true;

    // Post data to the server before showing the bottom sheet
    if (roomId != null) {
      // TODO (refactor clean) Move this logic to use case ?
      await GetIt.I<ChatRoomApiService>().notifyCaptureScreenInSecretChat(roomId!);
    }

    Get.bottomSheet(
      Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(16.spMin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/v2/warning_prevent_screen.png',
              width: 140.spMin,
              height: 140.spMin,
            ),
            SizedBox(height: 20.h),
            Text(
              'Unable to proceed'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Screenshot and screen recording are restricted \nby UChat\'s information security policy. Please \nturn off screen recording before use.'
                  .tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.back();
                isBottomSheetVisible = false;
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                fixedSize: Size(390.w, 55.h),
                foregroundColor: UTheme.color.onPrimary,
                backgroundColor: UTheme.color.primary,
              ),
              child: Text(
                'Got it'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UTheme.color.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 45.h),
          ],
        ),
      ),
      isScrollControlled: true,
    ).whenComplete(() {
      isBottomSheetVisible = false;
    });
  }

  static void _onScreenshotTaken() {
    _onScreenshotOrRecordingTaken();
  }

  static void _onScreenRecordingChanged(bool isRecording) {
    if (isRecording) {
      _onScreenshotOrRecordingTaken();
    }
  }
}
