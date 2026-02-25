/// Event to hide/show target sticker during animation
class StickerAnimationEvent {
  final String messageId;
  final String packId;
  final String fileId;
  final bool hidden;

  StickerAnimationEvent({
    required this.messageId,
    required this.packId,
    required this.fileId,
    required this.hidden,
  });
}
