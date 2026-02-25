import 'package:uchat/api/api.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';
import 'package:uchat/features/album/data/models/requests/cancel_album_upload_request.dart';
import 'package:uchat/features/album/data/models/requests/create_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_response.dart';
import 'package:uchat/features/album/data/models/requests/fetch_albums_request.dart';
import 'package:uchat/features/album/data/models/requests/fetch_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/rename_album_request.dart';
import 'package:uchat/features/album/data/models/requests/share_image_from_album_request.dart';

class AlbumSocketService {
  AlbumSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<AlbumCollection?> createAlbum(CreateAlbumRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.createAlbumV3.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<AlbumCollection>(
      (data) => AlbumCollection.fromJson(data['data']),
    );
  }

  Future<void> renameAlbum(RenameAlbumRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.updateAlbumNameV3.socket,
      request.toJson(),
    );
  }

  Future<void> deleteAlbum(DeleteAlbumRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteAlbumV3.socket,
      request.toJson(),
    );
  }

  Future<void> cancelAlbumUpload(CancelAlbumUploadRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.cancelUploadAlbumImageV3.socket,
      request.toJson(),
    );
  }

  Future<DeleteImagesInAlbumResponse?> deleteImagesInAlbum(DeleteImagesInAlbumRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.deleteImageInAlbumV3.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => DeleteImagesInAlbumResponse.fromJson(data['data']),
    );
  }

  Future<PaginationPayload<AlbumImageCollection>?> fetchImagesInAlbums(FetchImagesInAlbumRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.fetchImagesInAlbumV3.socket,
      request.toJson(),
    );

    // Set album id from app side because server doesn't sent album id data with the image data.
    return socketResp.mapToResponse((e) {
      return PaginationPayload<AlbumImageCollection>.fromMapV3(
        e,
        listMapper: (data) {
          List<AlbumImageCollection> dataList = [];
          for (final item in data) {
            dataList.add(AlbumImageCollection.fromJson(item, albumId: request.albumId));
          }
          return dataList;
        },
      );
    });
  }

  Future<PaginationPayload<AlbumCollection>?> fetchAlbums(FetchAlbumsRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.fetchAlbumsV3.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<AlbumCollection>.fromMapV3(
        e,
        listMapper: (data) {
          List<AlbumCollection> dataList = [];
          for (final item in data) {
            dataList.add(AlbumCollection.fromJson(item));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> shareImageFromAlbum(ShareImageFromAlbumRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.shareImageFromAlbum.socket,
      request.toJson(),
    );
  }
}
