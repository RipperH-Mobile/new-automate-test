import 'package:dio/dio.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
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
import 'package:uchat/features/album/data/models/requests/upload_image_to_album_request.dart';

class AlbumApiService {
  AlbumApiService({
    required this.httpCaller,
  });

  final HttpCaller httpCaller;

  Future<AlbumCollection?> createAlbum(CreateAlbumRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.createAlbumV3.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<AlbumCollection>(
      (data) => AlbumCollection.fromJson(data['data']),
    );
  }

  Future<AlbumImageUploadingResponse?> uploadImageIntoAlbum(
    UploadImageToAlbumRequest request,
  ) async {
    final FormData data = await request.toFormData();
    final httpResp = await httpCaller.post(
      BackendPath.uploadImageIntoAlbumV3.http.replaceAll(':albumId', request.albumId),
      data: data,
      cancelToken: request.cancelToken,
      options: Options(
        receiveTimeout: const Duration(seconds: UChatConstant.albumImageUploadTimeout),
      ),
    );

    return httpResp.mapToResponse<AlbumImageUploadingResponse>(
      (data) => AlbumImageUploadingResponse.fromMap(data['data']),
    );
  }

  Future<void> renameAlbum(RenameAlbumRequest request) async {
    await httpCaller.post(
      BackendPath.updateAlbumNameV3.http.replaceAll(':albumId', request.albumId),
      data: request.toJson(),
    );
  }

  Future<void> deleteAlbum(DeleteAlbumRequest request) async {
    await httpCaller.delete(
      BackendPath.deleteAlbumV3.http.replaceAll(':albumId', request.albumId),
      data: request.toJson(),
    );
  }

  Future<void> cancelAlbumUpload(CancelAlbumUploadRequest request) async {
    await httpCaller.delete(
      BackendPath.cancelUploadAlbumImageV3.http.replaceAll(':albumId', request.albumId),
      data: request.toJson(),
    );
  }

  Future<DeleteImagesInAlbumResponse?> deleteImagesInAlbum(DeleteImagesInAlbumRequest request) async {
    final httpResp = await httpCaller.delete(
      BackendPath.deleteImageInAlbumV3.http.replaceAll(':albumId', request.albumId),
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => DeleteImagesInAlbumResponse.fromJson(data['data']),
    );
  }

  Future<PaginationPayload<AlbumImageCollection>?> fetchImagesInAlbums(FetchImagesInAlbumRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchImagesInAlbumV3.http.replaceAll(
        ':albumId',
        request.albumId,
      ),
    );

    // Set album id from app side because server doesn't sent album id data with the image data.
    return httpResp.mapToResponse((e) {
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
    final httpResp = await httpCaller.get(
      BackendPath.fetchAlbumsV3.http.replaceAll(':roomId', request.roomId),
    );

    return httpResp.mapToResponse((e) {
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
    await httpCaller.post(
      BackendPath.shareImageFromAlbum.http,
      data: request.toJson(),
    );
  }
}
