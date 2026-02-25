class LastEmojiEntity {
  final String? emojiId;
  final String? fileId;
  final int? amount;
  final Set<String>? accountIds;
  final DateTime? updatedAt;

  const LastEmojiEntity({
    this.emojiId,
    this.fileId,
    this.amount,
    this.accountIds,
    this.updatedAt,
  });

  /// Copy with method for immutability
  LastEmojiEntity copyWith({
    String? emojiId,
    String? fileId,
    int? amount,
    Set<String>? accountIds,
    DateTime? updatedAt,
  }) {
    return LastEmojiEntity(
      emojiId: emojiId ?? this.emojiId,
      fileId: fileId ?? this.fileId,
      amount: amount ?? this.amount,
      accountIds: accountIds ?? this.accountIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LastEmojiEntity &&
        other.emojiId == emojiId &&
        other.fileId == fileId &&
        other.amount == amount &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return emojiId.hashCode ^ fileId.hashCode ^ amount.hashCode ^ updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'LastEmojiEntity(emojiId: $emojiId, fileId: $fileId, amount: $amount, accountIds: $accountIds, updatedAt: $updatedAt)';
  }
}
