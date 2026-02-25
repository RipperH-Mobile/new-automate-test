import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/clear_shortcut_passcode_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/set_shortcut_passcode_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uuid/uuid.dart';

import '../../domain/constants/passcode.dart';
import '../../domain/enums/passcode_mode.dart';
import '../../domain/enums/passcode_result.dart';
import '../../domain/services/security_service.dart';
import '../arguments/passcode_arguments.dart';

class SecurityServiceImpl extends GetxController implements SecurityService {
  final ConfigInstance authConfig;
  final ConfigInstance generalConfig;

  SecurityServiceImpl({
    required this.authConfig,
    required this.generalConfig,
  });

  final _localAuth = LocalAuthentication();

  /// -------------------------------------------------
  /// Initialization
  /// -------------------------------------------------
  ///
  /// Initializes the security service by checking biometric support,
  /// available biometric types, and loading passcode settings.
  ///
  @override
  Future<void> initialize() async {
    final isBioMetricSupported = await _localAuth.canCheckBiometrics;
    _isBioMetricSupported = isBioMetricSupported;

    final bioMetricTypes = await _localAuth.getAvailableBiometrics();
    _bioMetricTypes = bioMetricTypes;
  }

  /// -------------------------------------------------
  /// Orchestration Methods
  /// -------------------------------------------------
  ///
  /// Handles the authentication flow, including showing the protection screen
  @override
  Future<void> onAuthenticated() async {
    // For data migration from authenticated config db to general config db
    final oldIsHaveAppPasscode = await ConfigDb().authenticated.getString(key: ConfigDb.getPasscodeKey());
    final oldEnableBiometric = await ConfigDb().authenticated.getBool(key: ConfigDb.getPasscodeUseBiometricKey());
    final oldAutoUseBiometric = await ConfigDb().authenticated.getBool(key: ConfigDb.getPasscodeAutoUseBiometricKey());

    if (oldIsHaveAppPasscode != null) {
      await generalConfig.saveConfig(key: ConfigDb.getPasscodeKey(), value: oldIsHaveAppPasscode);
      await authConfig.clearConfig(key: ConfigDb.getPasscodeKey());
    }

    if (oldEnableBiometric != null) {
      await generalConfig.saveConfig(key: ConfigDb.getPasscodeUseBiometricKey(), value: oldEnableBiometric);
      await authConfig.clearConfig(key: ConfigDb.getPasscodeUseBiometricKey());
    }

    if (oldAutoUseBiometric != null) {
      await generalConfig.saveConfig(key: ConfigDb.getPasscodeAutoUseBiometricKey(), value: oldAutoUseBiometric);
      await authConfig.clearConfig(key: ConfigDb.getPasscodeAutoUseBiometricKey());
    }

    // Check pass code logic
    _passcode = await generalConfig.getString(key: ConfigDb.getPasscodeKey());
    if (_passcode != null && _passcode!.isNotEmpty && _passcode!.length == emptyPassCode.length) {
      _hasPasscode = true;
      _isEnableProtectionScreen = true;
    } else {
      _hasPasscode = false;
      _isEnableProtectionScreen = false;
    }

    _enableAutoUseBiometric = await generalConfig.getBoolWithDefault(
      key: ConfigDb.getPasscodeAutoUseBiometricKey(),
      defaultValue: false,
    );

    _enableBiometric = await generalConfig.getBoolWithDefault(
      key: ConfigDb.getPasscodeUseBiometricKey(),
      defaultValue: false,
    );
  }

  /// This method is called when the user is authenticated.
  @override
  Future<void> onUnauthenticated() async {}

  @override
  Future<void> onAppInactive() async {
    useLogger().d('ZZZ => Passcode onAppInactive Prev: $_passcodeExecutionStartTime');
    if (!_preventPasscodeExecution && _passcodeExecutionStartTime == null) {
      _passcodeExecutionStartTime = DateTime.now();
      useLogger().d('ZZZ => Passcode onAppInactive: $_passcodeExecutionStartTime');
    }
  }

  @override
  Future<void> onAppPause() async {}

  @override
  Future<void> onAppResumed() async {}

  /// ------------------------------------------------
  /// Biometric Management
  /// ------------------------------------------------
  ///
  /// List of available biometric types.
  List<BiometricType> _bioMetricTypes = [];

  @override
  List<BiometricType> get biometricTypes => _bioMetricTypes;

  /// Flag to indicate if biometric authentication is supported.
  /// The value is determined during initialization.
  bool _isBioMetricSupported = false;

  @override
  bool get isBiometricSupported => _isBioMetricSupported;

  /// Flag to indicate if biometric authentication is enabled.
  bool _enableBiometric = false;

  @override
  bool get enableBiometric => _enableBiometric;

  @override
  Future<void> setEnableBiometric(bool enable) async {
    _enableBiometric = enable;
    await generalConfig.saveConfig(
      key: ConfigDb.getPasscodeUseBiometricKey(),
      value: enable,
    );
  }

  /// Flag to indicate if auto use of biometric authentication is enabled.
  bool _enableAutoUseBiometric = false;

  @override
  bool get enableAutoUseBiometric => _enableAutoUseBiometric;

  @override
  Future<void> setEnableAutoUseBiometric(bool enable) async {
    _enableAutoUseBiometric = enable;
    await generalConfig.saveConfig(
      key: ConfigDb.getPasscodeAutoUseBiometricKey(),
      value: enable,
    );
  }

  /// ------------------------------------------------
  /// Passcode Management
  /// Flag to indicate if the app has a passcode set.
  /// ------------------------------------------------
  ///
  /// This is the passcode used for the app.
  String? _passcode;

  /// Flag to indicate if the app has a passcode set.
  bool _hasPasscode = false;

  @override
  bool get hasPasscode => _hasPasscode;

  /// The time for keepin track of the last passcode execution time.
  DateTime? _lastPasscodeExecutionTime;

  /// Flag to indicate if the app is currently locked by a passcode.
  DateTime? _passcodeExecutionStartTime;

  /// The prevented passcode execution flag.
  bool _preventPasscodeExecution = false;

  @override
  Future<void> setPreventPasscodeExecution(bool prevent) async {
    _preventPasscodeExecution = prevent;
  }

  /// For checking if the app is currently locked by a passcode.
  /// This is used to determine if the passcode screen should be shown.
  @override
  Future<bool> isPasscodeLocked() async {
    if (!_hasPasscode) {
      // If the app does not have a passcode set, it is not locked.
      return false;
    }

    final passcodeShowProcessStartAt = _passcodeExecutionStartTime;

    if (passcodeShowProcessStartAt == null) {
      // If the passcode show process has not started, we assume it is not locked.
      return _lastPasscodeExecutionTime == null;
    }

    final now = DateTime.now();
    final timeDifference = now.difference(passcodeShowProcessStartAt);

    return timeDifference > passcodeTimeOut;
  }

  /// For showing and hiding the passcode screen,
  @override
  Future<PasscodeResult> showVerifyPasscodeScreen({
    Function()? onShowed,
    Function()? callback,
    bool isDebug = false,
    bool? isFirstRouteToCalled,
  }) async {
    // Prevent showing the passcode screen if it is already being shown.
    if (Get.currentRoute.startsWith('/passcode')) {
      _passcodeExecutionStartTime = null;
      onShowed?.call();
      return PasscodeResult.shown;
    }

    // Prevent showing the passcode screen if it is already unlocked.
    if (!await isPasscodeLocked()) {
      _passcodeExecutionStartTime = null;
      onShowed?.call();
      return PasscodeResult.unlocked;
    }

    final enableShortCutPasscode = UserController.instance.enableUseShortcutPasscode;

    // Show the passcode screen.
    final result = await Get.toNamed(
      Routes.passcode,
      arguments: PasscodeArguments(
        onShowed: onShowed,
        mode: PasscodeMode.verify,
        debug: isDebug,
        enableShortcutPasscode: enableShortCutPasscode,
        isHideCloseButton: true,
        controllerTag: const Uuid().v4(),
        isFirstRouteToCalled: isFirstRouteToCalled,
      ),
    );

    _lastPasscodeExecutionTime = DateTime.now();
    _passcodeExecutionStartTime = null;

    if (result is PasscodeResult) {
      return result;
    }

    return PasscodeResult.passed;
  }

  @override
  Future<void> clearPasscode() async {
    await generalConfig.clearConfig(
      key: ConfigDb.getPasscodeKey(),
    );
    _passcode = null;
    _hasPasscode = false;
    _isEnableProtectionScreen = false;
  }

  @override
  Future<void> setPasscode(String passcode) async {
    if (passcode.isEmpty || passcode.length != emptyPassCode.length) {
      throw ArgumentError('Passcode must be exactly ${emptyPassCode.length} characters long.');
    }

    await generalConfig.saveConfig(
      key: ConfigDb.getPasscodeKey(),
      value: passcode,
    );
    _passcode = passcode;
    _hasPasscode = true;
    _isEnableProtectionScreen = true;
  }

  @override
  Future<bool> verifyPasscode(String passcode) async {
    return _passcode == passcode;
  }

  /// ------------------------------------------------
  /// Protection Screen Management
  /// ------------------------------------------------
  ///
  /// Flag to indicate if the protection screen is enabled.
  bool _isEnableProtectionScreen = false;

  @override
  bool get isEnableProtectionScreen => _isEnableProtectionScreen;

  /// Flag to indicate if the protection screen is currently shown.
  bool _isShowProtectionScreen = false;

  @override
  bool get isShowProtectionScreen => _isShowProtectionScreen;

  /// Shows or hides the protection screen based on the current state.
  @override
  Future<void> showProtectionScreen() async {
    if (_isEnableProtectionScreen == false) {
      useLogger().d('Protection screen is disabled, not showing.');
      return;
    }

    if (_isShowProtectionScreen == true) {
      useLogger().d('Protection screen is already shown, not showing again.');
      return;
    }

    _isShowProtectionScreen = true;

    try {
      update(['protection-screen']);
    } catch (e) {
      useLogger().e('Error showing protection screen', e);
    }

    useLogger().d('Protection screen shown');
  }

  @override
  Future<void> hideProtectionScreen() async {
    if (_isShowProtectionScreen == false) {
      useLogger().d('Protection screen is already hidden, not hiding again.');
      return;
    }

    _isShowProtectionScreen = false;
    update(['protection-screen']);
  }

  @override
  bool get isPreventTap => _preventTap;

  bool _preventTap = false;

  // Activates the prevent tap on screen for a short duration. This is to prevent accidental taps after unlock passcode.
  @override
  Future<void> activatePreventTap() async {
    _preventTap = true;
    update(['protection-screen']);

    await Future.delayed(const Duration(milliseconds: 300));
    _preventTap = false;
    update(['protection-screen']);
  }

  @override
  Future<bool> setShortcutPasscode({required String userId, required String? passcode}) async {
    return await GetIt.I<SetShortCutPasscodeUseCase>().call(
      SetShortcutPasscodeParams(
        userId: userId,
        passcode: passcode,
      ),
    );
  }

  @override
  Future<void> clearShortcutPasscode() async {
    await GetIt.I<ClearShortcutPasscodeUseCase>().call(NoParams());
  }
}
