class DeleteCallLogResponse {
  final int totalDeleted;
  final int code;
  final String type;
  final Map<String, dynamic> metadata;

  DeleteCallLogResponse({
    required this.totalDeleted,
    required this.code,
    required this.type,
    required this.metadata,
  });

  factory DeleteCallLogResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCallLogResponse(
      totalDeleted: json['data']['totalDeleted'] ?? 0,
      code: json['code'],
      type: json['type'],
      metadata: json['metadata'] ?? {},
    );
  }
}
