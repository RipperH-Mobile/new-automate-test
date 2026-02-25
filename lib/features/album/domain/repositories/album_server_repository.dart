import 'package:uchat/api/api.dart';
import 'package:uchat/features/album/data/models/requests/cancel_album_upload_request.dart';
import 'package:uchat/features/album/data/models/requests/create_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_response.dart';
import 'package:uchat/features/album/data/models/requests/fetch_albums_request.dart';
import 'package:uchat/features/album/data/models/requests/fetch_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/rename_album_request.dart';
import 'package:uchat/features/album/data/models/requests/share_image_from_album_request.dart';
import 'package:uchat/features/album/data/models/requests/upload_image_to_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';

abstract class AlbumServerRepository {
  Future<AlbumEntity?> createAlbum(CreateAlbumRequest request);

  Future<AlbumImageUploadingResponse?> uploadImageIntoAlbum(UploadImageToAlbumRequest request);

  Future<void> renameAlbum(RenameAlbumRequest request);

  Future<void> deleteAlbum(DeleteAlbumRequest request);

  Future<void> cancelAlbumUpload(CancelAlbumUploadRequest request);

  Future<DeleteImagesInAlbumResponse?> deleteImagesInAlbum(DeleteImagesInAlbumRequest request);

  Future<PaginationPayload<AlbumImageEntity>?> fetchImagesInAlbums(FetchImagesInAlbumRequest request);

  Future<PaginationPayload<AlbumEntity>?> fetchAlbums(FetchAlbumsRequest request);

  Future<void> shareImageFromAlbum(ShareImageFromAlbumRequest request);
}
