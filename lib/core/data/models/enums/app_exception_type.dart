enum AppExceptionType {
  multipleAccountLimitExceed;

  String get value {
    switch (this) {
      case AppExceptionType.multipleAccountLimitExceed:
        return 'MULTIPLE_ACCOUNT_LIMIT_EXCEED';
    }
  }

  static AppExceptionType from(String? val) {
    switch (val) {
      case 'MULTIPLE_ACCOUNT_LIMIT_EXCEED':
        return AppExceptionType.multipleAccountLimitExceed;
      default:
        throw UnimplementedError('AppExceptionType for value $val is not implemented');
    }
  }
}
