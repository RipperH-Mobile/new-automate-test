import 'package:uchat/api/payloads.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';

class ApiException implements Exception {
  final String message;
  final String? name;
  final String? type;
  final int? code;
  final DataApiException? data;
  final StackTrace? apiStacktrace;

  /// Creates a new ApiException with an optional error detail.
  /// Param: Code is http response code
  /// Param: Name is error name
  /// Param: Type is error type
  /// Param: Message is message
  ApiException({
    required this.message,
    this.code,
    this.name,
    this.type,
    this.data,
    this.apiStacktrace,
  });

  factory ApiException.fromMap(Map<dynamic, dynamic> data) {
    DataApiException? dataApiException;
    if (data['data'] != null) {
      dataApiException = DataApiException.fromMap(data['data']);
    }
    return ApiException(
      message: data['message'],
      code: data['code'],
      name: data['name'],
      type: data['type'],
      apiStacktrace: data['stacktrace'],
      data: dataApiException,
    );
  }

  @override
  String toString() => 'ApiException: $code ($type): $name -> $message (${data?.description})';

  ApiExceptionType? get exceptionType => ApiExceptionType.from(type ?? 'unknownError');
}
