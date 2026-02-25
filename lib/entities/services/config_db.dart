import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/config_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/sync/data/models/enum/state_group.dart';
import 'package:uchat/utils/fast_hash.dart';

// final _log = useLogger();

typedef IsarConfigCollection = IsarCollection<ConfigCollection>;
typedef ConfigCollectionList = List<ConfigCollection>;
typedef ConfigSubscription = StreamSubscription<ConfigCollection?>;

enum ConfigInstanceType {
  general,
  authenticated;
}

class ConfigInstance {
  final ConfigInstanceType instanceType;

  ConfigInstance({required this.instanceType});

  Isar? get dbInstance {
    switch (instanceType) {
      case ConfigInstanceType.authenticated:
        return DbManager().authenticatedInstance;
      default:
        return DbManager().generalInstance;
    }
  }

  IsarConfigCollection? get configCollection {
    return dbInstance?.configs;
  }

  Future<ConfigCollection> newConfig({required String key, required dynamic value}) async {
    final config = ConfigCollection(
      key: key,
    );
    config.setValue(value);

    return config;
  }

  Future<void> putAllConfigWithoutTxn(List<ConfigCollection> configs) async {
    await configCollection?.putAll(configs);
  }

  Future<void> saveConfig({required String key, required dynamic value}) async {
    await dbInstance?.writeTxn(() async {
      await saveConfigWithoutTxn(key: key, value: value);
    });
  }

  Future<void> saveConfigWithoutTxn({required String key, required dynamic value}) async {
    final config = ConfigCollection(key: key);
    config.setValue(value);

    await configCollection?.put(config);
  }

  void saveConfigSync({required String key, required dynamic value}) async {
    final configFromDb = getConfigSync(key: key);
    final config = configFromDb ?? ConfigCollection(key: key);
    config.setValue(value);

    dbInstance?.writeTxnSync(() {
      configCollection?.putSync(config);
    });
  }

  Future<void> clearConfig({required String key}) async {
    await dbInstance?.writeTxn(() async {
      await configCollection?.delete(fastHash(key));
    });
  }

  Future<void> clearConfigWithoutTxn({required String key}) async {
    await configCollection?.delete(fastHash(key));
  }

  void clearConfigSync({required String key}) {
    dbInstance?.writeTxnSync(() {
      configCollection?.deleteSync(fastHash(key));
    });
  }

  Future<ConfigCollection?> getConfig({required String key}) async {
    return configCollection?.get(fastHash(key));
  }

  ConfigCollection? getConfigSync({required String key}) {
    return configCollection?.getSync(fastHash(key));
  }

  Future<bool?> getBool({required String key}) async {
    return (await getConfig(key: key))?.boolValue;
  }

  Future<bool> getBoolWithDefault({required String key, required bool defaultValue}) async {
    return (await getConfig(key: key))?.boolValue ?? defaultValue;
  }

  Future<double?> getDouble({required String key}) async {
    return (await getConfig(key: key))?.doubleValue;
  }

  Future<double> getDoubleWithDefault({required String key, required double defaultValue}) async {
    return (await getConfig(key: key))?.doubleValue ?? defaultValue;
  }

  Future<String> getEnvWithDefault({required String key, required String defaultValue}) async {
    return (await getConfig(key: key))?.stringValue ?? defaultValue;
  }

  bool? getBoolSync({required String key}) {
    return getConfigSync(key: key)?.boolValue;
  }

  String? getStringEnvSync({required String key}) {
    return getConfigSync(key: key)?.stringValue;
  }

  bool getBoolWithDefaultSync({required String key, required bool defaultValue}) {
    return getConfigSync(key: key)?.boolValue ?? defaultValue;
  }

  Future<String?> getString({required String key}) async {
    return (await getConfig(key: key))?.stringValue;
  }

  Future<String> getStringWithDefault({required String key, required String defaultValue}) async {
    return (await getString(key: key)) ?? defaultValue;
  }

  String getStringWithDefaultSync({
    required String key,
    required String defaultValue,
  }) {
    return getStringSync(key: key) ?? defaultValue;
  }

  String? getStringSync({required String key}) {
    return getConfigSync(key: key)?.stringValue;
  }

  Future<int?> getInt({required String key}) async {
    return (await getConfig(key: key))?.intValue;
  }

  Future<int> getIntWithDefault({required String key, required int defaultValue}) async {
    return (await getInt(key: key)) ?? defaultValue;
  }

  int? getIntSync({required String key}) {
    return getConfigSync(key: key)?.intValue;
  }

  Future<DateTime?> getDateTime({required String key}) async {
    return (await getConfig(key: key))?.dateTimeValue;
  }

  Future<void> clear() async {
    await dbInstance?.writeTxn(() async {
      await configCollection?.clear();
    });
  }
}

class ConfigDb {
  // Singleton pattern
  static final ConfigDb instance = ConfigDb._internal();

  factory ConfigDb() => instance;

  ConfigDb._internal();

  final general = ConfigInstance(instanceType: ConfigInstanceType.general);
  final authenticated = ConfigInstance(instanceType: ConfigInstanceType.authenticated);

  ///
  /// Config key generator/helper
  ///

  static String getBoxStateSeqConfigKey(StateGroup group) {
    return 'STATE_${group.value}_SEQ';
  }

  static String getBoxFileFirstSequenceConfigKey(String roomId) {
    return 'ROOM_FILE_${roomId}_FIRST_SEQUENCE';
  }

  static String getOtpRequestTimestampConfigKey(String? phoneNumber) {
    return 'OTP_REQUEST_TIMESTAMP_${phoneNumber ?? 'DEFAULT'}';
  }

  static String getDontShowCoinPromotionDateTimeConfigKey() {
    return 'DONT_SHOW_COIN_PROMOTION_DATETIME';
  }

  static String getOAAccountIdConfigKey() {
    return 'OA_ACCOUNT_ID';
  }

  static String getOASystemAccountIdConfigKey() {
    return 'OA_SYSTEM_ACCOUNT_ID';
  }

  static String getEmailPasswordNotSetDialogDateTimeConfigKey() {
    return 'EMAIL_PASSWORD_NOT_SET_DIALOG_DATE_TIME';
  }

  static String getSavedSettingScreenRequestOtpResponseConfigKey() {
    return 'SAVED_SETTING_SCREEN_REQUEST_OTP_RESPONSE';
  }

  static String getEnableScreenRecordInSecretChatConfigKey() {
    return 'ENABLE_SCREEN_RECORD_IN_SECRET_CHAT';
  }

  static String getEnableWarModeConfigKey() {
    return 'ENABLE_WAR_MODE';
  }

  static String getEnableLogToTalkerKey() {
    return 'ENABLE_LOG_TO_TALKER';
  }

  static String getEnableTroubleshootEasyAccess() {
    return 'ENABLE_TROUBLESHOOT_EASY_ACCESS';
  }

  static String getEnableEventBusTrackingKey() {
    return 'ENABLE_EVENT_BUS_TRACKING';
  }

  static String getEventBusTrackingMaxHistoryKey() {
    return 'EVENT_BUS_TRACKING_MAX_HISTORY';
  }

  static String getTroubleshootEasyAccessPositionX() {
    return 'TROUBLESHOOT_EASY_ACCESS_POSITION_X';
  }

  static String getTroubleshootEasyAccessPositionY() {
    return 'TROUBLESHOOT_EASY_ACCESS_POSITION_Y';
  }

  static String getAllRoomLastSeenLastSyncConfigKey() {
    return 'ALL_ROOM_LAST_SEEN_LAST_SYNC';
  }

  static String getChatFolderSortingKey() {
    return 'CHAT_FOLDER_SORTING';
  }

  static String linkAccountConfigKey() {
    return 'LINK_ACCOUNT';
  }

  static String linkEmailConfigKey() {
    return 'LINK_EMAIL';
  }

  static String googleIdTokenConfigKey() {
    return 'GOOGLE_ID_TOKEN';
  }

  static String appleIdTokenConfigKey() {
    return 'APPLE_ID_TOKEN';
  }

  static String facebookIdTokenConfigKey() {
    return 'FACEBOOK_ID_TOKEN';
  }

  // This term version key is used to temporary store the accepted term and condition version from accept bottom sheet
  // to use when register is completed only. This does not save the current accepted term version of the current user.
  static String termVersionKey() {
    return 'TERM_VERSION_KEY';
  }

  static String savedOtpResponseConfigKey(String phoneNumber) {
    return 'SAVED_OTP_RESPONSE_$phoneNumber';
  }

  /// ----------------------------------------------------------------------
  /// Proxy related keys
  /// ----------------------------------------------------------------------

  static String getProxyIsEnabledKey() {
    return 'PROXY_IS_ENABLED';
  }

  static String getProxyIpKey() {
    return 'PROXY_IP';
  }

  static String getProxyPortKey() {
    return 'PROXY_PORT';
  }

  /// ----------------------------------------------------------------------
  /// App version related keys
  /// ----------------------------------------------------------------------

  static String getAppVersionLastVersionKey() {
    return 'APP_VERSION.LAST_VERSION';
  }

  static String getAppVersionLastVersionForceUpdateKey() {
    return 'APP_VERSION.LAST_VERSION_FORCE_UPDATE';
  }

  static String getAppVersionLastUpdateKey() {
    return 'APP_VERSION.LAST_UPDATE';
  }

  /// ----------------------------------------------------------------------
  /// Passcode related keys
  /// ----------------------------------------------------------------------

  static String getPasscodeKey() {
    return 'APP_PASSCODE';
  }

  static String getPasscodeAutoUseBiometricKey() {
    return 'APP_PASSCODE_AUTO_USE_BIOMETRIC';
  }

  @Deprecated('Use [getPasscodeAutoUseBiometricKey] instead')
  static String getOldPasscodeAutoUseBiometricKey() {
    return 'AUTO_USE_BIOMETRIC';
  }

  static String getPasscodeUseBiometricKey() {
    return 'APP_PASSCODE_BIOMETRIC';
  }

  static String getPasscodeIncorrectUnblockTimestampKey() {
    return 'APP_PASSCODE_INCORRECT_UNBLOCK_TIMESTAMP';
  }

  static String getPasscodeIncorrectStreakCountKey() {
    return 'APP_PASSCODE_INCORRECT_STREAK_COUNT';
  }

  /// Return key for the latest created at of a state that this device got from firebase.
  /// This will be used to listen for new states from firebase.
  static String getLastFirebaseStateCreatedAtKey() {
    return 'LAST_FIREBASE_STATE_CREATED_AT';
  }

  // Return key for the actual keyboard height from native.
  // Keyboard height is saved after keyboard is opened at least once. Will return null otherwise.
  static String getOpenedKeyboardHeightKey() {
    return 'OPENED_KEYBOARD_HEIGHT';
  }

  static String getDraftMessageKey() {
    return 'DRAFT_MESSAGE';
  }
}
