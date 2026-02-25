import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/services/file_downloader_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/file_download_status.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/entities/chat_file_uploading_model.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/message_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/fetch_room_file_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_files_argument.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/date.dart';

final _log = useLogger();

class ChatRoomDetailFilesIds {
  static const String fileListView = 'chat_room_detail_files_file_list_view';
}

class ChatRoomDetailFilesController extends GetxController {
  final String tag;

  ChatRoomDetailFilesController({required this.tag});

  String roomId = '';
  final fileCount = 0.obs;
  final memberList = <RoomMemberCollection>[].obs;
  final roomFiles = <RoomFileEntity>[];
  final downloadStateList = <bool>[].obs;

  final uploadingFileMap = <String, ChatFileUploadingModel>{}.obs;
  final fileDownloaderService = FileDownloaderService.instance;

  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int totalPage = 0;
  bool isInitializing = true;
  bool isLoading = false;

  StreamSubscription? _fileDownloadStatusSubscription;
  StreamSubscription? _newMessageSubscription;
  StreamSubscription? _updateMessageSubscription;

  MessageListController get messageListCtl => Get.find<MessageListController>(tag: 'chat-room-$tag');

  @override
  void onInit() async {
    if (Get.arguments is ChatRoomDetailFilesArgument) {
      final arg = Get.arguments as ChatRoomDetailFilesArgument;
      roomId = arg.roomId;
      fileCount.value = arg.totalFiles;

      if (roomId != '') {
        _fetchRoomFiles(currentPage);
      }
    }

    _fileDownloadStatusSubscription = eventBus.on<FileDownloaderStatusEvent>().listen((event) {
      if ([
        FileDownloadStatus.waitingToStart,
        FileDownloadStatus.completed,
        FileDownloadStatus.failed,
        FileDownloadStatus.paused,
        FileDownloadStatus.canceled
      ].contains(event.status)) {
        if (event.status == FileDownloadStatus.loading || event.status == FileDownloadStatus.waitingToStart) {
          onUpdateDownloadState(event.fileId, true);
        } else if (event.status == FileDownloadStatus.completed) {
          onUpdateDownloadState(event.fileId, false);
        }
      }
    });

    _updateMessageSubscription = eventBus.on<MessageUpdateEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        if ([
              MessageType.remove,
              MessageType.removeOthers,
              MessageType.system,
            ].contains(event.message.type) &&
            event.message.isSent == true) {
          final index = roomFiles.indexWhere((e) => e.messageRef == event.message.ref);
          if (index >= 0) {
            roomFiles.removeAt(index);
            downloadStateList.removeAt(index);
            update([ChatRoomDetailFilesIds.fileListView]);
          }
        }
      }
    });

    _newMessageSubscription = eventBus.on<MessageNewEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        if (event.message.type == MessageType.file) {
          final fileEntity = event.message.file?.toEntity();
          if (fileEntity == null) return;
          final roomFileEntity = RoomFileEntity(
            file: fileEntity,
            roomId: event.message.roomId,
            messageId: event.message.id,
            messageRef: event.message.ref,
            messageSeq: event.message.sequence,
            type: RoomFileType.file,
          );
          roomFiles.insert(0, roomFileEntity);
          downloadStateList.insert(0, false);
          update([ChatRoomDetailFilesIds.fileListView]);
        }
      }
    });

    try {
      final localMembers = await GetIt.I<ChatRoomLocalRepository>().getAllMemberInRoom(roomId);
      if (localMembers != null) {
        final collections = localMembers.map((e) => RoomMemberCollection.fromEntity(e)).toList();
        memberList(collections);
      }
    } catch (e, stackTrace) {
      _log.e('get room member data error.', e, stackTrace);
    }

    scrollController.addListener(onFileListScroll);

    super.onInit();
  }

  @override
  void onClose() async {
    await _fileDownloadStatusSubscription?.cancel();
    await _newMessageSubscription?.cancel();
    await _updateMessageSubscription?.cancel();
    scrollController.removeListener(onFileListScroll);

    super.onClose();
  }

  Future<void> _fetchRoomFiles(int page) async {
    try {
      isLoading = true;
      update([ChatRoomDetailFilesIds.fileListView]);

      final response = await GetIt.I<FetchRoomFileUseCase>().call(FetchRoomFileRequest(
        roomId: roomId,
        page: page,
      ));
      if (response == null) {
        _log.w('Response from FetchRoomFileUseCase is null.');
        return;
      }

      /// Loop for add false value to [progressList]
      // ignore: unused_local_variable
      for (final data in response.data!.toList()) {
        downloadStateList.add(false);
      }

      final serverFiles = response.data?.toList();
      if (serverFiles == null) return;
      currentPage = page;
      totalPage = response.totalPages;
      if (page == 1) {
        roomFiles.clear();
      }
      roomFiles.addAll(serverFiles);
    } catch (e, stackTrace) {
      _log.e('_fetchRoomFiles error.', e, stackTrace);
    } finally {
      isInitializing = false;
      isLoading = false;
      update([ChatRoomDetailFilesIds.fileListView]);
    }
  }

  String getFileName(String name) {
    if (name.isEmpty) return 'UNKNOWN'.tr;

    final lastDotIndex = name.lastIndexOf('.');
    return lastDotIndex == -1 ? name : name.substring(0, lastDotIndex);
  }

  String getFileExtension(String name) {
    if (name.isEmpty) return 'UNKNOWN';

    final lastDotIndex = name.lastIndexOf('.');
    if (lastDotIndex == -1 || lastDotIndex == name.length - 1) {
      return 'UNKNOWN';
    }

    return name.substring(lastDotIndex + 1);
  }

  String getFileSizeDescription(int fileSize) {
    if (fileSize == 0) return '0 KB'.tr;

    return FileService.instance.fileSizeStr(fileSize, 0);
  }

  String getFileExtensionFileSizeAndSentDate(MessageFileEntity? file) {
    if (file == null) return 'UNKNOWN'.tr;

    final fileExtension = getFileExtension(file.name ?? '').toUpperCase();
    final fileSize = getFileSizeDescription(file.size ?? 0);
    final sentDate = (file.createdAt ?? DateTime.now()).toLocal().format('LLL d, y HH:mm');

    return '@type File • $fileSize • $sentDate'.trParams({'type': fileExtension});
  }

  String getSenderName(String id) {
    if (id.isEmpty) return 'UNKNOWN'.tr;

    final sender = memberList.where((e) => e.accountId == id).firstOrNull;
    return sender?.account?.name ?? 'UNKNOWN'.tr;
  }

  Future<void> handleOpenFile(MessageFileEntity? file, int index) async {
    if (file == null) return;

    await messageListCtl.handleTapFile(MessageFileModel.fromEntity(file));
  }

  void onUpdateDownloadState(String fileId, bool isDownloading) {
    final index = roomFiles.indexWhere((e) => e.file.id == fileId);

    if (index != -1) {
      downloadStateList[index] = isDownloading;
      downloadStateList.refresh();
    }
  }

  void updateFileCount(int? fileCount) {
    if (fileCount != null) {
      this.fileCount.value = fileCount;
    }
  }

  Future<void> onFileListScroll() async {
    final currentPixel = scrollController.position.pixels;
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    final hasMore = currentPage < totalPage;
    if (shouldLoadMore && hasMore && !isLoading) {
      EasyThrottle.throttle(
        'fetch-more-files-$roomId',
        const Duration(milliseconds: 500),
        () async {
          await _fetchRoomFiles(currentPage + 1);
        },
      );
    }
  }
}
