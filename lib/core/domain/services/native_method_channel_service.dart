import 'package:flutter/services.dart';

///
/// Special type for method call handlers.
///
typedef MethodCallHandler = Future<dynamic> Function(MethodCall call);

///
/// Service for handling method calls from the native side.
///
abstract class NativeMethodChannelService {
  Future<void> initialize();

  void registerMethodCallHandler(String method, MethodCallHandler handler);

  void unregisterMethodCallHandler(String method, MethodCallHandler handler);

  void registerMethodCallHandlers(Map<String, MethodCallHandler> methodHandlers);

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]);
}
