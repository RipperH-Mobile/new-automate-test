import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';

import 'logger_service.dart';

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    FlutterError.onError = _handleFlutterError;
    PlatformDispatcher.instance.onError = _handlePlatformError;

    // Integrate with LoggerService
    final logger = GetIt.I<LoggerService>();
    logger.removeLogListener(_handleLoggerListener);
    logger.addLogListener(_handleLoggerListener);
  }

  void _handleLoggerListener(LogEvent event) {
    // Ignore logs in debug mode
    if (kDebugMode) return;

    if (event.level.index < Level.error.index) return;

    UChatLogMessage? uchatLogMessage;
    if (event.message is UChatLogMessage) {
      uchatLogMessage = event.message;
    }

    dynamic error;
    if (uchatLogMessage?.error != null) {
      error = uchatLogMessage!.error;
    } else {
      error = event.error;
    }

    // finally for error.
    error ??= event.message.toString();

    dynamic stackTrace;
    if (uchatLogMessage?.stackTrace != null) {
      stackTrace = uchatLogMessage!.stackTrace;
    } else {
      stackTrace = event.stackTrace;
    }

    final List<Object> information = [];

    if (event.message is UChatLogMessage) {
      final message = event.message as UChatLogMessage;

      information.add({
        'message': message.message,
        'additionalMessage': message.additionalMessage,
        'additionalData': message.additionalData,
      });
      _crashlytics.setCustomKey('error_title', message.message);
    } else {
      information.add({
        'message': event.message,
      });
    }

    information.add({
      'currentRoute': Get.currentRoute,
      'prevRoute': Get.previousRoute,
    });

    _crashlytics.recordError(
      error,
      stackTrace,
      information: information,
    );
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      useLogger().eNoError('Flutter error: ${details.exceptionAsString()}', details, details.stack);
      // debugPrintStack(stackTrace: details.stack, label: 'Flutter error: ${details.exception}');
      return;
    }

    final filteredDetails = FlutterErrorDetails(
      exception: details.exception,
      stack: _filterStackTrace(details.stack),
      library: details.library,
      context: details.context,
      informationCollector: details.informationCollector,
      silent: details.silent,
    );

    _crashlytics.recordFlutterFatalError(filteredDetails);
  }

  bool _handlePlatformError(Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrintStack(stackTrace: _filterStackTrace(stack), label: 'Flutter error: $error');
      return true;
    }

    final List<Object> information = [
      {
        'currentRoute': Get.currentRoute,
        'prevRoute': Get.previousRoute,
      }
    ];

    _crashlytics.recordError(error, _filterStackTrace(stack), information: information, fatal: true);
    return true;
  }

  StackTrace? _filterStackTrace(StackTrace? stack) {
    if (stack == null) return stack;

    final List<String> lines = stack.toString().split('\n');

    if (lines.isNotEmpty && lines.last.contains('io.flutter.plugins.firebase.crashlytics.FlutterError')) {
      final List<String> filteredLines = lines.sublist(0, lines.length - 1);

      if (filteredLines.isEmpty) {
        return stack;
      }

      return StackTrace.fromString(filteredLines.join('\n'));
    }

    return stack;
  }

  Future<void> onUserLoaded() async {
    if (UserController().currentUser()?.id case final id?) {
      await _crashlytics.setUserIdentifier(id);
    }
  }
}
