class ReadAllRequest {
  DateTime seenMessageAt;

  ReadAllRequest({
    required this.seenMessageAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {'seenMessageAt': seenMessageAt.toUtc().toIso8601String()};
    return json;
  }
}
