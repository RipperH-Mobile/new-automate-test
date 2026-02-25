import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/entities/services.dart';

const serverTypeConfigKey = 'SERVER_TYPE';
const apiCustomTypeConfigKey = 'API_CUSTOM_URL';
const socketCustomTypeConfigKey = 'SOCKET_CUSTOM_URL';
const domainCustomTypeConfigKey = 'DOMAIN_CUSTOM_URL';

const appIdentifierDev = 'social.uchat.messenger.dev';
const appIdentifierSit = 'social.uchat.messenger.sit';
const appIdentifierUat = 'social.uchat.messenger.uat';
const appIdentifierPrd = 'social.uchat';

enum ServerEnvType {
  dev,
  sit,
  uat,
  prd,
  custom;

  String get value {
    switch (this) {
      case ServerEnvType.dev:
        return 'DEV';
      case ServerEnvType.sit:
        return 'SIT';
      case ServerEnvType.uat:
        return 'UAT';
      case ServerEnvType.prd:
        return 'PROD';
      case ServerEnvType.custom:
        return 'CUSTOM';
    }
  }

  static from(String val) {
    switch (val) {
      case 'DEV':
        return ServerEnvType.dev;
      case 'SIT':
        return ServerEnvType.sit;
      case 'UAT':
        return ServerEnvType.uat;
      case 'PROD':
        return ServerEnvType.prd;
      case 'CUSTOM':
        return ServerEnvType.custom;
      default:
        return ServerEnvType.prd;
    }
  }
}

class AppEnv {
  static String _apiUrlCustom = '';
  static String _socketApiCustom = '';
  static String _domainCustom = '';
  static ServerEnvType _serverEnvType = ServerEnvType.prd;

  static Future<void> loadConfig() async {
    final appId = GetIt.I<MetaService>().appId;
    final generalDb = ConfigDb().general;

    String serverEnvTypeDefault = ServerEnvType.prd.value;
    if (appId == appIdentifierDev) {
      serverEnvTypeDefault = ServerEnvType.dev.value;
    } else if (appId == appIdentifierSit) {
      serverEnvTypeDefault = ServerEnvType.sit.value;
    } else if (appId == appIdentifierUat) {
      serverEnvTypeDefault = ServerEnvType.uat.value;
    }

    final serverEnvTypeFromSaved = await generalDb.getEnvWithDefault(
      key: serverTypeConfigKey,
      defaultValue: serverEnvTypeDefault,
    );
    _serverEnvType = ServerEnvType.from(serverEnvTypeFromSaved);

    if (_serverEnvType == ServerEnvType.custom) {
      _apiUrlCustom = generalDb.getStringEnvSync(key: apiCustomTypeConfigKey) ?? '';
      _socketApiCustom = generalDb.getStringEnvSync(key: socketCustomTypeConfigKey) ?? '';
      _domainCustom = generalDb.getStringEnvSync(key: domainCustomTypeConfigKey) ?? '';
    }
  }

  static String get serverEnvType {
    return _serverEnvType.value;
  }

  /// Returns the default environment type based on app identifier
  /// This is the environment the app was built for (DEV/SIT/UAT/PROD)
  static String get defaultServerEnvType {
    final appId = GetIt.I<MetaService>().appId;
    if (appId == appIdentifierDev) {
      return ServerEnvType.dev.value;
    } else if (appId == appIdentifierSit) {
      return ServerEnvType.sit.value;
    } else if (appId == appIdentifierUat) {
      return ServerEnvType.uat.value;
    }
    return ServerEnvType.prd.value;
  }

  static set serverEnvType(String value) {
    final generalDb = ConfigDb().general;
    _serverEnvType = ServerEnvType.from(value);

    generalDb.saveConfigSync(key: serverTypeConfigKey, value: _serverEnvType.value);
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString('apiUrl', AppEnv.apiUrl);
        prefs.setString('googleApiKey', AppEnv.googleApiKey);
      },
    );
  }

  Future<void> setCustomServerType({
    required String inputApiUrl,
    required String inputSocketUrl,
    required String inputDomainUrl,
  }) async {
    ConfigDb().general.saveConfigSync(key: apiCustomTypeConfigKey, value: inputApiUrl);
    ConfigDb().general.saveConfigSync(key: socketCustomTypeConfigKey, value: inputSocketUrl);
    ConfigDb().general.saveConfigSync(key: domainCustomTypeConfigKey, value: inputDomainUrl);
    _apiUrlCustom = inputApiUrl;
    _socketApiCustom = inputSocketUrl;
    _domainCustom = inputDomainUrl;
  }

  static set isChangeEnv(String value) {
    _serverEnvType = ServerEnvType.from(value);
  }

  static bool get isDev {
    return _serverEnvType == ServerEnvType.dev;
  }

  static bool get isSit {
    return _serverEnvType == ServerEnvType.sit;
  }

  static bool get isUat {
    return _serverEnvType == ServerEnvType.uat;
  }

  static bool get isProd {
    return _serverEnvType == ServerEnvType.prd;
  }

  static bool get isCustom {
    return _serverEnvType == ServerEnvType.custom;
  }

  static bool get enableIsarInspector {
    String key = 'ENABLE_ISAR_INSPECTOR';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_ENABLE_ISAR_INSPECTOR';
        break;
    }

    final envStr = dotenv.get(key, fallback: 'FALSE').toString();
    return envStr.toUpperCase() == 'TRUE';
  }

  static bool get isDebug {
    String key = 'APP_DEBUG';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_APP_DEBUG';
        break;
    }

    final envStr = dotenv.get(key, fallback: 'FALSE').toString();
    return envStr.toUpperCase() == 'TRUE';
  }

  static bool get isSentryDebug {
    String key = 'SENTRY_DEBUG';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_SENTRY_DEBUG';
        break;
    }

    final envStr = dotenv.get(key, fallback: 'FALSE').toString();
    return envStr.toUpperCase() == 'TRUE';
  }

  static String get apiUrl {
    final fallback = 'https://api.dev.uchat.social/api/';

    String key = 'API_URL';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        return _apiUrlCustom;
      default:
        key = '${_serverEnvType.value}_MODE_API_URL';
        break;
    }

    return dotenv.get(key, fallback: fallback);
  }

  static String get socketUrl {
    const fallback = 'wss://socket-next.uchat.social';

    String key = 'SOCKET_URL';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        return _socketApiCustom;
      default:
        key = '${_serverEnvType.value}_MODE_SOCKET_URL';
        break;
    }

    return dotenv.get(key, fallback: fallback);
  }

  static String get sentryDsn {
    String key = 'SENTRY_DSN';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_SENTRY_DSN';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get domain {
    String key = 'DOMAIN';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        return _domainCustom;
      default:
        key = '${_serverEnvType.value}_MODE_DOMAIN';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get termAndConditionsUrl {
    return '$domain/terms-conditions';
  }

  static String getTermAndConditionsUrlWith({String? lang}) {
    final currentLang = (Get.locale?.languageCode.toLowerCase() == 'th') ? 'th' : 'en';
    final language = lang ?? currentLang;

    return '$termAndConditionsUrl?lang=$language';
  }

  static String get policyUrl {
    return '$domain/privacy';
  }

  static String getPolicyUrl({String? lang}) {
    final currentLang = (Get.locale?.languageCode.toLowerCase() == 'th') ? 'th' : 'en';
    final language = lang ?? currentLang;

    return '$policyUrl?lang=$language';
  }

  static String get addFriendPrefix {
    return '$domain/u/';
  }

  static String get stickerSharingPrefix {
    return '$domain/sticker/';
  }

  static String get desktopLoginPrefix {
    return '$domain/desktop-login';
  }

  static String get oaLoginPrefix {
    return '$domain/oa-login';
  }

  static String get authCodePrefix {
    return '$domain/auth-code';
  }

  static String get resetPasswordPrefix {
    return '$domain/set-new-password';
  }

  static String get roomInviteLinkPrefix {
    return '$domain/invite/';
  }

  static String get giphyApiKey {
    String key = 'GIPHY_API_KEY';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        key = 'DEV_MODE_GIPHY_API_KEY';
        break;
      default:
        key = '${_serverEnvType.value}_MODE_GIPHY_API_KEY';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get oneSignalAppID {
    String key = 'ONESIGNAL_APP_ID';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        key = 'DEV_MODE_ONESIGNAL_APP_ID';
        break;
      default:
        key = '${_serverEnvType.value}_MODE_ONESIGNAL_APP_ID';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get oneSignalCallAppID {
    String key = 'ONESIGNAL_CALL_APP_ID';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      case ServerEnvType.custom:
        key = 'DEV_MODE_ONESIGNAL_CALL_APP_ID';
        break;
      default:
        key = '${_serverEnvType.value}_MODE_ONESIGNAL_CALL_APP_ID';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get googleApiKey {
    String key = 'GOOGLE_API_KEY';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_GOOGLE_API_KEY';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get socketLiveKit {
    String key = 'LIVE_KIT_URL';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_LIVE_KIT_URL';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get reCaptchaIosSiteKey {
    final key = 'RECAPTCHA_IOS_SITE_KEY';

    return dotenv.get(key, fallback: '');
  }

  static String get reCaptchaAndroidSiteKey {
    final key = 'RECAPTCHA_ANDROID_SITE_KEY';

    return dotenv.get(key, fallback: '');
  }

  static int get uploadProChunkSize {
    final key = 'UPLOAD_PRO_CHUNK_SIZE';

    return int.parse(dotenv.get(key, fallback: '52428800'));
  }

  static int get userIDLengthLimit {
    return 20;
  }

  static int get displayNameLengthLimit {
    return 20;
  }

  static int get statusMessageLengthLimit {
    return 50;
  }

  ///
  /// The [proxyEnabled], [proxyHost] and [proxyPort]
  /// are used to call to proxy with Dio and Socket.
  ///
  static bool get proxyEnabled {
    final key = 'PROXY_ENABLED';
    final envStr = dotenv.get(key, fallback: 'FALSE').toString();

    return envStr.toUpperCase() == 'TRUE';
  }

  static String get proxyHost {
    final key = 'PROXY_HOST';
    return dotenv.get(key, fallback: '');
  }

  static int get proxyPort {
    final key = 'PROXY_PORT';
    return int.parse(dotenv.get(key, fallback: '0'));
  }

  static String get firebaseOnlineStatusDbUrl {
    String key = 'FIREBASE_ONLINE_STATUS_DB_URL';

    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_FIREBASE_ONLINE_STATUS_DB_URL';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get firebaseStateDbUrl {
    String key = 'FIREBASE_STATE_DB_URL';

    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_FIREBASE_STATE_DB_URL';
        break;
    }

    return dotenv.get(key, fallback: '');
  }

  static String get amplitudeApiKey {
    String key = 'AMPLITUDE_API_KEY';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        break;
      default:
        key = '${_serverEnvType.value}_MODE_AMPLITUDE_API_KEY';
        break;
    }
    return dotenv.get(key, fallback: '');
  }

  /// schemeDeepLink
  ///
  /// This value is used for deep link handling.
  ///
  /// You can see the value and change it in `android/app/build.gradle.kts`.
  static String get schemeDeepLink {
    String scheme = 'uchat';
    switch (_serverEnvType) {
      case ServerEnvType.prd:
        return scheme;
      case ServerEnvType.uat:
        return '$scheme-uat';
      case ServerEnvType.sit:
        return '$scheme-sit';
      case ServerEnvType.dev:
        return '$scheme-dev';
      case ServerEnvType.custom:
        return '$scheme-custom';
    }
  }
}
