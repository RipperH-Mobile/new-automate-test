class ReorderAllStickerPackRequest {
  final List<String> orderedStickerIds;

  const ReorderAllStickerPackRequest({
    required this.orderedStickerIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderedStickerIds': orderedStickerIds,
    };
  }
}
