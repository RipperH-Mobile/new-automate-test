import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';
import 'package:uchat/features/album/data/models/models/album_image_model.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/controller/media_viewer_controller.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/screen/mobile/media_viewer_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

class MediaViewerService {
  final _log = useLogger();
  static final MediaViewerService instance = MediaViewerService.internal();

  factory MediaViewerService() => instance;

  MediaViewerService.internal();

  /// Open media viewer screen
  /// - [initialMedia] the initial media to show
  /// - [medias] the list of media to show
  /// - [imageIndexOfGroup] the index of image in group for [MessageCollection]
  /// - [sorting] the sorting of media, 1 for ascending, -1 for descending
  Future<void> openMediaViewer<T>({
    required T initialMedia,
    required List<T> medias,
    required MediaViewerOpenFrom openFrom,
    int imageIndexOfGroup = 0,
    int sorting = -1,
    Future<List<MediaFileModel>> Function()? onFetchMoreMedias,
    String? albumId,
    bool isSecretRoom = false,
    bool isBookmark = false,
    bool showMediaListAndInfo = true,
  }) async {
    try {
      MediaFileModel? initialMediaFile;
      List<MediaFileModel>? mediaFiles;

      int initialMediaIndex = 0;

      if (initialMedia is MessageCollection && medias is List<MessageCollection>) {
        // Cast medias to the specific type after is-check
        final incomingMedias = medias as List<MessageCollection>;

        final files = <MediaFileModel>[];
        for (final messageCollection in incomingMedias) {
          final messageSeq = messageCollection.sequence;
          if (messageSeq == null) {
            continue;
          }

          final messageFiles = messageCollection.files
              ?.map(
                (e) => MediaFileModel.fromMessageFileModel(e, messageSeq: messageSeq),
              )
              .toList();
          if (messageFiles != null) {
            files.addAll(messageFiles);
          }
        }

        initialMediaFile = MediaFileModel.fromMessageFileModel(
          initialMedia.files![imageIndexOfGroup],
          messageSeq: initialMedia.sequence!,
        );
        mediaFiles = files;

        initialMediaIndex = mediaFiles.indexOf(initialMediaFile);
        if (initialMediaIndex == -1) {
          initialMediaIndex = incomingMedias.length - 1;
          initialMediaFile = mediaFiles[initialMediaIndex];
        }
      } else if (initialMedia is RoomFileCollection && medias is List<RoomFileCollection>) {
        final incomingMedias = medias as List<RoomFileCollection>;
        try {
          initialMediaFile = MediaFileModel.fromRoomFileCollection(initialMedia);

          mediaFiles = incomingMedias.map((e) => MediaFileModel.fromRoomFileCollection(e)).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from RoomFileCollection to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is RoomFileEntity && medias is List<RoomFileEntity>) {
        final incomingMedias = medias as List<RoomFileEntity>;
        try {
          initialMediaFile = MediaFileModel.fromRoomFileEntity(initialMedia);

          mediaFiles = incomingMedias.map((e) => MediaFileModel.fromRoomFileEntity(e)).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from RoomFileEntity to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is RoomContactModel && medias is List<RoomContactModel>) {
        final incomingMedias = medias as List<RoomContactModel>;
        try {
          initialMediaFile = MediaFileModel.fromRoomContactModel(initialMedia);
          mediaFiles = incomingMedias.map((e) => MediaFileModel.fromRoomContactModel(e)).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from RoomContactModel to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is AlbumImageModel && medias is List<AlbumImageModel> && albumId != null) {
        final incomingMedias = medias as List<AlbumImageModel>;
        final album = await GetIt.I<AlbumDb>().getAlbum(id: albumId);
        if (album == null || album.roomId == null) {
          return;
        }

        try {
          initialMediaFile = MediaFileModel.fromAlbumImageModel(
            initialMedia,
            albumId: albumId,
            albumName: album.albumName ?? 'UNKNOWN'.tr,
            roomId: album.roomId!,
          );

          mediaFiles = incomingMedias.map((e) {
            return MediaFileModel.fromAlbumImageModel(
              e,
              albumId: albumId,
              albumName: album.albumName ?? 'UNKNOWN'.tr,
              roomId: album.roomId!,
            );
          }).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from AlbumImageModel to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is AlbumImageCollection && medias is List<AlbumImageCollection> && albumId != null) {
        final incomingMedias = medias as List<AlbumImageCollection>;
        final album = await GetIt.I<AlbumDb>().getAlbum(id: albumId);
        if (album == null || album.roomId == null) {
          return;
        }

        try {
          initialMediaFile = MediaFileModel.fromAlbumImageCollection(
            initialMedia,
            albumId: albumId,
            albumName: album.albumName ?? 'UNKNOWN'.tr,
            roomId: album.roomId!,
          );

          mediaFiles = incomingMedias.map((e) {
            return MediaFileModel.fromAlbumImageCollection(
              e,
              albumId: albumId,
              albumName: album.albumName ?? 'UNKNOWN'.tr,
              roomId: album.roomId!,
            );
          }).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from AlbumImageCollection to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is AlbumImageEntity && medias is List<AlbumImageEntity> && albumId != null) {
        final incomingMedias = medias as List<AlbumImageEntity>;
        final album = await GetIt.I<AlbumDb>().getAlbum(id: albumId);
        if (album == null || album.roomId == null) {
          return;
        }

        try {
          initialMediaFile = MediaFileModel.fromAlbumImageEntity(
            initialMedia,
            albumId: albumId,
            albumName: album.albumName ?? 'UNKNOWN'.tr,
            roomId: album.roomId!,
          );

          mediaFiles = incomingMedias.map((e) {
            return MediaFileModel.fromAlbumImageEntity(
              e,
              albumId: albumId,
              albumName: album.albumName ?? 'UNKNOWN'.tr,
              roomId: album.roomId!,
            );
          }).toList();
        } catch (error, stackTrace) {
          _log.w('Error on convert from AlbumImageCollection to MediaFileModel:', error, stackTrace);
        }
      } else if (initialMedia is MessageFileModel && medias is List<MessageFileModel>) {
        final incomingMedias = medias as List<MessageFileModel>;
        try {
          int messageSeq = int.tryParse(initialMedia.sequence ?? '', radix: 16) ?? 0;

          initialMediaFile = MediaFileModel.fromMessageFileModel(
            initialMedia,
            messageSeq: messageSeq,
          );

          mediaFiles = incomingMedias.map((e) {
            return MediaFileModel.fromMessageFileModel(e, messageSeq: messageSeq);
          }).toList();

          initialMediaIndex = mediaFiles.indexOf(initialMediaFile);
          if (initialMediaIndex == -1) {
            initialMediaIndex = mediaFiles.length - 1;
            initialMediaFile = mediaFiles[initialMediaIndex];
          }
        } catch (error, stackTrace) {
          _log.w('Error converting MessageFileModel to MediaFileModel:', error, stackTrace);
          return;
        }
      } else {
        // Handle any other cases
        _log.w('Unsupported media type for openMediaViewer');
        return;
      }

      if (initialMediaFile == null || mediaFiles == null) {
        return;
      }

      if (UChatScreenUtil.instance.isMobilePlatform) {
        await Get.to(
          () => GetBuilder<MediaViewerController>(
            init: MediaViewerController(
              initialMediaIndex: initialMediaIndex,
              initialMedia: initialMediaFile!,
              medias: mediaFiles!,
              openFrom: openFrom,
              isSecretRoom: isSecretRoom,
              isBookmark: isBookmark,
              onFetchMore: onFetchMoreMedias,
            ),
            didChangeDependencies: (stat) {
              final int? index = stat.controller?.medias.indexOf(stat.controller!.initialMedia);
              if (index != null) {
                stat.controller?.preloadMedia(index - 1);
                stat.controller?.preloadMedia(index + 1);
              }
            },
            builder: (ctl) {
              return MediaViewerScreen(
                showMediaListAndInfo: showMediaListAndInfo,
              );
            },
          ),
          fullscreenDialog: true,
          transition: Transition.fadeIn,
          opaque: false,
          // Added transition duration as fast as possible.
          // To fix controller not found bug, when tap to reopen while dialog is closing.
          duration: const Duration(milliseconds: 200),
        );
      } else {
        Widget Function(bool Function()?) child = (f) => MediaViewerScreen(fullScreenToggle: f);

        await UChatDialog.showCustomDialog<void, MediaViewerController>(
          child: child,
          bgDialogColor: Colors.transparent,
          init: MediaViewerController(
            initialMediaIndex: initialMediaIndex,
            initialMedia: initialMediaFile,
            medias: mediaFiles,
            openFrom: openFrom,
            isSecretRoom: isSecretRoom,
            isBookmark: isBookmark,
          ),
          didChangeDependencies: (stat) {
            final int? index = stat.controller?.medias.indexOf(stat.controller!.initialMedia);
            if (index != null) {
              stat.controller?.preloadMedia(index - 1);
              stat.controller?.preloadMedia(index + 1);
            }
          },
          cDialogWidth: 4000.spMin,
          cDialogHeight: 4000.spMin,
          cDialogPadding: EdgeInsets.symmetric(
            horizontal: 100.spMin,
            vertical: 68.spMin,
          ),
        );
      }
    } catch (e, stacktrace) {
      _log.e('Error on openMediaViewer:', e, stacktrace);
    }
  }

  Future<void> openGiphyViewer(
    MessageCollection giphyMessage, {
    bool isBookmark = false,
    bool isSecretRoom = false,
  }) async {
    final initialMedia = MediaFileModel.fromGiphyMessage(
      giphyMessage,
    );

    if (UChatScreenUtil.instance.isMobilePlatform) {
      await Get.dialog(
        GetBuilder<MediaViewerController>(
          init: MediaViewerController(
            initialMediaIndex: 0,
            initialMedia: initialMedia,
            medias: [initialMedia],
            openFrom: MediaViewerOpenFrom.roomMessage,
            isSecretRoom: isSecretRoom,
            isBookmark: isBookmark,
          ),
          builder: (ctl) {
            return const MediaViewerScreen();
          },
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    } else {
      await UChatDialog.showCustomDialog<void, MediaViewerController>(
        child: (_) => const MediaViewerScreen(),
        bgDialogColor: Colors.transparent,
        init: MediaViewerController(
          initialMediaIndex: 0,
          initialMedia: initialMedia,
          medias: [initialMedia],
          openFrom: MediaViewerOpenFrom.roomMessage,
          isSecretRoom: isSecretRoom,
          isBookmark: isBookmark,
        ),
      );
    }
  }

  Future<void> onAppInActive() async {
    if (Get.isRegistered<MediaViewerController>()) {
      MediaViewerController mediaViewerCtl = Get.find<MediaViewerController>();

      // Pause video if the current media is video and is playing
      if (mediaViewerCtl.currentMediaFile.value.isVideo) {
        final videoController = mediaViewerCtl.currentVideoPreviewerCtl;
        if (videoController != null) {
          await videoController.onAppInactive();
        }
      }
    }
  }

  Future<void> onAppResumed() async {
    if (Get.isRegistered<MediaViewerController>()) {
      MediaViewerController mediaViewerCtl = Get.find<MediaViewerController>();

      // Resume video if the current media is video and is playing
      if (mediaViewerCtl.currentMediaFile.value.isVideo) {
        final videoController = mediaViewerCtl.currentVideoPreviewerCtl;
        if (videoController != null) {
          await videoController.onAppResume();
        }
      }
    }
  }

  String generateMediaHeroTag({required MediaViewerOpenFrom openFrom, required String heroTag}) {
    return heroTag;
  }
}
