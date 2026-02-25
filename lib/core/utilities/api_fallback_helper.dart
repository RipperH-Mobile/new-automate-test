import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

/// A utility helper for handling socket/HTTP API fallback logic
Future<T> callApiWithFallback<T>({
  required SocketCaller socketCaller,
  required Future<T?> Function() socketCall,
  required Future<T?> Function() httpCall,
  String? methodName,
}) async {
  final _log = useLogger();

  if (socketCaller.isReadyForCall) {
    try {
      final socketRes = await socketCall();
      if (socketRes == null) {
        throw NullResponseException();
      }
      return socketRes;
    } on ApiException catch (e) {
      if (e.type != 'SERVICE_NOT_FOUND') rethrow;
    } catch (e, stackTrace) {
      _log.w('$methodName with socket error. fallback to http request...', e, stackTrace);
    }
  }

  final httpRes = await httpCall();
  if (httpRes == null) {
    throw NullResponseException();
  }
  return httpRes;
}
