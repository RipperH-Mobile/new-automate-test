import 'package:uchat/api/payloads/exception/data_api_exception.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';

import 'api_exception.dart';

class ApiOfficialAccountLimitExceedException implements ApiException {
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

  @override
  ApiExceptionType? get exceptionType => ApiExceptionType.from(type ?? 'unknownError');

  /// Creates a new ApiOfficialAccountLimitExceedException with an optional error detail.
  /// Param: Code is http response code
  /// Param: Name is error name
  /// Param: Type is error type
  /// Param: Message is message
  ApiOfficialAccountLimitExceedException({
    required this.message,
    this.code,
    this.name,
    this.type,
    this.data,
    this.apiStacktrace,
  });

  factory ApiOfficialAccountLimitExceedException.fromMap(Map<dynamic, dynamic> data) {
    DataApiException? dataApiException;
    if (data['data'] != null) {
      dataApiException = DataApiException.fromMap(data['data']);
    }

    return ApiOfficialAccountLimitExceedException(
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
    return 'ApiOfficialAccountLimitExceedException: $code ($type): $name -> $message';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiOfficialAccountLimitExceedException &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          name == other.name &&
          type == other.type &&
          code == other.code;

  @override
  int get hashCode => message.hashCode ^ name.hashCode ^ type.hashCode ^ code.hashCode;
}
