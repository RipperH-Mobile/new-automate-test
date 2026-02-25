class SaveDraftMessageEntity {
  final String roomId;
  final String? message;
  final String? replyMessageId;

  const SaveDraftMessageEntity({
    required this.roomId,
    this.message,
    this.replyMessageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'message': message,
      'replyMessageId': replyMessageId,
    };
  }

  factory SaveDraftMessageEntity.fromJson(Map<String, dynamic> json) {
    return SaveDraftMessageEntity(
      roomId: json['roomId'] as String,
      message: json['message'] as String?,
      replyMessageId: json['replyMessageId'] as String?,
    );
  }

  SaveDraftMessageEntity copyWith({
    String? roomId,
    String? message,
    String? replyMessageId,
  }) {
    return SaveDraftMessageEntity(
      roomId: roomId ?? this.roomId,
      message: message ?? this.message,
      replyMessageId: replyMessageId ?? this.replyMessageId,
    );
  }
}
