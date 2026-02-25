// ignore_for_file: public_member_api_docs, sort_constructors_first
class StickerUpdateOwnerEvent {
  String stickerPackId;
  String? fileId;

  StickerUpdateOwnerEvent({
    required this.stickerPackId,
    this.fileId,
  });

  @override
  String toString() => 'StickerUpdateOwnerEvent(stickerPackId: $stickerPackId${fileId != null ? ', fileId: $fileId' : ''})';
}
