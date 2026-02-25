import 'package:uchat/api/payloads/exception/data_api_exception.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';

import 'api_exception.dart';

class ValidationDataItem {
  final String type;
  final String message;

  ValidationDataItem({
    required this.type,
    required this.message,
  });

  @override
  String toString() => 'ValidationDataItem(type: $type, message: $message)';
}

class ApiValidationException implements ApiException {
  /// A message describing the format error.
  @override
  final String message;

  @override
  final int? code;

  @override
  final String? name;

  @override
  final String? type;

  @override
  final DataApiException? data;

  @override
  final StackTrace? apiStacktrace;

  final List<ValidationDataItem>? validationData;

  /// Creates a new SocketUnknownException with an optional error [message].
  ApiValidationException({
    this.message = '',
    this.code,
    this.name,
    this.type,
    this.data,
    this.validationData,
    this.apiStacktrace,
  });

  factory ApiValidationException.fromMap(Map<dynamic, dynamic> data) {
    final validationData = <ValidationDataItem>[];

    for (final vData in data['data']) {
      validationData.add(ValidationDataItem(
        type: vData['type'],
        message: vData['message'],
      ));
    }

    return ApiValidationException(
      message: data['message'],
      code: data['code'],
      name: data['name'],
      type: data['type'],
      apiStacktrace: data['stackTrace'],
      validationData: validationData,
    );
  }

  @override
  String toString() {
    final validations = validationData?.map((e) => e.toString()).join(', ') ?? '';
    return 'ApiValidationException: $code ($type): $name -> $message, validations data: $validations';
  }

  @override
  ApiExceptionType? get exceptionType => ApiExceptionType.from(type ?? 'unknownError');
}
