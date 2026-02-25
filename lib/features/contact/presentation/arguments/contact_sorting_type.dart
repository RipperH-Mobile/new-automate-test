enum ContactSortingType {
  nameASC('NAME_ASC'),
  nameDESC('NAME_DESC');

  final String value;
  const ContactSortingType(this.value);

  factory ContactSortingType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case ContactSortingType.nameASC:
        return 'NAME_ASC';
      case ContactSortingType.nameDESC:
        return 'NAME_DESC';
    }
  }
}
