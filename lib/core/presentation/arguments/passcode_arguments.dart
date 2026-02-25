import 'package:uchat/core/domain/entities/user_entity.dart';

import '../../domain/enums/passcode_mode.dart';

class PasscodeArguments {
  final PasscodeMode mode;
  final bool debug;

  void Function()? onShowed;
  void Function()? whenPassed;

  ///
  /// For setup shortcut passcode
  ///
  final UserEntity? user;
  final bool enableShortcutPasscode;
  final bool? isHideCloseButton;
  final String? controllerTag;

  final bool skipPasscodeVerification;
  final bool? isFirstRouteToCalled;

  PasscodeArguments({
    this.mode = PasscodeMode.verify,
    this.debug = false,
    this.onShowed,
    this.whenPassed,
    this.user,
    this.enableShortcutPasscode = false,
    this.isHideCloseButton,
    this.controllerTag,
    this.skipPasscodeVerification = false,
    this.isFirstRouteToCalled,
  });
}
