import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/events/album_create_event.dart';
import 'package:uchat/features/album/domain/events/album_delete_event.dart';
import 'package:uchat/features/album/domain/events/album_image_deleted_event.dart';
import 'package:uchat/features/album/domain/events/album_image_update_event.dart';
import 'package:uchat/features/album/domain/events/album_update_event.dart';
import 'package:uchat/features/album/domain/params/fetch_albums_params.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_albums_use_case.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/params/toggle_pin_room_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_subscription_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_pin_room_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_response.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailController extends GetxController {
  final String tag;

  ChatRoomDetailController({
    required this.tag,
  });

  final isMuted = false.obs;
  final isPinnedChat = false.obs;

  final room = Rx<RoomCollection?>(null);
  final contact = Rx<ContactCollection?>(null);

  final roomFiles = <MessageFileModel>[].obs;
  final roomAlbums = <AlbumEntity>[].obs;
  final albumCount = 0.obs;
  final photoCount = 0.obs;
  final videoCount = 0.obs;
  final fileCount = 0.obs;
  final linkCount = 0.obs;

  StreamSubscription? _roomUpdate;
  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _albumDeleteSubscription;
  StreamSubscription? _albumNewSubscription;
  StreamSubscription? _albumUpdateSubscription;
  StreamSubscription? _albumImageUpdateSubscription;
  StreamSubscription? _albumImageDeletedSubscription;
  StreamSubscription? _newMessageSubscription;
  StreamSubscription? _updateMessageSubscription;

  /// Get section
  String get roomId {
    return room()?.id ?? tag;
  }

  RoomAccessType get accessType {
    return room()?.accessType ?? RoomAccessType.private;
  }

  UChatCallController get callCtl {
    return Get.find<UChatCallController>();
  }

  final chatListController = Get.find<ChatListController>();

  ChatRoomController? get roomCtl {
    try {
      if (Get.isRegistered<ChatRoomController>(tag: tag)) {
        return Get.find<ChatRoomController>(tag: tag);
      }

      return null;
    } catch (e, stackTrace) {
      _log.w('Get roomCtl error in RoomDetailController.', e, stackTrace);
      return null;
    }
  }

  String get title => room()?.title ?? 'Unknown'.tr;

  bool get isSystemRoom => room.value?.isSystem == true;

  @override
  void onInit() async {
    await initRoomDetailData();

    _roomUpdate = eventBus.on<RoomUpdateEvent>().listen((event) {
      if (room()?.id == event.room.id) {
        _log.d('RoomUpdate-: ${event.room.id} == ${room()!.id}');
        room.update((val) {
          if (val == null) {
            val = event.room;
          } else {
            val.update(event.room);
          }
        });
      }
    });

    _roomUpdateSubscription = eventBus.on<RoomUpdateSubscriptionEvent>().listen((event) {
      if (room()?.id == event.roomSubscription.roomId) {
        _log.d('RoomUpdateSubscription: ${event.roomSubscription.roomId} == ${room()!.id}');
        onUpdatedRoomSub(event.roomSubscription);
      }
    });

    _albumDeleteSubscription = eventBus.on<AlbumDeleteEvent>().listen((event) {
      // _log.i('AlbumUpdateEvent: ${DateTime.now()}');

      if (roomId == event.roomId) {
        roomAlbums.removeWhere((element) => element.id == event.album.id);
        getRoomDetailAlbumData();
      }
    });

    _albumNewSubscription = eventBus.on<AlbumCreateEvent>().listen((event) {
      if (roomId == event.roomId) {
        /// If album already exist, don't add it again. This is to prevent duplicate album in the list
        /// This can happen when AlbumCreateEvent is fired from use case (data from response)
        /// and state processor. This case will happen for the user that pressed create album.
        if (roomAlbums.any((e) => e.id == event.album.id)) return;
        roomAlbums.insert(0, event.album);
        if (roomAlbums.length > UChatConstant.roomDetailAlbumPreviewCount) {
          roomAlbums.removeLast();
        }
        getRoomDetailAlbumData();
      }
    });

    _albumUpdateSubscription = eventBus.on<AlbumUpdateEvent>().listen((event) {
      if (roomId == event.roomId) {
        final index = roomAlbums.indexWhere((element) => element.id == event.album.id);
        if (index >= 0) {
          roomAlbums[index] = roomAlbums[index].copyWithEntity(event.album);
        }
        roomAlbums.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      }
    });

    _albumImageUpdateSubscription = eventBus.on<AlbumImageUpdateEvent>().listen((event) {
      if (roomId == event.roomId) {
        final index = roomAlbums.indexWhere((element) => element.id == event.album.id);
        if (index >= 0) {
          roomAlbums[index] = roomAlbums[index].copyWithEntity(event.album);
        }
        roomAlbums.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      }
    });

    _albumImageDeletedSubscription = eventBus.on<AlbumImageDeletedEvent>().listen((event) {
      if (roomId == event.roomId) {
        final index = roomAlbums.indexWhere((element) => element.id == event.album.id);
        if (index >= 0) {
          roomAlbums[index] = roomAlbums[index].copyWithEntity(event.album);
        }
        roomAlbums.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      }
    });

    _updateMessageSubscription = eventBus.on<MessageUpdateEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        if ([
              MessageType.image,
              MessageType.video,
              MessageType.file,
              MessageType.remove,
              MessageType.removeOthers,
              MessageType.system,
            ].contains(event.message.type) &&
            event.message.isSent == true) {
          EasyDebounce.debounce(
            'update_message_room_detail_${roomId}_media_count',
            const Duration(milliseconds: 500),
            _updateMediaAndFileOrLinkCounts,
          );
        }
      }
    });

    _newMessageSubscription = eventBus.on<MessageNewEvent>().listen((event) {
      if (roomId == event.message.roomId) {
        final isMediaOrFile = [MessageType.image, MessageType.video, MessageType.file].contains(event.message.type);
        final hasLink = event.message.type == MessageType.text && (event.message.links ?? []).isNotEmpty;

        if (isMediaOrFile || hasLink) {
          EasyDebounce.debounce(
            'new_message_room_detail_${roomId}_media_count',
            const Duration(milliseconds: 500),
            () => _updateMediaAndFileOrLinkCounts(isUpdateLinkCount: hasLink),
          );
        }
      }
    });

    /// Toggle see more text in message type text to close.
    eventBus.fire(CloseExpandedTextEvent());

    super.onInit();
  }

  @override
  void onClose() async {
    await _roomUpdate?.cancel();
    await _roomUpdateSubscription?.cancel();
    await _albumDeleteSubscription?.cancel();
    await _albumNewSubscription?.cancel();
    await _albumUpdateSubscription?.cancel();
    await _albumImageUpdateSubscription?.cancel();
    await _albumImageDeletedSubscription?.cancel();
    await _updateMessageSubscription?.cancel();
    await _newMessageSubscription?.cancel();

    super.onClose();
  }

  Future<void> initRoomDetailData() async {
    if (roomId != 'NEW_ROOM') {
      await getRoomToState();
      getRoomSettingToState();
    }
    getRoomDetailMediaCount();
    getRoomDetailAlbumData();
  }

  Future<void> getRoomToState() async {
    final roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
    final roomData = roomEntity?.toCollection();
    if (roomData == null) {
      Get.back();
      return;
    }

    room(roomData);
  }

  void getRoomSettingToState() async {
    final roomSub = await GetIt.I<GetRoomSubscriptionUseCase>().call(ChatRoomParams(roomId: roomId));
    onUpdatedRoomSub(roomSub);
  }

  void onUpdatedRoomSub(RoomSubscriptionEntity? updatedRoomSub) async {
    final roomIsMuted = updatedRoomSub?.isMuted;
    if (roomIsMuted != null) {
      isMuted(roomIsMuted);
    }
    final roomIsPinned = updatedRoomSub?.isPinned;
    if (roomIsPinned != null) {
      isPinnedChat(roomIsPinned);
    }
  }

  /// App bar section
  Future<void> handleOpenSearch() async {
    try {
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchRoomdetails);
      Get.toNamed(Routes.roomDetailSearch.replaceAll(':id', roomId));
    } catch (e, stackTrace) {
      _log.e('Call handleOpenSearch error.', e, stackTrace);
    }
  }

  /// Toggle menu section
  void handleToggleMuteChat() async {
    if (isMuted.value) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickUnmuteRoomdetails);
    } else {
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickMuteRoomdetails);
    }
    await UChatLoading.show(status: 'Processing...'.tr);

    try {
      final response = await GetIt.I<ToggleMuteRoomUseCase>().call(ToggleMuteRoomParams(
        roomId: room()!.id!,
        isMuted: !isMuted(),
      ));
      if (response != null) {
        isMuted(response);
      }

      await UChatLoading.success(
        message: isMuted() ? 'Muted'.tr : 'Unmuted'.tr,
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleToggleMuteChat error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }

    await UChatLoading.hide();
  }

  void showDialogPinChat(BuildContext context) {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickPinchatRoomdetails);
    UChatNewDialog.showDialog(
      context: context,
      title: isPinnedChat.value == false ? 'Pin this chat?'.tr : 'Unpin this chat?'.tr,
      description: 'Pin this chat to the top of your chat list.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: isPinnedChat.value == false ? 'Pin'.tr : 'Unpin'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        handlePinRoom();
      },
    );
  }

  void handlePinRoom() async {
    try {
      final response = await GetIt.I<TogglePinRoomUseCase>().call(TogglePinRoomParams(
        roomId: roomId,
        isPinned: !isPinnedChat.value,
      ));
      if (response?.isPinned != null) {
        isPinnedChat.value = response?.isPinned ?? false;

        AppToast.showToast(
          context: Get.context!,
          message: isPinnedChat.value == true ? 'Pinned'.tr : 'Unpinned'.tr,
          icon: Assets.vectors.pin.svg(
            colorFilter: ColorFilter.mode(
              Get.context!.theme.appColors.iconLight,
              BlendMode.srcIn,
            ),
          ),
        );
      }
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_PIN_LIMIT_EXCEEDED') {
        UChatDialog.showDialogPinLimit();
      } else {
        _log.e('handlePinRoom ApiException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('handlePinRoom error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> showDialogDeleteChat() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickDeletechatRoomdetails);
    chatListController.showDialogDeleteChat(room()!, isGoBackTwoTimes: true);
  }

  Future<void> openAlbumScreen() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickAlbumRoomdetails);
    await Get.toNamed(
      Routes.roomDetailAlbumList.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAlbumListArguments(
        roomId: roomId,
      ),
    );
  }

  Future<void> openFileScreen() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickFilesRoomdetails);
    Get.toNamed(
      Routes.roomDetailFiles.replaceAll(':id', room()!.id!),
      arguments: ChatRoomDetailFilesArgument(
        roomId: roomId,
        totalFiles: fileCount.value,
      ),
    );
  }

  void openMediaScreen() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickMediaRoomdetails);
    Get.toNamed(
      Routes.roomDetailMedia.replaceAll(
        ':id',
        room()!.id!,
      ),
      arguments: ChatRoomDetailMediaArgument(
        roomId: roomId,
        initPhotoCount: photoCount.value,
        initVideoCount: videoCount.value,
      ),
    );
  }

  void openLinkScreen() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickLinksRoomdetails);
    Get.toNamed(
      Routes.roomDetailLinks.replaceAll(
        ':id',
        room()!.id!,
      ),
      arguments: ChatRoomDetailLinksArgument(
        roomId: roomId,
        totalLinks: linkCount.value,
      ),
    );
  }

  void openRoomThemeScreen() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickThemeRoomdetails);
    Get.toNamed(
      Routes.roomDetailEditTheme.replaceAll(':id', roomId),
    );
  }

  Future<FetchRoomDetailMediaCountResponse?> getRoomDetailMediaCount() async {
    try {
      final response = await GetIt.I<FetchRoomDetailMediaCountUseCase>().call(
        FetchRoomDetailMediaCountParams(roomId: roomId),
      );
      if (response != null) {
        photoCount.value = response.countOfImage;
        videoCount.value = response.countOfVideo;
        fileCount.value = response.countOfFile;
        linkCount.value = response.countOfLink;
        // TODO (improve) To use data from this response, Server need to include updatedAt in the response or server need to sort the album by updatedAt in the response.
        // roomAlbums.value = response.albumLists.map((e) => e.toEntity()).toList();
      }
      return response;
    } catch (e, stackTrace) {
      _log.e('getRoomDetailMediaCount error.', e, stackTrace);
      return null;
    }
  }

  void getRoomDetailAlbumData() async {
    try {
      final albumData = await GetIt.I<FetchAlbumsUseCase>().call(FetchAlbumsParams(roomId: roomId, pageSize: 10));
      if (albumData != null) {
        roomAlbums.value = albumData.data?.toList() ?? [];
        albumCount.value = albumData.total;
      }
    } catch (e, stackTrace) {
      _log.e('getRoomDetailAlbumData error.', e, stackTrace);
    }
  }

  void _updateMediaAndFileOrLinkCounts({bool isUpdateLinkCount = false}) async {
    final result = await getRoomDetailMediaCount();

    /// Return since [linkCount] is already updated in [getRoomDetailMediaCount()]
    if (isUpdateLinkCount) return;

    if (Get.isRegistered<ChatRoomDetailMediaController>(tag: roomId)) {
      final mediaCtl = Get.find<ChatRoomDetailMediaController>(tag: roomId);
      mediaCtl.updateMediaCounts(
        photoCount: result?.countOfImage,
        videoCount: result?.countOfVideo,
      );
    }
    if (Get.isRegistered<ChatRoomDetailFilesController>(tag: roomId)) {
      final filesCtl = Get.find<ChatRoomDetailFilesController>(tag: roomId);
      filesCtl.updateFileCount(result?.countOfFile);
    }
  }
}
