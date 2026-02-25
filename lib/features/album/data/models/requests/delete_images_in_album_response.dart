import 'package:uchat/features/album/data/models/models/album_image_model.dart';
import 'package:uchat/utils/datetime.dart';

class DeleteImagesInAlbumResponse {
  final String albumId;
  final String roomId;
  final List<AlbumImageModel> lastTenImageInAlbum;
  final int totalImages;
  final DateTime updatedAt;
  final List<String> deletedImages;

  DeleteImagesInAlbumResponse({
    required this.albumId,
    required this.roomId,
    required this.lastTenImageInAlbum,
    required this.totalImages,
    required this.updatedAt,
    required this.deletedImages,
  });

  factory DeleteImagesInAlbumResponse.fromJson(Map<String, dynamic> json) {
    return DeleteImagesInAlbumResponse(
      albumId: json['_id'],
      roomId: json['roomId'],
      lastTenImageInAlbum: (json['lastTenImageInAlbum'] as List).map((e) => AlbumImageModel.fromJson(e)).toList(),
      totalImages: json['totalImages'],
      updatedAt: strToDateTime(json['updatedAt'])!,
      deletedImages: (json['deletedImages'] as List).map((e) => e.toString()).toList(),
    );
  }
}