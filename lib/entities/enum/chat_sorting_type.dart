enum ChatSortingType {
  timeLastest('TIME_LATEST'),
  timeOldest('TIME_OLDEST'),
  nameASC('NAME_ASC'),
  nameDESC('NAME_DESC'),
  unread('UNREAD');

  final String value;
  const ChatSortingType(this.value);

  factory ChatSortingType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case ChatSortingType.timeLastest:
        return 'TIME_LATEST';
      case ChatSortingType.timeOldest:
        return 'TIME_OLDEST';
      case ChatSortingType.nameASC:
        return 'NAME_ASC';
      case ChatSortingType.nameDESC:
        return 'NAME_DESC';
      case ChatSortingType.unread:
        return 'UNREAD';
    }
  }

  String get screenDisplayName {
    switch (this) {
      case ChatSortingType.timeLastest:
        return 'time lasted';
      case ChatSortingType.timeOldest:
        return 'time oldest';
      case ChatSortingType.nameASC:
        return 'name A-Z';
      case ChatSortingType.nameDESC:
        return 'name Z-A';
      case ChatSortingType.unread:
        return 'unread messages';
    }
  }
}
