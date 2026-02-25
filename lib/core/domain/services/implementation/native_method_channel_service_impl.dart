import 'package:flutter/services.dart';

import '../../../infrastructure/analytics/logger_service.dart';
import '../native_method_channel_service.dart';

///
/// Implementation of the [NativeMethodChannelService] that uses a [MethodChannel].
///
class NativeMethodChannelServiceImpl implements NativeMethodChannelService {
  final _channel = const MethodChannel('social.uchat');

  final Map<String, List<MethodCallHandler>> _handlers = {};

  @override
  Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    final method = call.method;

    if (!_handlers.containsKey(method) || _handlers[method]!.isEmpty) {
      useLogger().d('No handler registered for method: $method');
      return;
    }

    dynamic result;
    for (final handler in _handlers[method]!) {
      try {
        result = await handler(call);
      } catch (e, stackTrace) {
        useLogger().e('Error in handler for method $method', e, stackTrace);
      }
    }

    return result;
  }

  @override
  void registerMethodCallHandler(String method, MethodCallHandler handler) {
    if (!_handlers.containsKey(method)) {
      _handlers[method] = [];
    }

    if (!_handlers[method]!.contains(handler)) {
      _handlers[method]!.add(handler);
    }
  }

  @override
  void unregisterMethodCallHandler(String method, MethodCallHandler handler) {
    if (_handlers.containsKey(method)) {
      _handlers[method]!.remove(handler);
    }
  }

  @override
  void registerMethodCallHandlers(Map<String, MethodCallHandler> methodHandlers) {
    methodHandlers.forEach(registerMethodCallHandler);
  }

  @override
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    return _channel.invokeMethod<T>(method, arguments);
  }
}
