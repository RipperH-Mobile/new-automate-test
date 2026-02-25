import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:amplitude_flutter/events/identify.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/utils/app_env.dart';

class AmplitudeServiceImpl implements TaxonomyService {
  static const String _skipTaxonomyServiceKey = 'skip_taxonomy_service';

  Amplitude? _amplitude;
  Amplitude? customAmplitude;
  final LoggerService _logger;

  final String apiKey;

  final Map<String, dynamic> _eventProperties = {};

  Amplitude get amplitude => customAmplitude ?? _amplitude!;

  AmplitudeServiceImpl(this.apiKey, this._logger, {this.customAmplitude}) {
    // Initialize Amplitude SDK or any other analytics service here.
    _amplitude = Amplitude(Configuration(apiKey: apiKey));
    _logger.removeLogListener(errorLogListener);
    _logger.addLogListener(errorLogListener);
  }

  Map<String, dynamic> userProperties = {};

  Map<String, dynamic> get eventProperties => _eventProperties;

  @override
  Future<void> setUser(
    UserEntity user, {
    Map<String, dynamic>? userProperties,
    int? officialAccountNumber,
    int? friendNumber,
    int? groupNumber,
  }) async {
    try {
      _eventProperties.putIfAbsent('user_id', () => user.id);
      final userId = user.id;
      if (userId == null) {
        throw ArgumentError('User ID cannot be null');
      }

      // Set user ID in Amplitude
      await amplitude.setUserId(userId);
      // Optionally, you can set user properties here
      if (userProperties != null) {
        final identify = Identify();
        // Set additional user properties
        for (final entry in userProperties.entries) {
          identify.set(entry.key, entry.value);
        }
        await amplitude.identify(identify);
      }
    } catch (e, stackTrace) {
      _logger.e(UChatLogMessage(
        message: 'SetUser in amplitude service error.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {_skipTaxonomyServiceKey: true},
      ));
    }
  }

  @override
  Future<void> onUnauthenticated() async {
    try {
      // Unset user ID in Amplitude
      await amplitude.setUserId(null);
    } catch (e, stackTrace) {
      _logger.e(UChatLogMessage(
        message: 'Setting amplitude user to null failed in onUnauthenticated',
        error: e,
        stackTrace: stackTrace,
        additionalData: {_skipTaxonomyServiceKey: true},
      ));
    }
  }

  @override
  Future<void> sendEvent(
    EventName eventName, {
    Map<String, dynamic>? eventProperties,
    bool sendImmediately = false,
  }) async {
    try {
      // Reset all value in _eventProperties except 'user_id'
      _eventProperties.removeWhere((key, _) => key != 'user_id');
      _eventProperties.addAll(eventProperties ?? {});
      final amplitudeEvent = BaseEvent(
        eventName.name,
        eventProperties: _eventProperties,
      );

      // Send the event to Amplitude
      await amplitude.track(amplitudeEvent);

      if (sendImmediately) {
        await amplitude.flush();
      }
    } catch (e, stackTrace) {
      _logger.e(UChatLogMessage(
        message: 'Send event to amplitude error.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {_skipTaxonomyServiceKey: true},
      ));
    }
  }

  @override
  Future<void> onAuthenticated(
    UserEntity? user, {
    int? officialAccountNumber,
    int? friendNumber,
    int? groupNumber,
  }) async {
    if (user == null) {
      await onUnauthenticated();
      return;
    }
    userProperties = {
      'premium_package_id': user.premiumPackageId,
      'app_environment': AppEnv.serverEnvType,
      'language': Get.locale?.languageCode,
      'official_account_number': officialAccountNumber,
      'friend_number': friendNumber,
      'group_number': groupNumber,
    };
    await setUser(
      user,
      userProperties: userProperties,
      officialAccountNumber: officialAccountNumber,
      friendNumber: friendNumber,
      groupNumber: groupNumber,
    );
    await sendEvent(EventName.openApp);
  }

  Future<void> errorLogListener(LogEvent event) async {
    if (event.level.index < Level.error.index) return;

    UChatLogMessage? uchatLogMessage;
    if (event.message is UChatLogMessage) {
      // Skip if the log is marked to skip taxonomy service to prevent infinite loop when send event to amplitude fails.
      if (event.message.additionalData != null && event.message.additionalData![_skipTaxonomyServiceKey] == true) {
        return;
      }
      uchatLogMessage = event.message;
    }

    dynamic errorType;
    if (uchatLogMessage?.error != null) {
      errorType = uchatLogMessage!.error;
    } else {
      errorType = event.error;
    }

    // finally for error.
    errorType ??= event.message.toString();

    final errorEventProperty = {};

    if (event.message is UChatLogMessage) {
      final message = event.message as UChatLogMessage;

      errorEventProperty.putIfAbsent('error_message', () => message.message);
      errorEventProperty.putIfAbsent('error_additional_message', () => message.additionalMessage);
      errorEventProperty.putIfAbsent('error_additional_data', () => message.additionalData);
    } else {
      errorEventProperty.putIfAbsent('error_message', () => event.message);
    }

    await sendEvent(
      EventName.appErrorOccurred,
      eventProperties: EventProperty.appErrorOccurred(errorType: errorType),
    );
  }
}
