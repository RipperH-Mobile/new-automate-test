// ignore_for_file: constant_identifier_names

import 'package:uchat/api/api.dart';

class ExceptionHandler implements Exception {
  static Exception handle(dynamic error) {
    if (error is ApiException) {
      return error;
    } else if (error is SocketIOException) {
      return error;
    } else if (error is FailedHostLookupException) {
      return error;
    } else {
      return AppException(
        message: error.toString(),
        name: 'UnknownError',
        type: 'UnknownError',
      );
    }
  }
}
