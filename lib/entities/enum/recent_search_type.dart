enum RecentSearchType {
  search,
  room;

  String get value {
    switch (this) {
      case RecentSearchType.search:
        return 'SEARCH';
      case RecentSearchType.room:
        return 'ROOM';
    }
  }

  static from(String val) {
    switch (val) {
      case 'SEARCH':
        return RecentSearchType.search;
      case 'ROOM':
        return RecentSearchType.room;
    }
  }
}
