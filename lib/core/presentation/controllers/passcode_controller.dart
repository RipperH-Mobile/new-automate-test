import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/find_user_with_shortcut_passcode_use_case.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import '../../domain/constants/passcode.dart';
import '../../domain/enums/passcode_mode.dart';
import '../../domain/enums/passcode_result.dart';
import '../../domain/services/security_service.dart';
import '../arguments/passcode_arguments.dart';

final _log = useLogger();

class PasscodeIds {
  static const String main = 'passcode_main_builder';
}

class PasscodeController extends GetxController {
  final arguments = Get.arguments as PasscodeArguments;

  final configGeneral = ConfigDb().general;
  final localAuth = LocalAuthentication();

  final warningLabel = ''.obs;
  final setupPasscodeString = ''.obs;
  final setupShortcutPasscodeString = ''.obs;
  final errorTitle = ''.obs;
  final isBiometricSupported = false.obs;
  final isBiometricSupportedType = BiometricType.fingerprint.obs;
  final passcode = <String?>[].obs;
  final isError = false.obs;
  final isDisable = false.obs;
  final lastSettingState = ''.obs;
  final isVerifiedForAction = false.obs;
  final disableTime = 120.obs;

  final isHideCloseButton = false.obs;

  Timer? _disableTimer;

  final numPads = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'NONE',
    '0',
    'BACKSPACE',
  ].obs;

  SecurityService get securityService => GetIt.I<SecurityService>();

  final isInSetupConfirmation = false.obs;
  final isInChangeConfirmation = false.obs;
  final isInShortcutSetupConfirmation = false.obs;
  final isInShortcutChangeConfirmation = false.obs;

  // Make sure these constants are defined correctly
  static const int maxIncorrectSteak = 5; // Maximum incorrect attempts before lock
  static const Duration startBlockDuration = Duration(minutes: 2); // Lock duration

  @override
  void onInit() {
    passcode([...emptyPassCode]);
    if (arguments.mode == PasscodeMode.setup) {
      initSetupPasscode();
    } else if (arguments.mode == PasscodeMode.disable) {
      initDisablePasscode();
    } else if (arguments.mode == PasscodeMode.verify) {
      initEnterPasscode();
    } else if (arguments.mode == PasscodeMode.change) {
      // Check if we should skip old passcode verification
      if (arguments.skipPasscodeVerification) {
        isVerifiedForAction.value = true; // Mark as already verified
        initChangePasscode(); // Go directly to new passcode setup
      } else {
        initChangePasscodeVerify(); // Normal flow - verify old passcode first
      }
    } else if (arguments.mode == PasscodeMode.setupShortcut) {
      initSetupShortcutPasscode();
    } else if (arguments.mode == PasscodeMode.changeShortcut) {
      initChangeShortcutPasscode();
    } else if (arguments.mode == PasscodeMode.logout) {
      initEnterPasscode();
    }

    isHideCloseButton(arguments.isHideCloseButton);

    isError.listen((p0) {
      if (p0) {
        Future.delayed(const Duration(seconds: 2), () {
          if (isError()) isError(false);
        });
      }
    });

    checkBiometric();

    // Reset confirmation states
    isInSetupConfirmation(false);
    isInChangeConfirmation(false);
    isInShortcutSetupConfirmation(false);
    isInShortcutChangeConfirmation(false);
    update([PasscodeIds.main]);

    super.onInit();
  }

  @override
  void onClose() {
    _disableTimer?.cancel();

    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    arguments.onShowed?.call();
  }

  void onStartCountdownTimer() {
    useLogger().d('PPP => onStartCountdownTimer, disableTime: ${disableTime()}');

    if (_disableTimer?.isActive == true) {
      _disableTimer?.cancel();
    }

    isDisable(true);

    _disableTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      useLogger().d('PPP => Timer tick, remaining: ${disableTime()}');

      if (disableTime() <= 0) {
        useLogger().d('PPP => Timer finished, re-enabling');
        isDisable(false);
        warningLabel('');
        await resetPasscodeCheck();
        onBackToLastSettingState();
        timer.cancel();
      } else {
        disableTime(disableTime() - 1);
        // Show countdown message
        final minutes = (disableTime() / 60).floor();
        final seconds = disableTime() % 60;
        final getDisableCountdownTime = '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';

        warningLabel(
          'You have entered an incorrect PIN \ntoo many times. Please wait another \n@minutes minutes'.trParams(
            {
              'minutes': getDisableCountdownTime,
            },
          ),
        );
      }
    });
  }

  Future<void> checkBiometric() async {
    final biometricEnabled = securityService.enableBiometric;

    if (arguments.mode == PasscodeMode.verify) {
      final availableBiometrics = securityService.biometricTypes;

      if (securityService.isBiometricSupported && (biometricEnabled == true)) {
        if (GetPlatform.isIOS) {
          if (availableBiometrics.contains(BiometricType.face)) {
            // Face ID.
            isBiometricSupportedType(BiometricType.face);
            isBiometricSupported(true);
          } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
            // Touch ID.
            isBiometricSupportedType(BiometricType.fingerprint);
            isBiometricSupported(true);
          } else {
            isBiometricSupported(false);
          }
        } else {
          isBiometricSupported(true);
        }
      }

      if (biometricEnabled == true && isBiometricSupported()) {
        final autoUseBiometric = securityService.enableAutoUseBiometric;
        if (autoUseBiometric) {
          handleBiometricAuth();
        }
      }
    }
  }

  void handleBiometricAuth() async {
    try {
      securityService.setPreventPasscodeExecution(true);
      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to access application'.tr,
        options: const AuthenticationOptions(biometricOnly: false),
      );

      useLogger().d('PPP => PasscodeController.handleBiometricAuth: $didAuthenticate');

      if (didAuthenticate) {
        if (arguments.whenPassed != null) {
          arguments.whenPassed!();
        } else {
          Get.back(result: PasscodeResult.passed);
        }
      }
    } catch (e, stackTrace) {
      useLogger().d('PPP => PasscodeController.handleBiometricAuth error: $e');
      _log.d('Call handleBiometricAuth error.', e, stackTrace);
      // rethrow;
    } finally {
      securityService.setPreventPasscodeExecution(false);
      useLogger().d('PPP => PasscodeController.handleBiometricAuth finished');
    }
  }

  void resetPasscode() {
    passcode([...emptyPassCode]);
  }

  // Method for dynamic app bar title
  String getAppBarTitle() {
    if (arguments.mode == PasscodeMode.setup || arguments.mode == PasscodeMode.change) {
      return 'PIN lock'.tr;
    } else if (arguments.mode == PasscodeMode.setupShortcut || arguments.mode == PasscodeMode.changeShortcut) {
      if (isInShortcutSetupConfirmation.value) {
        return 'Confirm a new Passcode'.tr;
      } else {
        return 'Shortcut Passcode'.tr;
      }
    }
    return 'PIN lock'.tr;
  }

  // method for dynamic header title
  String getHeaderTitle() {
    switch (arguments.mode) {
      case PasscodeMode.setup:
        if (isInSetupConfirmation.value) {
          return 'Confirm PIN Code'.tr;
        } else {
          return 'Set a PIN Code'.tr;
        }

      case PasscodeMode.change:
        if (!isVerifiedForAction.value) {
          return 'PIN Code'.tr; // For entering old passcode
        } else if (isInChangeConfirmation.value) {
          return 'Confirm PIN Code'.tr; // For confirming new passcode
        } else {
          return 'Set a PIN Code'.tr; // For setting new passcode
        }
      case PasscodeMode.setupShortcut:
      case PasscodeMode.changeShortcut:
        return arguments.user?.displayName ?? 'Shortcut Passcode'.tr;
      default:
        return 'PIN Code'.tr;
    }
  }

  // Method for dynamic sub label
  String getSubLabel() {
    if (arguments.mode == PasscodeMode.setup || arguments.mode == PasscodeMode.change) {
      return 'Please enter your desired PIN code'.tr;
    } else if (arguments.mode == PasscodeMode.setupShortcut || arguments.mode == PasscodeMode.changeShortcut) {
      return 'Please enter your Passcode'.tr;
    }
    return 'Please enter your PIN Code'.tr;
  }

  void initSetupPasscode() {
    isInSetupConfirmation(false);
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initDisablePasscode() {
    // Check if we should skip verification (for toggle off scenario)
    if (arguments.skipPasscodeVerification) {
      // Directly disable passcode without verification
      handleDisablePasscodeDirectly();
      return;
    }

    // Normal disable flow - require verification
    lastSettingState('Disable security passcode');
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void handleDisablePasscodeDirectly() async {
    try {
      // Call the whenPassed callback directly to handle the disable logic
      if (arguments.whenPassed != null) {
        arguments.whenPassed?.call();
      } else {
        // Fallback: just go back with success result
        Get.back(result: PasscodeResult.passed);
      }
    } catch (e) {
      _log.e('Error disabling passcode directly: $e');
      // If there's an error, fall back to normal verification flow
      lastSettingState('Disable security passcode');
      numPads[9] = 'CANCEL';
      checkDisabledPasscode();
      resetPasscode();
    }
  }

  void initConfirmSetupPasscode() {
    isInSetupConfirmation(true);
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initEnterPasscode() {
    if (arguments.enableShortcutPasscode) {
      lastSettingState('Enter passcode');
    }
    numPads[9] = 'BIOMETRIC';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initChangePasscodeVerify() {
    lastSettingState('Change passcode');
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initSetupShortcutPasscode() {
    isInShortcutSetupConfirmation(false);
    update([PasscodeIds.main]);
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initConfirmSetupShortcutPasscode() {
    isInShortcutSetupConfirmation(true);
    update([PasscodeIds.main]);
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initChangeShortcutPasscode() {
    isInShortcutSetupConfirmation(false);
    numPads[9] = 'CANCEL';
    update([PasscodeIds.main]);

    checkDisabledPasscode();
    resetPasscode();
  }

  void initConfirmChangeShortcutPasscode() {
    isInShortcutSetupConfirmation(true);
    numPads[9] = 'CANCEL';
    update([PasscodeIds.main]);

    checkDisabledPasscode();
    resetPasscode();
  }

  void initChangePasscode({bool isConfirm = false}) {
    useLogger().d('PPP => initChangePasscode, isConfirm: $isConfirm');

    if (isConfirm) {
      isInChangeConfirmation(true);
    } else {
      isInChangeConfirmation(false);
    }
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  void initConfirmChangePasscode() {
    isInChangeConfirmation(true);
    numPads[9] = 'CANCEL';

    checkDisabledPasscode();
    resetPasscode();
  }

  Future<void> resetPasscodeCheck() async {
    final generalConfig = ConfigDb().general;

    await generalConfig.saveConfig(
      key: ConfigDb.getPasscodeIncorrectStreakCountKey(),
      value: 0,
    );
    await generalConfig.clearConfig(
      key: ConfigDb.getPasscodeIncorrectUnblockTimestampKey(),
    );
  }

  void onBackToLastSettingState() {
    if (lastSettingState() == 'Enter passcode') {
      initEnterPasscode();
    } else if (lastSettingState() == 'Disable security passcode') {
      initDisablePasscode();
    } else if (lastSettingState() == 'Change passcode') {
      initChangePasscodeVerify();
    }
  }

  void onDisablePasscode() {
    isDisable(true);

    // Initial warning message with countdown
    final minutes = (disableTime() / 60).floor();
    final seconds = disableTime() % 60;
    final getDisableCountdownTime = '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';

    warningLabel(
        'You have entered an incorrect PIN \ntoo many times. Please wait another \n$getDisableCountdownTime minutes'
            .tr);
  }

  void initIncorrectPasscode() async {
    useLogger().d('PPP => initIncorrectPasscode called');

    int streakCount = await configGeneral.getIntWithDefault(
      key: ConfigDb.getPasscodeIncorrectStreakCountKey(),
      defaultValue: 0,
    );

    useLogger().d('PPP => Current streak count: $streakCount');

    final unblockTimestamp = await configGeneral.getString(
      key: ConfigDb.getPasscodeIncorrectUnblockTimestampKey(),
    );

    // Check if ban period is passed, then we reset the ban info
    if (unblockTimestamp != null) {
      final now = DateTime.now();
      final unblockTime = DateTime.parse(unblockTimestamp);

      if (streakCount >= maxIncorrectSteak && now.isAfter(unblockTime)) {
        useLogger().d('PPP => Ban period passed, resetting');
        await resetPasscodeCheck();
        streakCount = 0;
        onBackToLastSettingState();
        return;
      }
    }

    // Increment streak count
    streakCount += 1;
    useLogger().d('PPP => New streak count: $streakCount');

    await configGeneral.saveConfig(
      key: ConfigDb.getPasscodeIncorrectStreakCountKey(),
      value: streakCount,
    );

    resetPasscode();

    // Check if we need to disable (5 or more incorrect attempts)
    if (streakCount >= maxIncorrectSteak) {
      useLogger().d('PPP => Max incorrect attempts reached, setting block');

      if (unblockTimestamp == null) {
        // Set unblock timestamp to 2 minutes from now
        final blockUntil = DateTime.now().add(startBlockDuration);
        await configGeneral.saveConfig(
          key: ConfigDb.getPasscodeIncorrectUnblockTimestampKey(),
          value: blockUntil.toIso8601String(),
        );
        useLogger().d('PPP => Block set until: $blockUntil');
      }

      checkDisabledPasscode();
    } else {
      // Show standard incorrect message
      useLogger().d('PPP => Setting incorrect message, attempts: $streakCount/$maxIncorrectSteak');
      warningLabel('The PIN is incorrect'.tr);
    }
  }

  void checkDisabledPasscode() async {
    useLogger().d('PPP => checkDisabledPasscode');

    final unblockTimestamp = await configGeneral.getString(
      key: ConfigDb.getPasscodeIncorrectUnblockTimestampKey(),
    );

    final streakCount = await configGeneral.getIntWithDefault(
      key: ConfigDb.getPasscodeIncorrectStreakCountKey(),
      defaultValue: 0,
    );

    useLogger().d('PPP => checkDisabledPasscode - streakCount: $streakCount, unblockTimestamp: $unblockTimestamp');

    if (unblockTimestamp != null && streakCount >= maxIncorrectSteak) {
      final now = DateTime.now();
      final unblockTime = DateTime.parse(unblockTimestamp);
      final timeDiff = unblockTime.difference(now).inSeconds;

      useLogger().d('PPP => Time diff: $timeDiff seconds');

      if (timeDiff > 0) {
        disableTime(timeDiff);
        onStartCountdownTimer();
        onDisablePasscode();
      } else {
        useLogger().d('PPP => Block period expired, resetting');
        isDisable(false);
        await resetPasscodeCheck();
      }
    }
  }

  void handleDeletePasscodeDigit() {
    GetIt.I<VibrateUtil>().vibrateSelection();
    int index = passcode.lastIndexWhere((element) => element != null);

    if (index != -1) {
      passcode[index] = null;
    }
  }

  void handleInputPasscodeDigit(String digit) async {
    GetIt.I<VibrateUtil>().vibrateSelection();

    final index = passcode.indexWhere((element) => element == null);
    if (index == -1) return;
    warningLabel('');

    try {
      passcode[index] = digit;
    } catch (e, stackTrace) {
      _log.e(e.toString(), e, stackTrace);
    }

    // Handle submit in the next frame so Passcode UI can update itself first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Submit Case
      if (!passcode.contains(null)) {
        if (arguments.mode == PasscodeMode.setup) {
          handleSetupPasscode();
        } else if (arguments.mode == PasscodeMode.disable) {
          handleVerifyPasscode();
        } else if (arguments.mode == PasscodeMode.change) {
          handleChangePasscode();
        } else if (arguments.mode == PasscodeMode.verify) {
          handleVerifyPasscode();
        } else if (arguments.mode == PasscodeMode.setupShortcut) {
          handleSetupShortcutPasscode();
        } else if (arguments.mode == PasscodeMode.changeShortcut) {
          handleChangeShortcutPasscode();
        }
      }
    });
  }

  void handleSetupPasscode() async {
    useLogger().d('PPP => handleSetupPasscode, setupPasscodeString: "${setupPasscodeString()}"');

    // If enter passcode for the first time, store last input passcode and ask user to reconfirm
    if (setupPasscodeString() == '') {
      setupPasscodeString.value = passcode.join();
      useLogger().d('PPP => First time setup, stored: "${setupPasscodeString()}"');
      initConfirmSetupPasscode();
    } else {
      // If user enter passcode on the 2nd time, we compare 1st & 2nd passcode before proceed
      useLogger().d('PPP => Confirming setup, comparing "${setupPasscodeString()}" with "${passcode.join()}"');

      if (setupPasscodeString() == passcode.join()) {
        // Complete passcode setup
        await securityService.setPasscode(passcode.join());
        useLogger().d('PPP => Setup completed successfully');

        if (arguments.whenPassed != null) {
          arguments.whenPassed?.call();
        } else {
          Get.back(result: true);
        }
      } else {
        useLogger().d('PPP => Setup confirmation failed - passcodes do not match');

        // Wrong passcode confirmation, vibrate and show error
        await GetIt.I<VibrateUtil>().vibrateError();

        // Stay in confirmation mode, don't reset setupPasscodeString
        // Just reset the current passcode input and show error
        resetPasscode();
        warningLabel('The PIN is incorrect'.tr);

        // Don't call initSetupPasscode() - stay in confirmation state
      }
    }
  }

  Future<bool> isPasscodeVerify() async {
    useLogger().d('PPP => isPasscodeVerify called with passcode: "${passcode.join()}"');

    final streakCount = await configGeneral.getIntWithDefault(
      key: ConfigDb.getPasscodeIncorrectStreakCountKey(),
      defaultValue: 0,
    );

    final unblockTimestamp = await configGeneral.getString(
      key: ConfigDb.getPasscodeIncorrectUnblockTimestampKey(),
    );

    final currentUser = UserController.instance.currentUser.value;
    final isCalling = currentUser?.isCalling ?? false;

    useLogger().d('PPP => isPasscodeVerify - streakCount: $streakCount, unblockTimestamp: $unblockTimestamp');

    // Check if user is currently blocked
    if (unblockTimestamp != null && streakCount >= maxIncorrectSteak) {
      final now = DateTime.now();
      final unblockTime = DateTime.parse(unblockTimestamp);

      if (now.isBefore(unblockTime)) {
        useLogger().d('PPP => User is still blocked until: $unblockTime');
        checkDisabledPasscode();
        resetPasscode();
        return false;
      } else {
        // Block period has expired, reset the counter
        useLogger().d('PPP => Block period expired, resetting counter');
        await resetPasscodeCheck();
      }
    }

    final canFallback4Digit = passcode.take(2).join() == '00';

    // Try 1 (first check with 6-digit passcode)
    useLogger().d('PPP => Trying 6-digit verification: "${passcode.join()}"');
    if (await securityService.verifyPasscode(passcode.join())) {
      useLogger().d('PPP => 6-digit verification successful');
      return true;
    }

    // Try 2 (fallback to 4-digit passcode if applicable)
    else if (canFallback4Digit && await securityService.verifyPasscode(passcode.skip(2).join())) {
      useLogger().d('PPP => 4-digit fallback verification successful: "${passcode.skip(2).join()}"');
      return true;
    }

    // Try 3 (check for shortcut passcode if enabled)
    else if (arguments.enableShortcutPasscode) {
      useLogger().d('PPP => Trying shortcut passcode verification');
      UserEntity? user = await GetIt.I<FindUserWithShortcutPasscodeUseCase>().call(
        FindUserWithShortcutPasscodeParams(passcode: passcode.join()),
      );
      if (user != null) {
        useLogger().d('PPP => Found user with shortcut passcode: ${user.id}');
        if (UserController.instance.isCurrentUser(user.id!)) {
          // if this is shortcut of current user no need to switch
          useLogger().d('PPP => Shortcut passcode for current user');
          return true;
        } else if (!isCalling) {
          useLogger().d('PPP => Switching to user account');
          if (arguments.isFirstRouteToCalled == false) {
            await UChatLoading.show();
            await GetIt.I<AccountsCenterService>().setAccountAndReturnToHome(user, backToHome: false);
            await UChatLoading.hide();
          } else {
            await GetIt.I<AccountsCenterService>().switchAccount(user);
          }
          return true;
        }
      }
    }

    useLogger().d('PPP => All verification attempts failed');
    _log.d('Invalid passcode!');
    return false;
  }

  void handleChangePasscode() async {
    useLogger().d(
        'PPP => handleChangePasscode, isVerifiedForAction: ${isVerifiedForAction()}, setupPasscodeString: "${setupPasscodeString()}"');

    // If we haven't verified old passcode yet and we're not skipping verification
    if (!isVerifiedForAction() && !arguments.skipPasscodeVerification) {
      if (await isPasscodeVerify()) {
        isVerifiedForAction.value = true;
        initChangePasscode();
      } else {
        initIncorrectPasscode();
      }
      return;
    }

    // If enter passcode for the first time, store last input passcode and ask user to reconfirm
    if (setupPasscodeString() == '') {
      String code = passcode.join();
      useLogger().d('PPP => First time change, code: "$code"');

      // Check if user is trying to use the old passcode
      if (await securityService.verifyPasscode(code)) {
        await GetIt.I<VibrateUtil>().vibrateError();
        resetPasscode(); // Just reset input, don't change state
        warningLabel('Unable to use old PIN'.tr);
        return;
      }

      setupPasscodeString(code);
      initConfirmChangePasscode();
    } else {
      // If user enter passcode on the 2nd time, we compare 1st & 2nd passcode before proceed
      useLogger().d('PPP => Confirming change, comparing "${setupPasscodeString()}" with "${passcode.join()}"');

      if (setupPasscodeString() == passcode.join()) {
        // Complete passcode change
        await securityService.setPasscode(passcode.join());
        useLogger().d('PPP => Change completed successfully');

        if (arguments.whenPassed != null) {
          arguments.whenPassed?.call();
        } else {
          Get.back();
        }
      } else {
        // Wrong passcode confirmation, stay in confirmation mode
        useLogger().d('PPP => Change confirmation failed - passcodes do not match');

        await GetIt.I<VibrateUtil>().vibrateError();

        // Stay in confirmation mode, just reset current input
        resetPasscode();
        warningLabel('The PIN is incorrect'.tr);

        // Don't reset setupPasscodeString or change state
      }
    }
  }

  void handleVerifyPasscode() async {
    useLogger().d('PPP => handleVerifyPasscode called, mode: ${arguments.mode}');

    if (await isPasscodeVerify()) {
      useLogger().d('PPP => Passcode verification successful');
      await resetPasscodeCheck();

      // Special handling for disable mode
      if (arguments.mode == PasscodeMode.disable) {
        useLogger().d('PPP => Disable mode - calling whenPassed');
        if (arguments.whenPassed != null) {
          arguments.whenPassed?.call();
        } else {
          Get.back(result: PasscodeResult.passed);
        }
        return;
      }

      // Normal verification flow
      if (arguments.whenPassed != null) {
        arguments.whenPassed?.call();
      } else {
        Get.back(result: PasscodeResult.unlocked);
      }
    } else {
      useLogger().d('PPP => Passcode verification failed');

      if (arguments.mode == PasscodeMode.verify) {
        // If wrong passcode we check for debug passcode first
        VerifyDebugPasscodeResponse? debugUser;
        final canFallback4Digit = passcode.take(2).join() == '00';
        bool isVerify1Error = false;

        // Check with new 6 digit passcode
        try {
          UChatLoading.show(status: 'Verifying...'.tr);
          final verifyReq = VerifyDebugPasscodeRequest(
            passcode: passcode.join(),
            force: arguments.debug != true,
          );
          debugUser = await AuthService().verifyDebugPasscode(verifyReq);

          if (debugUser == null && !canFallback4Digit) {
            UChatLoading.hide();
            initIncorrectPasscode();
            return;
          }
        } on ApiException catch (e, stackTrace) {
          _log.i('Call handleVerifyPasscode error.', e, stackTrace);
          isVerify1Error = true;
        } catch (e, stackTrace) {
          _log.e('Call handleVerifyPasscode error.', e, stackTrace);
          isVerify1Error = true;
        }

        if (isVerify1Error) {
          if (!canFallback4Digit) {
            // Wrong passcode, vibrate and ask user to reenter
            await GetIt.I<VibrateUtil>().vibrateError();
            initIncorrectPasscode();
            UChatLoading.hide();

            return;
          }
        }

        // Fallback check with 4 digit passcode
        if (canFallback4Digit) {
          bool isVerify2Error = false;
          try {
            UChatLoading.show(status: 'Verifying...'.tr);
            final verifyReq = VerifyDebugPasscodeRequest(
              passcode: passcode.skip(2).join(),
              force: arguments.debug != true,
            );
            debugUser = await AuthService().verifyDebugPasscode(verifyReq);

            if (debugUser == null) {
              UChatLoading.hide();
              initIncorrectPasscode();
              return;
            }
          } on ApiException catch (e, stackTrace) {
            _log.i('Call handleVerifyPasscode error.', e, stackTrace);
            isVerify2Error = true;
          } catch (e, stackTrace) {
            _log.e('Call handleVerifyPasscode error.', e, stackTrace);
            isVerify2Error = true;
          }

          if (isVerify2Error) {
            // Wrong passcode, vibrate and ask user to reenter
            await GetIt.I<VibrateUtil>().vibrateError();
            initIncorrectPasscode();
            UChatLoading.hide();
            return;
          }
        }

        if (debugUser != null) {
          try {
            await GetIt.I<AccountsCenterService>().logoutCurrentUser(isDebug: true);
            await UserController.instance.setCurrentUser(
              debugUser.toUserCollection().toEntity(),
              token: debugUser.token,
            );

            UChatLoading.hide();
            _log.d('Complete and to home...');
            Get.offAllNamed(Routes.splash, arguments: SplashArguments(next: () {
              Future.delayed(const Duration(seconds: 1), () {
                Get.offNamed(Routes.home, preventDuplicates: false);
              });
            }));
            return;
          } catch (e, stackTrace) {
            _log.e('Call handleVerifyPasscode error.', e, stackTrace);

            // Wrong passcode, vibrate and ask user to reenter
            await GetIt.I<VibrateUtil>().vibrateError();
            initIncorrectPasscode();
            UChatLoading.hide();
          }
        }
      } else {
        // For other modes (disable, change, etc.), just show incorrect message and increment counter
        initIncorrectPasscode();
      }
    }
  }

  void handleSetupShortcutPasscode() async {
    if (setupShortcutPasscodeString() == '') {
      String code = passcode.join();
      if (await checkDuplicatePasscode(code)) {
        setupShortcutPasscodeString(code);
        initConfirmSetupShortcutPasscode();
      } else {
        initSetupShortcutPasscode();
      }
    } else {
      if (setupShortcutPasscodeString() == passcode.join()) {
        // set passcode in user
        final userId = arguments.user?.id;
        if (userId != null) {
          try {
            final result = await securityService.setShortcutPasscode(
              userId: userId,
              passcode: setupShortcutPasscodeString(),
            );

            Get.back(result: result);
          } catch (e, stackTrace) {
            _log.e('setup shortcut passcode error', e, stackTrace);
            Get.back();
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
          }
        } else {
          _log.e('can not setup shortcut passcode. user is null');
        }
      } else {
        _log.d('Shortcut passcode confirmation not match');

        // Wrong passcode confirmation, vibrate and ask user to reenter from start
        await GetIt.I<VibrateUtil>().vibrateError();
        initConfirmSetupShortcutPasscode();
        warningLabel('The passcode is incorrect'.tr);
      }
    }
  }

  void handleChangeShortcutPasscode() async {
    UserEntity? user = arguments.user;

    // If enter passcode for the first time, store last input passcode and ask user to reconfirm
    if (setupShortcutPasscodeString() == '') {
      String code = passcode.join();
      if (await checkDuplicatePasscode(code)) {
        setupShortcutPasscodeString(code);
        initConfirmChangeShortcutPasscode();
      } else {
        initChangeShortcutPasscode();
      }
    } else {
      // If user enter passcode on the 2nd time, we compare 1st & 2nd passcode before proceed
      if (setupShortcutPasscodeString() == passcode.join() && user != null) {
        final userId = user.id;
        if (userId != null) {
          try {
            await securityService.setShortcutPasscode(
              userId: userId,
              passcode: setupShortcutPasscodeString(),
            );

            // Complete change passcode setup
            Get.back();
          } catch (e, stackTrace) {
            _log.e('change shortcut passcode error', e, stackTrace);
            Get.back();
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
          }
        }
      } else {
        await GetIt.I<VibrateUtil>().vibrateError();
        initConfirmChangeShortcutPasscode();
        warningLabel('The passcode is incorrect'.tr);
      }
    }
  }

  Future<bool> checkDuplicatePasscode(String code) async {
    // check duplicate passcode
    if (await securityService.verifyPasscode(code)) {
      _log.d('can not use security passcode');

      // Wrong passcode confirmation, vibrate and ask user to reenter from start
      await GetIt.I<VibrateUtil>().vibrateError();

      setupShortcutPasscodeString.value = '';
      warningLabel('Passcode already used'.tr);
      return false;
    } else if (await GetIt.I<FindUserWithShortcutPasscodeUseCase>().call(
          FindUserWithShortcutPasscodeParams(passcode: code),
        ) !=
        null) {
      _log.d('can not use duplicate shortcut passcode');

      // Wrong passcode confirmation, vibrate and ask user to reenter from start
      await GetIt.I<VibrateUtil>().vibrateError();

      setupShortcutPasscodeString.value = '';
      warningLabel('Passcode already used'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> handleClear() async {
    await GetIt.I<VibrateUtil>().vibrateError();
    resetPasscode();
  }
}
