class SaveRecentSearchResultParam {
  String type;
  String value;

  SaveRecentSearchResultParam({
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
