import 'package:uchat/api/error/error.dart';
import 'package:uchat/core/exceptions/api_exception.dart';

extension ApiErrorMapExtension on ApiException {
  ApiException? toApiErrorMap() {
    return errorMap[type]?.call({
      'message': message,
      'code': code,
      'name': name,
      'type': type,
      'stackTrace': apiStacktrace,
    });
  }
}