import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_all_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_photo_and_video_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/params/fetch_room_detail_media_count_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_photos_and_videos_in_room_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_media_argument.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

// TODO: [ ] Implement remove media from chat room (remove message and file)
// TODO: [ ] Implement add new media to chat room (add message and file)

///
/// * Behaviour *
/// ---------------------------------
/// 1. **First visit** – load everything cached, then download the first page
///    until we have at least [pageSize] items, cache that page, build the UI.
/// 2. **Scrolling** – every time the user reaches the bottom, download the
///    next page, cache it, append only the *new* rows in‑memory.
/// 3. **Later visits** – read the full cache first so the grid feels instant;
///    only hit the network when the user reaches the end of cached data.
class ChatRoomDetailMediaController extends GetxController {
  final _log = useLogger();

  final String tag;

  ChatRoomDetailMediaController({required this.tag});

  String? roomId;
  final scrollController = ScrollController();
  final scrollTriggerPercentage = 0.8;

  /// in‑memory index → keeps the richest copy of every file
  final mediaMap = <String, RoomFileEntity>{}.obs;
  final mediaList = <RoomFileEntity>[].obs;
  final photoCount = 0.obs;
  final videoCount = 0.obs;
  final isLoadingMore = false.obs;
  final isEndOfList = false.obs;
  final isInitializing = true.obs;

  StreamSubscription? _newMessageSubscription;
  StreamSubscription? _updateMessageSubscription;

  static const int pageSize = 40;

  /* ============================== LIFECYCLE ============================== */
  @override
  Future<void> onInit() async {
    if (Get.arguments is ChatRoomDetailMediaArgument) {
      final args = Get.arguments as ChatRoomDetailMediaArgument;

      roomId = args.roomId;
      if (args.initPhotoCount != null && args.initVideoCount != null) {
        photoCount.value = args.initPhotoCount!;
        videoCount.value = args.initVideoCount!;
      } else {
        final response =
            await GetIt.I<FetchRoomDetailMediaCountUseCase>().call(FetchRoomDetailMediaCountParams(roomId: roomId!));
        photoCount.value = response?.countOfImage ?? 0;
        videoCount.value = response?.countOfVideo ?? 0;
      }
    }

    scrollController.addListener(positionListener);
    await fetchInitMedias();

    if (mediaMap.isEmpty) {
      for (var element in mediaList) {
        mediaMap[element.id!] = element;
      }
    }

    _updateMessageSubscription = eventBus.on<MessageUpdateEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        if ([
              MessageType.remove,
              MessageType.removeOthers,
              MessageType.system,
            ].contains(event.message.type) &&
            event.message.isSent == true) {
          EasyDebounce.debounce(
            'room_detail_${roomId}_media_list',
            const Duration(milliseconds: 500),
            () async {
              final removedRoomFileIds =
                  mediaList.where((e) => e.messageId == event.message.id).map((e) => e.roomFileId).toSet();

              for (final id in removedRoomFileIds) {
                mediaMap.removeWhere((key, value) => value.roomFileId == id);
              }
              mediaList.removeWhere((e) => removedRoomFileIds.contains(e.roomFileId));
            },
          );
        } else if ([
              MessageType.image,
              MessageType.video,
            ].contains(event.message.type) &&
            event.message.isSent == true) {
          final removedFileList = mediaList.where((e) => e.messageId == event.message.id).toList();
          final remainingFile = event.message.files?.map((e) => e.toEntity()).toList();
          if (remainingFile == null) return;
          for (final file in remainingFile) {
            removedFileList.removeWhere((e) => e.roomFileId == file.roomFileId);
          }
          for (final file in removedFileList) {
            mediaMap.removeWhere((key, value) => value.roomFileId == file.roomFileId);
            mediaList.removeWhere((e) => e.roomFileId == file.roomFileId);
          }
        }
      }
    });

    _newMessageSubscription = eventBus.on<MessageNewEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        if ([MessageType.image, MessageType.video, MessageType.file].contains(event.message.type)) {
          EasyDebounce.debounce(
            'room_detail_${roomId}_media_list',
            const Duration(milliseconds: 500),
            () async {
              final serverMedias = await fetchServerMedias(afterId: mediaList.firstOrNull?.roomFileId);
              await _saveToDb(serverMedias);

              addMediaFromServerToList(serverMedias);
            },
          );
        }
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(positionListener);
    _newMessageSubscription?.cancel();
    _updateMessageSubscription?.cancel();
    super.onClose();
  }

  /* ============================== PAGINATION ============================ */
  void positionListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * scrollTriggerPercentage &&
        !isLoadingMore.value &&
        !isEndOfList.value) {
      fetchMoreMedias();
    }
  }

  /* ============================== HELPERS =============================== */

  /// returns the whole cache
  Future<List<RoomFileEntity>> getLocalMedias() async {
    try {
      final mediaFromLocal = await GetIt.I<GetPhotosAndVideosInRoomUseCase>().call(
        GetPhotosAndVideosInRoomParams(
          roomId: roomId!,
          page: 1,
          pageSize: 1 << 20, // 1 048 576 → "effectively all medias"
        ),
      );
      return mediaFromLocal?.data?.toList() ?? [];
    } catch (e, stackTrace) {
      _log.e('getLocalMedias error.', e, stackTrace);
      return [];
    }
  }

  Future<List<RoomFileEntity>> fetchServerMedias({String? beforeId, String? afterId}) async {
    try {
      final mediaFromServer = await GetIt.I<FetchRoomPhotoAndVideoUseCase>().call(
        RoomPhotoAndVideoRequest(
          roomId: roomId!,
          beforeRoomFileId: beforeId,
          afterRoomFileId: afterId,
        ),
      );
      return mediaFromServer ?? [];
    } catch (e, stackTrace) {
      _log.e('fetchServerMedias error.', e, stackTrace);
      return [];
    }
  }

  Future<void> _saveToDb(List<RoomFileEntity> list) async {
    if (list.isEmpty) return;
    await GetIt.I<PutAllRoomFileUseCase>().call(
      PutAllRoomFileRequest(
        roomFiles: list.map(RoomFileCollection.fromEntity).toList(),
      ),
    );
  }

  void _rebuildList() {
    mediaList
      ..assignAll(mediaMap.values)
      ..sort((a, b) => b.file.createdAt!.compareTo(a.file.createdAt!));
  }

  /* ============================= INITIAL LOAD ============================ */
  Future<void> fetchInitMedias() async {
    try {
      // read everything cached
      final cached = await getLocalMedias();
      for (final element in cached) {
        mediaMap[element.id!] = element;
      }

      // if cache smaller than one page → get first page from server
      if (mediaMap.length < pageSize) {
        final firstPage = await fetchServerMedias();
        await _saveToDb(firstPage);
        for (final element in firstPage) {
          mediaMap.putIfAbsent(element.id!, () => element);
        }
      }

      _rebuildList();
      isInitializing.value = false;

      if (mediaList.length < pageSize) {
        fetchMoreMedias();
      }
    } catch (e, stackTrace) {
      _log.e('fetchInitMedias', e, stackTrace);
      isInitializing.value = false;
    }
  }

  Future<void> fetchMoreMedias() async {
    if (isLoadingMore.value || isEndOfList.value) return;
    isLoadingMore.value = true;

    try {
      final lastMedia = mediaList.last;
      final roomFileId = lastMedia.roomFileId;
      _log.d('===> fetchMoreMedias-messageSeq: ${mediaList.last.roomFileId} - $roomFileId');
      if (roomFileId == null) {
        isEndOfList.value = true;
        return;
      }

      final serverMedias = await fetchServerMedias(
        beforeId: roomFileId,
      );

      _log.d('===> fetchMoreMedias from server: ${serverMedias.length}');

      if (serverMedias.isEmpty) {
        isEndOfList.value = true;
        return;
      }

      await _saveToDb(serverMedias);

      addMediaFromServerToList(serverMedias);
    } catch (e, stackTrace) {
      _log.e('fetchMoreMedias error', e, stackTrace);
    } finally {
      isLoadingMore.value = false;
    }
  }

  void addMediaFromServerToList(List<RoomFileEntity> serverMedias) {
    /// `serverMedias` is the page we just downloaded.
    /// We want to add ONLY the files that are NOT yet in our in-memory map
    int added = 0; // counter for *new* rows
    for (final element in serverMedias) {
      // Skip duplicates: if the map already contains this file id,
      // we fetched a page we had cached before or it overlapped with
      // the previous page. No need to overwrite or refresh the UI.
      if (mediaMap[element.id!] == null) {
        mediaMap[element.id!] = element; // insert new file
        added++; // track newcomers
      }
    }

    // Only rebuild the reactive `mediaList` (and thus trigger a UI update)
    // if at least one genuinely new item was inserted above.
    // This avoids an unnecessary re-render when the page contained only
    // duplicates and also lets us detect “end of list” if `added == 0`.
    if (added > 0) _rebuildList();
  }

  /* ============================== MEDIA VIEWER ========================== */
  void openMedia(RoomFileEntity file) {
    MediaViewerService.instance.openMediaViewer<RoomFileEntity>(
      initialMedia: file,
      medias: mediaList(),
      openFrom: MediaViewerOpenFrom.roomDetail,
    );
  }

  void updateMediaCounts({int? photoCount, int? videoCount}) {
    if (photoCount != null) {
      this.photoCount.value = photoCount;
    }
    if (videoCount != null) {
      this.videoCount.value = videoCount;
    }
  }
}
