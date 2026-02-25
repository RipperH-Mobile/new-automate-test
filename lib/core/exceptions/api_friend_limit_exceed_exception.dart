import 'package:uchat/api/payloads/exception/data_api_exception.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';

import 'api_exception.dart';

class ApiFriendLimitExceedException implements ApiException {
  @override
  final String message;

  @override
  final String? name;

  @override
  final String? type;

  @override
  final int? code;

  @override
  final StackTrace? apiStacktrace;

  @override
  final DataApiException? data;

  /// Creates a new ApiException with an optional error detail.
  /// Param: Code is http response code
  /// Param: Name is error name
  /// Param: Type is error type
  /// Param: Message is message
  ApiFriendLimitExceedException({
    required this.message,
    this.code,
    this.name,
    this.type,
    this.data,
    this.apiStacktrace,
  });

  factory ApiFriendLimitExceedException.fromMap(Map<dynamic, dynamic> data) {
    DataApiException? dataApiException;
    if (data['data'] != null) {
      dataApiException = DataApiException.fromMap(data['data']);
    }

    return ApiFriendLimitExceedException(
      message: data['message'],
      code: data['code'],
      name: data['name'],
      type: data['type'],
      apiStacktrace: data['stackTrace'],
      data: dataApiException,
    );
  }

  @override
  String toString() {
    return 'ApiFriendLimitExceedException: $code ($type): $name -> $message';
  }

  @override
  ApiExceptionType? get exceptionType => ApiExceptionType.from(type ?? 'unknownError');
}
