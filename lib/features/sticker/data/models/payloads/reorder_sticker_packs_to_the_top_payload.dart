class ReorderStickerPacksToTheTopRequest {
  final List<String> downloadedStickerIds;

  const ReorderStickerPacksToTheTopRequest({
    required this.downloadedStickerIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'downloadedStickerIds': downloadedStickerIds,
    };
  }
}
