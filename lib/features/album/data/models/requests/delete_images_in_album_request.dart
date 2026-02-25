import 'package:uchat/constants/uchat_constant.dart';

class DeleteImagesInAlbumRequest {
  final String albumId;

  /// Image ids that need to delete from album. There must not be more than [UChatConstant.albumDeleteImageLimit] images.
  final List<String> imageIds;

  DeleteImagesInAlbumRequest({
    required this.albumId,
    required this.imageIds,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'imageIds': imageIds
    };
  }
}
