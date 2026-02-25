class ReadMessageRequest {
  String roomId;
  DateTime? seenMessageAt;

  ReadMessageRequest({
    required this.roomId,
    this.seenMessageAt,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
    };

    if (seenMessageAt != null) {
      json['seenMessageAt'] = seenMessageAt!.toUtc().toIso8601String();
    }

    return json;
  }

  @override
  String toString() => 'ReadMessageRequest(roomId: $roomId, seenMessageAt: $seenMessageAt)';
}
