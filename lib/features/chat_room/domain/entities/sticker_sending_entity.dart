class StickerSendingEntity {
  String stickerPackId;
  String stickerId;

  StickerSendingEntity({
    required this.stickerPackId,
    required this.stickerId,
  });

  @override
  bool operator ==(Object other) {
    return other is StickerSendingEntity && stickerPackId == other.stickerPackId && stickerId == other.stickerId;
  }

  @override
  int get hashCode => (stickerPackId + stickerId).hashCode;
}
