class GetMessageReactionModel {
  final String? emojiId;
  final String? fileId;
  final String? accountId;
  final String? displayName;
  final String? avatarPath;
  final DateTime? createdAt;

  GetMessageReactionModel({
    this.emojiId,
    this.fileId,
    this.accountId,
    this.displayName,
    this.avatarPath,
    this.createdAt,
  });

  /// Copy with method for immutability
  GetMessageReactionModel copyWith({
    String? emojiId,
    String? fileId,
    String? accountId,
    String? displayName,
    String? avatarPath,
    DateTime? createdAt,
  }) {
    return GetMessageReactionModel(
      emojiId: emojiId ?? this.emojiId,
      fileId: fileId ?? this.fileId,
      accountId: accountId ?? this.accountId,
      displayName: displayName ?? this.displayName,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// fromJson
  factory GetMessageReactionModel.fromJson(Map<String, dynamic> json) {
    return GetMessageReactionModel(
      emojiId: json['emojiId'] as String?,
      fileId: json['fileId'] as String?,
      accountId: json['accountId'] as String?,
      displayName: json['displayName'] as String?,
      avatarPath: json['avatarId'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }

  @override
  String toString() => 'emojiId: $emojiId, '
      'fileId: $fileId, '
      'accountId: $accountId, '
      'displayName: $displayName, '
      'avatarPath: $avatarPath)';
}
