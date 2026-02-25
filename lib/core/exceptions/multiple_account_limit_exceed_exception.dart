import 'package:uchat/api/api.dart';
import 'package:uchat/core/data/models/enums/app_exception_type.dart';

class MultipleAccountLimitExceedException extends AppException {
  MultipleAccountLimitExceedException({required super.message, super.name});

  @override
  String get type => AppExceptionType.multipleAccountLimitExceed.value;

  @override
  String toString() {
    return 'MultipleAccountLimitExceedException: $message, name: $name, type: $type';
  }
}
