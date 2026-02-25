enum ContactType {
  normal,
  official;

  String get value {
    switch (this) {
      case ContactType.normal:
        return 'NORMAL';
      case ContactType.official:
        return 'OFFICIAL';
    }
  }

  static ContactType from(String val) {
    switch (val) {
      case 'NORMAL':
        return ContactType.normal;
      case 'OFFICIAL':
        return ContactType.official;
      default:
        return ContactType.normal;
    }
  }
}
