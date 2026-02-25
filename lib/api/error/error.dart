import 'package:uchat/core/exceptions/error_account_email_already_exist_exception.dart';
import 'package:uchat/core/exceptions/error_account_limit_password_validation_exception.dart';
import 'package:uchat/core/exceptions/error_validate_password_cooldown_exception.dart';
import 'package:uchat/core/exceptions/exceptions.dart';

import '../http/http_caller.dart';

final errorMap = {
  'VALIDATION_ERROR': (ResponseMap response) => ApiValidationException.fromMap(response),
  'ERR_STATE_LIMIT_EXCEED': (ResponseMap response) => ApiStateLimitExceedException.fromMap(response),
  'ERR_FRIEND_LIMIT': (ResponseMap response) => ApiFriendLimitExceedException.fromMap(response),
  'ERR_OFFICIAL_ACCOUNT_LIMIT': (ResponseMap response) => ApiOfficialAccountLimitExceedException.fromMap(response),
  'ERR_SERVICE_ON_MAINTENANCE_MODE': (ResponseMap response) => ServiceOnMaintenanceModeException.fromMap(response),
  'INVALID_TOKEN': (ResponseMap response) => InvalidTokenException.fromMap(response),
  'ERR_ACCOUNT_OTP_COOLDOWN': (ResponseMap response) => ErrorAccountOtpCooldown.fromMap(response),
  'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED': (ResponseMap response) => ErrorAccountActionTokenExpired.fromMap(response),
  'ERR_ACCOUNT_OTP_EXPIRED': (ResponseMap response) => ErrorAccountOtpExpired.fromMap(response),
  'ERR_ACCOUNT_INVALID_OTP_TOKEN': (ResponseMap response) => ErrorAccountInvalidOtpToken.fromMap(response),
  'ERR_USER_NOT_FOUND': (ResponseMap response) => ErrorUserNotFoundException.fromMap(response),
  'ERR_ACCOUNT_NOT_FOUND': (ResponseMap response) => ErrorAccountNotFoundException.fromMap(response),
  'ERR_ACCOUNT_BANNED': (ResponseMap response) => ErrorAccountBanedException.fromMap(response),
  'ERR_ACCOUNT_EMAIL_ALREADY_EXIST': (ResponseMap response) => ErrorAccountEmailAlreadyExistException.fromMap(response),
  'ERR_ACCOUNT_LIMIT_PASSWORD_VALIDATION': (ResponseMap response) =>
      ErrorAccountLimitPasswordValidationException.fromMap(response),
  'ERR_VALIDATE_PASSWORD_COOLDOWN': (ResponseMap response) => ErrorValidatePasswordCooldownException.fromMap(response),
};
