import 'package:get/get.dart';

class AuthenticationHelper {
  static String getCensoredPhoneNumberAndCountryWithXAlphabet({
    required String phoneNumber,
    String? countryCode,
  }) {
    // TODO (improve) Find a way to handle other country's phone number.
    if (phoneNumber.isEmpty) {
      return '';
    }
    String lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);
    return '+${countryCode ?? '66'} xx xxx $lastFourDigits';
  }
}

enum AuthenticationActionType {
  setting,
  signin,
  signup,
  deleteAccount,
  forgotPassword,
  settingPhoneNumber,
  settingEmail,
  changeEmail, // use for check show change email or setting email title
  settingPassword,
  devicesManager;

  String get value {
    switch (this) {
      case AuthenticationActionType.setting:
        return 'SETTING';
      case AuthenticationActionType.signin:
        return 'SIGN_IN';
      case AuthenticationActionType.signup:
        return 'SIGN_UP';
      case AuthenticationActionType.deleteAccount:
        return 'REMOVE_ACCOUNT';
      case AuthenticationActionType.forgotPassword:
        return 'FORGOT_PASSWORD';
      case AuthenticationActionType.settingPhoneNumber:
        return 'SETTING_PHONE_NUMBER';
      case AuthenticationActionType.settingEmail:
      case AuthenticationActionType.changeEmail:
        return 'SETTING_EMAIL';
      case AuthenticationActionType.settingPassword:
        return 'SETTING_PASSWORD';
      case AuthenticationActionType.devicesManager:
        return 'MANAGE_DEVICE';
    }
  }

  String get title {
    switch (this) {
      case AuthenticationActionType.deleteAccount:
        return 'Delete account'.tr;
      case AuthenticationActionType.settingPhoneNumber:
        return 'Change phone number'.tr;
      case AuthenticationActionType.settingEmail:
        return 'Set Up Your Email'.tr;
      case AuthenticationActionType.changeEmail:
        return 'Change email'.tr;
      case AuthenticationActionType.settingPassword:
        return 'Change password'.tr;
      case AuthenticationActionType.setting:
        return 'Setting Account'.tr;
      case AuthenticationActionType.devicesManager:
        return 'Manage Device'.tr;
      case AuthenticationActionType.forgotPassword:
        return 'Forgot password'.tr;
      default:
        throw Exception('Please implement $name type for authentication.');
    }
  }

  String get getOtpTitle {
    switch (this) {
      case AuthenticationActionType.deleteAccount:
        return 'delete account'.tr;
      case AuthenticationActionType.settingPhoneNumber:
        return 'change phone number'.tr;
      case AuthenticationActionType.settingEmail:
        return 'set up your email'.tr;
      case AuthenticationActionType.changeEmail:
        return 'change email'.tr;
      case AuthenticationActionType.settingPassword:
        return 'change password'.tr;
      case AuthenticationActionType.devicesManager:
        return 'Manage Device'.tr;
      case AuthenticationActionType.setting:
        return 'setting account'.tr;
      case AuthenticationActionType.forgotPassword:
        return 'reset password'.tr;
      default:
        throw Exception('Please implement $name type for authentication.');
    }
  }

  static AuthenticationActionType from(String val) {
    switch (val) {
      case 'SETTING':
        return AuthenticationActionType.setting;
      case 'SIGN_UP':
        return AuthenticationActionType.signup;
      case 'SIGN_IN':
        return AuthenticationActionType.signin;
      case 'REMOVE_ACCOUNT':
        return AuthenticationActionType.deleteAccount;
      case 'FORGOT_PASSWORD':
        return AuthenticationActionType.forgotPassword;
      case 'SETTING_PHONE_NUMBER':
        return AuthenticationActionType.settingPhoneNumber;
      case 'SETTING_EMAIL':
        return AuthenticationActionType.settingEmail;
      case 'SETTING_PASSWORD':
        return AuthenticationActionType.settingPassword;
      case 'SETTING_SYNC_FACEBOOK_ACCOUNT':
        return AuthenticationActionType.devicesManager;

      default:
        throw Exception('Unknown AuthenticationActionType value: $val');
    }
  }
}

enum SelectedOtpType {
  email,
  phone;

  String get value {
    switch (this) {
      case SelectedOtpType.email:
        return 'EMAIL';
      case SelectedOtpType.phone:
        return 'PHONE';
    }
  }

  static SelectedOtpType from(String val) {
    switch (val) {
      case 'EMAIL':
        return SelectedOtpType.email;
      case 'PHONE':
        return SelectedOtpType.phone;
      default:
        throw Exception('Unknown SelectedOtpType value: $val');
    }
  }
}

enum AuthenticationActionStep {
  firstStep,
  sendPassword,
  selectOtp,
  updateValue;

  String get value {
    switch (this) {
      case AuthenticationActionStep.firstStep:
        return 'FIRST_STEP';
      case AuthenticationActionStep.sendPassword:
        return 'SEND_PASSWORD';
      case AuthenticationActionStep.selectOtp:
        return 'SELECT_OTP';
      case AuthenticationActionStep.updateValue:
        return 'UPDATE_VALUE';
    }
  }

  static AuthenticationActionStep from(String val) {
    switch (val) {
      case 'FIRST_STEP':
        return AuthenticationActionStep.firstStep;
      case 'SEND_PASSWORD':
        return AuthenticationActionStep.sendPassword;
      case 'SELECT_OTP':
        return AuthenticationActionStep.selectOtp;
      case 'UPDATE_VALUE':
        return AuthenticationActionStep.updateValue;
      default:
        throw Exception('Unknown AuthenticationActionStep value: $val');
    }
  }
}

class OtpRequestModel {
  dynamic request;
  AuthenticationActionType actionName;
  AuthenticationActionStep step;

  OtpRequestModel({
    required this.request,
    required this.actionName,
    required this.step,
  });
}

enum SocialActionType {
  syncGoogleAccount,
  unSyncGoogleAccount,
  syncAppleId,
  unSyncAppleId,
  syncFacebookAccount,
  unSyncFacebookAccount;

  String get value {
    switch (this) {
      case SocialActionType.syncGoogleAccount:
        return 'LINK_GOOGLE_ACCOUNT';
      case SocialActionType.unSyncGoogleAccount:
        return 'UNLINK_GOOGLE_ACCOUNT';
      case SocialActionType.syncAppleId:
        return 'LINK_APPLE_ID';
      case SocialActionType.unSyncAppleId:
        return 'UNLINK_APPLE_ID';
      case SocialActionType.syncFacebookAccount:
        return 'LINK_FACEBOOK_ACCOUNT';
      case SocialActionType.unSyncFacebookAccount:
        return 'UNLINK_FACEBOOK_ACCOUNT';
    }
  }

  String get title {
    switch (this) {
      case SocialActionType.syncGoogleAccount:
        return 'Sync Google account'.tr;
      case SocialActionType.unSyncGoogleAccount:
        return 'Unsync Google account'.tr;
      case SocialActionType.syncAppleId:
        return 'Sync Apple ID'.tr;
      case SocialActionType.unSyncAppleId:
        return 'Unsync Apple ID'.tr;
      case SocialActionType.syncFacebookAccount:
        return 'Sync Facebook account'.tr;
      case SocialActionType.unSyncFacebookAccount:
        return 'Unsync Facebook account'.tr;
    }
  }

  String get getOtpTitle {
    switch (this) {
      case SocialActionType.syncGoogleAccount:
        return 'sync a new Google account'.tr;
      case SocialActionType.unSyncGoogleAccount:
        return 'Sync a new Google account'.tr;
      case SocialActionType.syncAppleId:
        return 'sync a new Apple ID'.tr;
      case SocialActionType.unSyncAppleId:
        return 'Sync a new Apple ID'.tr;
      case SocialActionType.syncFacebookAccount:
        return 'sync a new Facebook account'.tr;
      case SocialActionType.unSyncFacebookAccount:
        return 'Sync a new Facebook account'.tr;
    }
  }
}
