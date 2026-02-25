import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../enums/passcode_result.dart';

abstract class SecurityService extends GetxController {
  /// ------------------------------------------------
  /// Passcode Management
  /// ------------------------------------------------
  ///
  /// Passcode variable to store the passcode.
  bool get hasPasscode;

  List<BiometricType> get biometricTypes;

  Future<PasscodeResult> showVerifyPasscodeScreen({
    Function()? onShowed,
    Function()? callback,
    bool isDebug = false,
    bool? isFirstRouteToCalled,
  });

  Future<void> setPasscode(String passcode);

  Future<bool> verifyPasscode(String passcode);

  Future<void> clearPasscode();

  Future<bool> isPasscodeLocked();

  Future<void> setPreventPasscodeExecution(bool prevent);

  /// ------------------------------------------------
  /// Biometric Management
  /// ------------------------------------------------
  ///
  ///
  bool get isBiometricSupported;

  bool get enableBiometric;

  bool get enableAutoUseBiometric;

  Future<void> setEnableAutoUseBiometric(bool enable);

  Future<void> setEnableBiometric(bool enable);

  /// ------------------------------------------------
  /// Protection Screen Management
  /// ------------------------------------------------
  ///
  ///
  bool get isShowProtectionScreen;

  bool get isEnableProtectionScreen;

  Future<void> showProtectionScreen();

  Future<void> hideProtectionScreen();

  bool get isPreventTap;

  Future<void> activatePreventTap();

  /// ------------------------------------------------
  /// Initialization
  /// ------------------------------------------------
  Future<void> initialize();

  /// ------------------------------------------------
  /// Orchestration
  /// ------------------------------------------------
  Future<void> onAuthenticated();

  Future<void> onUnauthenticated();

  Future<void> onAppInactive();

  Future<void> onAppPause();

  Future<void> onAppResumed();

  /// ------------------------------------------------
  /// Shortcut passcode management
  /// ------------------------------------------------
  Future<bool> setShortcutPasscode({required String userId, required String? passcode});

  Future<void> clearShortcutPasscode();
}
