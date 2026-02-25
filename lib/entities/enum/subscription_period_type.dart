enum SubscriptionPeriodType {
  none('NONE'),
  month('MONTH'),
  year('YEAR');

  final String value;
  const SubscriptionPeriodType(this.value);

  factory SubscriptionPeriodType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case SubscriptionPeriodType.none:
        return 'None';
      case SubscriptionPeriodType.month:
        return 'Month';
      case SubscriptionPeriodType.year:
        return 'Year';
    }
  }

  static from(String val) {
    switch (val) {
      case 'NONE':
        return SubscriptionPeriodType.none;
      case 'MONTH':
        return SubscriptionPeriodType.month;
      case 'YEAR':
        return SubscriptionPeriodType.year;
    }
  }
}
