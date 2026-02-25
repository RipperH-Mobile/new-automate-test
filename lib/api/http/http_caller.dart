import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/utils/app_env.dart';

import '../error/error.dart';
import '../error/report.dart';
import 'dio_extension.dart';
import 'http_heartbeat.dart';
import 'proxy_http_override.dart';

export 'dio_extension.dart';

typedef ResponseMap = Map<String, dynamic>;

final _log = useLogger();

const String _authorizationHeader = 'Authorization';

const int connectTimeoutMs = 30000;
const int receiveTimeoutMs = 30000;
const int sendTimeoutMs = 30000;

///
/// HttpCaller class
///
/// This class is a singleton that handles all HTTP requests using Dio.
/// It provides methods for GET, POST, PUT, and DELETE requests.
/// It also handles error conversion and logging.
///
class HttpCaller {
  static final HttpCaller instance = HttpCaller._internal();

  factory HttpCaller() => instance;

  ///
  /// Singleton instance constructor
  ///
  HttpCaller._internal() {
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printResponseData: false,
          printRequestData: false,
          printResponseHeaders: true,
          printRequestHeaders: true,
        ),
      ),
    );

    //
    // Set proxy if enabled.
    // Maybe only for development.
    //
    loadProxyConfig();
  }

  ///
  /// Load proxy config
  ///
  Future<void> loadProxyConfig() async {
    // Load the proxy settings from the configuration
    final general = ConfigDb().general;

    final isEnable = await general.getBoolWithDefault(
      key: ConfigDb.getProxyIsEnabledKey(),
      defaultValue: AppEnv.proxyEnabled,
    );

    final ip = await general.getStringWithDefault(
      key: ConfigDb.getProxyIpKey(),
      defaultValue: AppEnv.proxyHost,
    );

    final port = await general.getIntWithDefault(
      key: ConfigDb.getProxyPortKey(),
      defaultValue: AppEnv.proxyPort,
    );

    useLogger().d('Load proxy config: $ip:$port, isEnable: $isEnable');

    if (isEnable) {
      final httpAdapter = IOHttpClientAdapter();
      httpAdapter.createHttpClient = () {
        final client = HttpClient();

        client.findProxy = (uri) {
          return 'PROXY $ip:$port';
        };

        client.badCertificateCallback = (cert, host, port) => true;

        return client;
      };

      dio.httpClientAdapter = httpAdapter;

      // Fallback set proxy for the global HttpClient.
      HttpOverrides.global = ProxyHttpOverride(ip: ip, port: port);
    }
  }

  ///
  /// Create Dio instance
  ///
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: connectTimeoutMs),
    receiveTimeout: const Duration(milliseconds: receiveTimeoutMs),
    sendTimeout: const Duration(milliseconds: sendTimeoutMs),
  ));

  ///
  /// The access handler for the dio instance
  ///
  String? _accessToken;

  String? get accessToken => _accessToken;

  void updateAccessToken(String token) {
    _accessToken = token;
  }

  void removeAccessToken() {
    useLogger().d('HttpCaller => removeAccessToken');
    _accessToken = null;
  }

  ///
  /// Getter for language code
  ///
  String get acceptLang {
    return Get.locale?.languageCode ?? 'en';
  }

  ///
  /// Http heartbeat handler
  ///
  HttpHeartbeat? _heartbeat;

  HttpHeartbeat get heartbeat {
    _heartbeat ??= HttpHeartbeat(httpCaller: this);

    return _heartbeat!;
  }

  ///
  /// Helper function to parse URL
  ///
  String parseUrl(String url) {
    return '${AppEnv.apiUrl}$url';
  }

  ///
  /// Getter for the API header
  ///
  Map<String, String> get apiHeader {
    return {
      _authorizationHeader: 'Bearer $accessToken',
      'Accept-Language': acceptLang,
      'X-Browser-Name': GetIt.I<MetaService>().appName,
      'X-Browser-Version': GetIt.I<MetaService>().appVersion,
      'X-Browser-Major': GetIt.I<MetaService>().appBuildNumber,
      'X-App-Id': GetIt.I<MetaService>().appId,
      'X-Device-Name': GetIt.I<MetaService>().deviceNameUtf8,
      'X-Device-Model': GetIt.I<MetaService>().deviceModelUtf8,
      'X-Device-OS': GetIt.I<MetaService>().deviceOsUtf8,
      'X-Device-Type': GetIt.I<MetaService>().deviceType,
    };
  }

  ///
  /// Helper function to wrap the UTF-8 string for easy encoding on the server
  ///
  String utf8HeaderWrapper(String utf8String) {
    return 'uc${utf8String}hat';
  }

  ///
  /// Helper function to set device headers
  ///
  void _setDeviceHeader(ResponseMap headers) {
    final metaService = GetIt.I<MetaService>();
    headers['X-Browser-Name'] = utf8HeaderWrapper(metaService.appNameUtf8);
    headers['X-Browser-Version'] = utf8HeaderWrapper(metaService.appVersionUtf8);
    headers['X-Browser-Major'] = utf8HeaderWrapper(metaService.appBuildNumberUtf8);
    headers['X-App-Id'] = utf8HeaderWrapper(metaService.appIdUtf8);
    headers['X-Device-OS'] = utf8HeaderWrapper(metaService.deviceOsUtf8);
    headers['X-Device-Type'] = metaService.deviceType;

    if (metaService.deviceName != null) {
      headers['X-Device-Name'] = utf8HeaderWrapper(metaService.deviceNameUtf8);
    }

    if (metaService.deviceModel != null) {
      headers['X-Device-Model'] = utf8HeaderWrapper(metaService.deviceModelUtf8);
    }

    if (metaService.deviceOsVersion != null) {
      headers['X-Device-OS-Version'] = metaService.deviceOsVersion;
    }
  }

  ///
  /// Wrapper function for the GET request
  ///
  Future<Response<T>> get<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? customAccessToken,
    bool isExternalApi = false,
  }) async {
    final reqUrl = isExternalApi ? url : parseUrl(url);

    try {
      options ??= Options(headers: {});

      options.headers ??= {};
      options.headers!['Accept-Language'] = acceptLang;

      // Use access token only app api host.
      if (customAccessToken != null) {
        options.headers![_authorizationHeader] = 'Bearer $customAccessToken';
      } else if (accessToken != null && (!isExternalApi || (isExternalApi && url.contains(AppEnv.apiUrl)))) {
        options.headers![_authorizationHeader] = 'Bearer $accessToken';
      }

      _setDeviceHeader(options.headers!);

      return await dio.get<T>(
        reqUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e, stackTrace) {
      final apiError = _convertError(e);

      // Check UChat api error.
      _throwApiError(
        method: 'GET',
        apiError: apiError,
        reqUrl: reqUrl,
        stackTrace: stackTrace,
      );

      // Fallback to dio error.
      if (e.response?.statusCode == 500) {
        _log.e(UChatLogMessage(
          message: '[DIO->GET] DioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->GET] DioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else {
        _log.w(UChatLogMessage(
          message: '[DIO->GET] UnknownDioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->GET] UnknownDioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      }
      rethrow;
    } catch (e, stackTrace) {
      _log.w(UChatLogMessage(
        message: '[DIO->GET] UnknownError, Uri: $reqUrl.',
        additionalMessage: '[DIO->GET] UnknownError.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {'url': reqUrl},
      ));
      rethrow;
    }
  }

  ///
  /// Wrapper function for the POST request
  ///
  Future<Response<T>> post<T>(
    String url, {
    data,
    Options? options,
    String? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? customAccessToken,
    bool isExternalApi = false,
  }) async {
    String reqUrl = isExternalApi ? url : parseUrl(url);

    try {
      options ??= Options(headers: {});

      options.headers ??= {};
      options.headers!['Accept-Language'] = acceptLang;

      if (customAccessToken != null) {
        options.headers![_authorizationHeader] = 'Bearer $customAccessToken';
      } else if (accessToken != null) {
        options.headers![_authorizationHeader] = 'Bearer $accessToken';
      }

      _setDeviceHeader(options.headers!);

      if (queryParameters != null) {
        reqUrl += queryParameters;
      }

      return await dio.post<T>(
        reqUrl,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e, stackTrace) {
      final apiError = _convertError(e);

      // Check UChat api error
      _throwApiError(
        method: 'POST',
        apiError: apiError,
        reqUrl: reqUrl,
        stackTrace: stackTrace,
      );

      // Fallback to dio error.
      if (e.response?.statusCode == 500) {
        _log.e(UChatLogMessage(
          message: '[DIO->POST] DioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->POST] DioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else {
        _log.w(UChatLogMessage(
          message: '[DIO->POST] UnknownDioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->POST] UnknownDioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      }
      rethrow;
    } catch (e, stackTrace) {
      _log.w(UChatLogMessage(
        message: '[DIO->POST] UnknownError, Uri: $reqUrl.',
        additionalMessage: '[DIO->POST] UnknownError.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {'url': reqUrl},
      ));
      rethrow;
    }
  }

  ///
  /// Wrapper function for the PUT request
  ///
  Future<Response<T>> put<T>(
    String url, {
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isExternalApi = false,
    bool useDefaultHeader = true,
  }) async {
    final reqUrl = isExternalApi ? url : parseUrl(url);

    try {
      options ??= Options(headers: {});

      options.headers ??= {};
      options.headers!['Accept-Language'] = acceptLang;

      if (accessToken != null && useDefaultHeader) {
        options.headers![_authorizationHeader] = 'Bearer $accessToken';
      }

      _setDeviceHeader(options.headers!);

      return await dio.put<T>(
        reqUrl,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e, stackTrace) {
      final apiError = _convertError(e);

      // Check UChat api error
      _throwApiError(
        method: 'PUT',
        apiError: apiError,
        reqUrl: reqUrl,
        stackTrace: stackTrace,
      );

      // Fallback to dio error.
      if (e.response?.statusCode == 500) {
        _log.e(UChatLogMessage(
          message: '[DIO->PUT] DioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->PUT] DioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else {
        _log.w(UChatLogMessage(
          message: '[DIO->PUT] UnknownDioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->PUT] UnknownDioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      }
      rethrow;
    } catch (e, stackTrace) {
      _log.w(UChatLogMessage(
        message: '[DIO->PUT] UnknownError, Uri: $reqUrl.',
        additionalMessage: '[DIO->PUT] UnknownError.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {'url': reqUrl},
      ));
      rethrow;
    }
  }

  ///
  /// Wrapper function for the DELETE request
  ///
  Future<Response<T>> delete<T>(
    String url, {
    data,
    Options? options,
    CancelToken? cancelToken,
    bool isExternalApi = false,
  }) async {
    final reqUrl = isExternalApi ? url : parseUrl(url);

    try {
      options ??= Options(headers: {});

      options.headers ??= {};
      options.headers!['Accept-Language'] = acceptLang;

      // Use access token only app api host.
      if (accessToken != null && (!isExternalApi || (isExternalApi && url.contains(AppEnv.apiUrl)))) {
        options.headers![_authorizationHeader] = 'Bearer $accessToken';
      }

      _setDeviceHeader(options.headers!);

      return await dio.delete<T>(
        reqUrl,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e, stackTrace) {
      final apiError = _convertError(e);
      _throwApiError(
        method: 'DELETE',
        apiError: apiError,
        reqUrl: reqUrl,
        stackTrace: stackTrace,
      );

      // Fallback to dio error.
      if (e.response?.statusCode == 500) {
        _log.e(UChatLogMessage(
          message: '[DIO->DELETE] DioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->DELETE] DioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else {
        _log.w(UChatLogMessage(
          message: '[DIO->DELETE] UnknownDioError, Uri: $reqUrl.',
          additionalMessage: '[DIO->DELETE] UnknownDioError.',
          error: e,
          stackTrace: e.stackTrace,
          additionalData: {'url': reqUrl},
        ));
      }
      rethrow;
    } catch (e, stackTrace) {
      _log.w(UChatLogMessage(
        message: '[DIO->DELETE] UnknownError, Uri: $reqUrl.',
        additionalMessage: '[DIO->DELETE] UnknownError.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {'url': reqUrl},
      ));
      rethrow;
    }
  }

  ///
  /// Helper function to convert the response to a map
  ///
  ResponseMap? responseToMap(Response response) {
    return response.toMap();
  }

  ///
  /// Helper function to convert the response to a list of maps
  ///
  List<ResponseMap> responseToListMap(Response response) {
    return response.toListMap();
  }

  ///
  /// Helper function to check if the response is an error, then throw an ApiException
  ///
  void _throwApiError({
    required String method,
    required ApiException? apiError,
    required String reqUrl,
    required StackTrace stackTrace,
  }) {
    // Check UChat api error.
    if (apiError != null) {
      if (apiError.code == 503) {
        // TODO: Move to event, avoid `AppController` delay init.
        if (apiError.type == 'ERR_SERVICE_ON_MAINTENANCE_MODE') {
          AppController.instance.maintenanceError(
            apiError.data?.getMessageData(
                  AnnouncementController.instance.lang.toUpperCase(),
                ) ??
                apiError.message,
          );
        }
      } else if (apiError.code == 400 && apiError.type == 'ERR_DEPRECATED') {
        GetIt.I<AppVersionService>().notifyUpdate();
      } else if (apiError.code == 422) {
        if (apiError is ApiValidationException) {
          final validationError = apiError;
          final validationStr = validationError.validationData?.map((e) => '--> ${e.message}: ${e.type}').join('\n');

          _log.w(UChatLogMessage(
            message: '[DIO->$method] ApiValidationError, Uri: $reqUrl.\n'
                'Validation Data:\n'
                '$validationStr',
            additionalMessage: '[DIO->$method] ApiValidationError.',
            error: apiError,
            stackTrace: apiError.apiStacktrace ?? stackTrace,
            additionalData: {'url': reqUrl},
          ));
        } else {
          _log.w(UChatLogMessage(
            message: '[DIO->$method] ApiError with error code 422, Uri: $reqUrl.',
            additionalMessage: '[DIO->$method] ApiError with error code 422.',
            error: apiError,
            stackTrace: apiError.apiStacktrace ?? stackTrace,
            additionalData: {'url': reqUrl},
          ));
        }
      } else if (apiError.code == 500) {
        _log.e(UChatLogMessage(
          message: '[DIO->$method] ApiError, Uri: $reqUrl.',
          additionalMessage: '[DIO->$method] ApiError.',
          error: apiError,
          stackTrace: apiError.apiStacktrace ?? stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else if (!errorTypeIsNotReport.contains(apiError.type)) {
        _log.w(UChatLogMessage(
          message: '[DIO->$method] ApiError, Uri: $reqUrl.',
          additionalMessage: '[DIO->$method] ApiError.',
          error: apiError,
          stackTrace: apiError.apiStacktrace ?? stackTrace,
          additionalData: {'url': reqUrl},
        ));
      } else {
        _log.i(UChatLogMessage(
          message: '[DIO->$method] ApiError, Uri: $reqUrl.',
          additionalMessage: '[DIO->$method] ApiError.',
          error: apiError,
          stackTrace: apiError.apiStacktrace ?? stackTrace,
          additionalData: {'url': reqUrl},
        ));
      }
      throw apiError;
    }
  }

  ///
  /// Helper function to convert the error to an ApiException
  ///
  ApiException? _convertError(DioException e) {
    if (e.error is SocketException) {
      final socketError = e.error as SocketException;

      if (socketError.message.contains('Failed host lookup') == true) {
        throw FailedHostLookupException(
          message: socketError.message,
          address: socketError.address?.host ?? '',
        );
      }
    }

    if (e.message?.contains('Failed host lookup') == true) {
      throw FailedHostLookupException();
    } else if (e.response != null) {
      try {
        ResponseMap response = json.decode(e.response.toString());

        String? name = response['name'];
        if (name != null) {
          response['type'] ??= 'UnknownError';
          response['code'] ??= 400;
          response['message'] ??= 'UnknownError';

          final String type = response['type'];

          final errorFunction = errorMap[type];

          if (errorFunction != null) {
            return errorFunction({
              ...response,
              'stackTrace': e.stackTrace,
            });
          }

          return ApiException.fromMap({
            ...response,
            'stackTrace': e.stackTrace,
          });
        }
      } catch (catchError) {
        if (e.response?.data is String) {
          return ApiException.fromMap({
            'message': e.response?.data,
            'code': e.response?.statusCode,
            'stackTrace': e.stackTrace,
          });
        }

        return ApiException.fromMap({
          'message': e.message,
          'code': e.response?.statusCode,
          'stackTrace': e.stackTrace,
        });
      }
    }

    return null;
  }
}
