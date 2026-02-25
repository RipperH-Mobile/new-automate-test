/// Constants for native method channel names used across the application.
///
/// This class provides a centralized location for all method names used with
/// [NativeMethodChannelService] to communicate with native platform code.
class NativeMethodNames {
  const NativeMethodNames._();

  /// Method to check if the device screen is currently locked.
  ///
  /// Returns a [bool] indicating whether the screen is locked.
  /// - On Android: Uses KeyguardManager.isKeyguardLocked
  /// - On iOS: Uses UIApplication notifications to track lock state
  static const String isScreenLocked = 'isScreenLocked';

  /// Method to enable screen wake lock to prevent auto screen lock.
  ///
  /// Keeps the screen on and prevents it from automatically locking.
  /// Useful for scenarios like video playback, reading, or navigation.
  /// - On Android: Uses PowerManager.SCREEN_BRIGHT_WAKE_LOCK
  static const String enableScreenWakeLock = 'enableScreenWakeLock';

  /// Method to disable screen wake lock and allow normal auto lock behavior.
  ///
  /// Releases the wake lock and allows the screen to auto lock normally.
  /// Should be called when wake lock is no longer needed to save battery.
  /// - On Android: Releases PowerManager wake lock
  static const String disableScreenWakeLock = 'disableScreenWakeLock';

  /// Method to check if screen wake lock is currently held/active.
  ///
  /// Returns a [bool] indicating whether the screen wake lock is currently active.
  /// This can be used to verify the current state of the wake lock before
  /// enabling or disabling it.
  /// - On Android: Checks PowerManager wake lock isHeld() status
  static const String isScreenWakeLockHeld = 'isScreenWakeLockHeld';

  /// Method to set Android call mode to Bluetooth.
  ///
  /// Switches audio routing to Bluetooth device during calls.
  /// - On Android: Uses AudioManager.setCommunicationDevice() on API 31+ or startBluetoothSco() on older versions, with MODE_IN_COMMUNICATION
  static const String androidCallModeBluetooth = 'androidCallModeBluetooth';

  /// Method to set Android call mode to earpiece.
  ///
  /// Switches audio routing to earpiece/receiver during calls.
  /// - On Android: Uses AudioManager.setSpeakerphoneOn(false) and MODE_IN_COMMUNICATION
  static const String androidCallModeEarpiece = 'androidCallModeEarpiece';

  /// Method to set Android call mode to speaker.
  ///
  /// Switches audio routing to speakerphone during calls.
  /// - On Android: Uses AudioManager.setSpeakerphoneOn(true) and MODE_IN_COMMUNICATION
  static const String androidCallModeSpeaker = 'androidCallModeSpeaker';

  /// Method to stop native performance trace for incoming call latency.
  ///  
  /// Called when the native UI is ready to indicate that the incoming call screen has loaded.
  static const String stopNativeTrace = 'stopNativeTrace';

  /// Method to start native performance trace for incoming call latency.
  /// 
  /// Called when an incoming call is received to begin measuring latency until UI is ready. 
  /// Used on both Android and iOS platforms.
  static const String startNativeTrace = 'startNativeTrace';
}
