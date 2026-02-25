import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/constants/native_method_names.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';

/// Helper class for managing screen wake lock functionality.
/// 
/// This utility provides methods to prevent the screen from automatically
/// locking, which is useful for scenarios like:
/// - Video playback
/// - Reading long content
/// - Navigation
/// - Live streaming
/// - Video calls
class ScreenWakeLockHelper {
  ScreenWakeLockHelper._();

  /// Enables screen wake lock to prevent automatic screen lock.
  /// 
  /// This will keep the screen on and prevent it from automatically
  /// turning off due to inactivity timeout.
  /// 
  /// Returns `true` if wake lock was successfully enabled, `false` otherwise.
  static Future<bool> enable() async {
    try {
      if (GetPlatform.isAndroid) {
        final result = await GetIt.I<NativeMethodChannelService>()
            .invokeMethod<bool>(NativeMethodNames.enableScreenWakeLock);
        
        return result == true;
      }
      // For iOS and other platforms, you might want to add implementation
      // or use a cross-platform package like wakelock_plus
      
      return false;
    } catch (e) {
      debugPrint('Error enabling screen wake lock: $e');
      return false;
    }
  }

  /// Disables screen wake lock and allows normal auto lock behavior.
  /// 
  /// This will release the wake lock and allow the screen to automatically
  /// turn off based on the device's timeout settings.
  /// 
  /// Returns `true` if wake lock was successfully disabled, `false` otherwise.
  static Future<bool> disable() async {
    try {
      if (GetPlatform.isAndroid) {
        final result = await GetIt.I<NativeMethodChannelService>()
            .invokeMethod<bool>(NativeMethodNames.disableScreenWakeLock);
        
        return result == true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error disabling screen wake lock: $e');
      return false;
    }
  }

  /// Returns whether screen wake lock is currently enabled by querying the native side.
  static Future<bool> isEnabled() async {
    if (GetPlatform.isAndroid) {
      return await GetIt.I<NativeMethodChannelService>()
              .invokeMethod<bool>(NativeMethodNames.isScreenWakeLockHeld) ?? false;
    }
    return false;
  }

  /// Toggles screen wake lock state.
  ///
  /// If currently enabled, it will be disabled.
  /// If currently disabled, it will be enabled.
  ///
  /// Returns the new state after toggling by querying the native side again.
  static Future<bool> toggle() async {
    if (await isEnabled()) {
      await disable();
    } else {
      await enable();
    }
    // Query the native side again to get the actual current state
    return await isEnabled();
  }
}