enum PayStoreType {
  apple('APPLE'),
  google('GOOGLE');

  final String value;
  const PayStoreType(this.value);

  factory PayStoreType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case PayStoreType.apple:
        return 'Apple';
      case PayStoreType.google:
        return 'Google';
    }
  }

  static from(String val) {
    switch (val) {
      case 'APPLE':
        return PayStoreType.apple;
      case 'GOOGLE':
        return PayStoreType.google;
    }
  }
}
