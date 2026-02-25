class PhotoViewerDataModel {
  String? imageId;
  String? url;
  String? hero;
  String? ownerId;
  String? ownerName;
  String? messageId;
  String? giphyId;
  DateTime? createdAt;
  double? width;
  double? height;
  String? cacheKey;
  bool? isAsset;

  PhotoViewerDataModel({
    this.imageId,
    this.url,
    this.hero,
    this.ownerId,
    this.ownerName,
    this.messageId,
    this.giphyId,
    this.createdAt,
    this.width,
    this.height,
    this.cacheKey,
    this.isAsset = false,
  });
}
