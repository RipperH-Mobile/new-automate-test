import 'package:dio/dio.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/data/data_source/remote/album_api_service.dart';
import 'package:uchat/features/album/data/data_source/remote/album_socket_service.dart';
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
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';

class AlbumServerRepositoryImpl implements AlbumServerRepository {
  AlbumServerRepositoryImpl({
    required this.albumApiService,
    required this.albumSocketService,
    required this.socketCaller,
  });

  final AlbumApiService albumApiService;
  final AlbumSocketService albumSocketService;
  final SocketCaller socketCaller;

  final _log = useLogger();

  @override
  Future<void> cancelAlbumUpload(CancelAlbumUploadRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await albumSocketService.cancelAlbumUpload(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('cancelAlbumUpload with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await albumApiService.cancelAlbumUpload(request);
  }

  @override
  Future<AlbumEntity?> createAlbum(CreateAlbumRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await albumSocketService.createAlbum(request);

        /// Currently the created album always start with 0 image because createAlbum is called first then
        /// uploadImageIntoAlbum is called. Server doesn't sent totalImages but we can assume that it is 0 here.
        socketResp?.totalImagesV2 ??= 0;
        return socketResp?.toEntity();
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('createAlbum with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await albumApiService.createAlbum(request);

    /// Currently the created album always start with 0 image because createAlbum is called first then
    /// uploadImageIntoAlbum is called. Server doesn't sent totalImages but we can assume that it is 0 here.
    httpResp?.totalImagesV2 ??= 0;
    return httpResp?.toEntity();
  }

  @override
  Future<void> deleteAlbum(DeleteAlbumRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await albumSocketService.deleteAlbum(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('deleteAlbum with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await albumApiService.deleteAlbum(request);
  }

  @override
  Future<DeleteImagesInAlbumResponse?> deleteImagesInAlbum(DeleteImagesInAlbumRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await albumSocketService.deleteImagesInAlbum(request);
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('deleteImagesInAlbum with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await albumApiService.deleteImagesInAlbum(request);
  }

  @override
  Future<PaginationPayload<AlbumEntity>?> fetchAlbums(FetchAlbumsRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await albumSocketService.fetchAlbums(request);
        return result?.toEntity((data) => data.map((e) => e.toEntity()));
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('fetchAlbums with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await albumApiService.fetchAlbums(request);
    return result?.toEntity((data) => data.map((e) => e.toEntity()));
  }

  @override
  Future<PaginationPayload<AlbumImageEntity>?> fetchImagesInAlbums(
    FetchImagesInAlbumRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await albumSocketService.fetchImagesInAlbums(request);
        return result?.toEntity((data) => data.map((e) => e.toEntity()));
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND' || e.type != 'ERR_ALBUM_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('fetchImagesInAlbums with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await albumApiService.fetchImagesInAlbums(request);
    return result?.toEntity((data) => data.map((e) => e.toEntity()));
  }

  @override
  Future<void> renameAlbum(RenameAlbumRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await albumSocketService.renameAlbum(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('renameAlbum with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await albumApiService.renameAlbum(request);
  }

  @override
  Future<AlbumImageUploadingResponse?> uploadImageIntoAlbum(UploadImageToAlbumRequest request) async {
    try {
      return await albumApiService.uploadImageIntoAlbum(request);
    } on DioException catch (e, stackTrace) {
      // If the request is cancelled by user, do not log the error.
      // Or if error come from slow internet / no internet and upload time out, do not log the error.
      if (!(e.type == DioExceptionType.cancel || e.type == DioExceptionType.receiveTimeout)) {
        _log.e('uploadImageIntoAlbum with DioException error.', e, stackTrace);
      }
      rethrow;
    }
  }

  @override
  Future<void> shareImageFromAlbum(ShareImageFromAlbumRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await albumSocketService.shareImageFromAlbum(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('shareImageFromAlbum with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await albumApiService.shareImageFromAlbum(request);
  }
}
