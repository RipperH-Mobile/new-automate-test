import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_to_server_params.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/search_official_account_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_official_account_contact_use_case.dart';
import 'package:uchat/utils/extension/extension_list.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ShareToUChatController extends GetxController {
  static const latestShareLimit = 5;

  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final fileList = <File>[].obs;
  final shareContent = ''.obs;
  final oaList = <ContactCollection>[].obs;
  final latestShareList = <RoomCollection>[].obs;
  final friendList = <ContactCollection>[].obs;
  final groupList = <RoomCollection>[].obs;
  final selectedList = [].obs;

  final roomSubs = <RoomSubscriptionCollection>[];

  TextEditingController captionCtl = TextEditingController();
  SearchController searchCtl = SearchController();
  ScrollController scrollCtl = ScrollController();

  @override
  void onInit() async {
    latestShareList(await searchLastestShare('', limit: latestShareLimit));
    final oaEntities = await GetIt.I<SearchOfficialAccountContactUseCase>().call(
      SearchOfficialAccountContactParams(
        keyword: '',
      ),
    );
    oaList(oaEntities.toCollections());
    final entities = await GetIt.I<SearchCanChatWithContactUseCase>().call('');
    friendList(entities.toCollections());
    groupList(await searchGroupRoom(''));

    super.onInit();
  }

  Future<List<RoomCollection>> searchLastestShare(String keyword, {int? limit}) async {
    final lastestShareRooms = roomSubDb.searchRoomLatestShareSync(keyword, limit: limit);

    final rooms = <RoomCollection>[];
    for (final roomSub in lastestShareRooms) {
      if (roomSub.roomId == null) {
        continue;
      }

      if (!roomSubs.contains(roomSub)) {
        roomSubs.add(roomSub);
      }
      final room = roomDb.getRoomSync(roomSub.roomId!);
      if (room != null) {
        rooms.add(room);
      }
    }
    return rooms;
  }

  Future<List<RoomCollection>> searchGroupRoom(String keyword) async {
    final groupRoomSubs = await roomSubDb.searchRoomTypeGroup(keyword: keyword);

    final groupRooms = <RoomCollection>[];
    for (final roomSub in groupRoomSubs) {
      if (roomSub.roomId == null) {
        continue;
      }

      if (!roomSubs.contains(roomSub)) {
        roomSubs.add(roomSub);
      }
      final room = roomDb.getRoomSync(roomSub.roomId!);
      if (room != null) {
        groupRooms.add(room);
      }
    }
    return groupRooms;
  }

  void handleSelect(dynamic data) {
    int index = -1;
    if (data is ContactCollection) {
      index = selectedList().indexWhere((element) {
        return element is ContactCollection && element.id == data.id;
      });
    } else if (data is RoomCollection) {
      index = selectedList().indexWhere((element) {
        return element is RoomCollection && element.id == data.id;
      });
    }
    if (index >= 0) {
      selectedList.removeAt(index);
    } else {
      selectedList.add(data);
    }
  }

  void onSearchChange(String value) async {
    latestShareList(await searchLastestShare(''));
    final oaEntities = await GetIt.I<SearchOfficialAccountContactUseCase>().call(
      SearchOfficialAccountContactParams(
        keyword: value,
      ),
    );
    oaList(oaEntities.toCollections());
    final entities = await GetIt.I<SearchCanChatWithContactUseCase>().call(value);
    friendList(entities.toCollections());
    groupList(await searchGroupRoom(value));
  }

  Future<void> handleShare() async {
    try {
      await UChatLoading.show(status: 'Loading...'.tr);
      for (final selected in selectedList()) {
        String? roomId;
        bool? isSecretRoom = false;
        if (selected is ContactCollection) {
          // get room from local db
          String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(selected.id ?? '');
          RoomCollection? room = await roomDb.getRoom(id ?? '');
          // if room doesn't exist, create it
          if (room == null) {
            final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
              OpenDirectChatRequest(friendAccountId: selected.id!),
            );
            if (roomEntity != null) {
              room = RoomCollection.fromEntity(roomEntity);
            }
          }
          roomId = room?.id;
          isSecretRoom = room?.isSecretRoom;
          // update latest share
          if (room != null && room.id != null && room.id!.isNotEmpty) {
            final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(room.id!);
            if (roomSub != null) {
              roomSub.latestShare = DateTime.now();
              await roomSubDb.putRoomSubscription(roomSub);
            }
          }
        } else if (selected is RoomCollection) {
          roomId = selected.id;
          isSecretRoom = selected.isSecretRoom;
          // update latest share
          final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(selected.id!);
          if (roomSub != null) {
            roomSub.latestShare = DateTime.now();
            await roomSubDb.putRoomSubscription(roomSub);
          }
        } else {
          _log.w('selected type invalid : ${selected.runtimeType}');
          continue;
        }

        if (fileList().isNotEmpty) {
          final fileInfoList = await fileList().toFileInfoList();
          final allFileAreImage = fileInfoList.every((e) => e.type == MessageFileType.image);
          if (allFileAreImage) {
            // All files are image
            // if all files are image, send all files in one message
            GetIt.I<SendFileMessageToServerUseCase>().call(
              SendFileMessageParams(
                chatRoomId: roomId!,
                files: fileInfoList,
                isSending: true,
                isLocked: false,
                isMyNote: false,
                enableUploadPro: UserController.instance.enableUploadPro,
              ),
            );
          } else {
            // File is not image
            // if file is not image, send each file separately
            for (final fileInfo in fileInfoList) {
              GetIt.I<SendFileMessageToServerUseCase>().call(
                SendFileMessageParams(
                  chatRoomId: roomId!,
                  files: [fileInfo],
                  isSending: true,
                  isLocked: false,
                  isMyNote: false,
                  enableUploadPro: UserController.instance.enableUploadPro,
                ),
              );
            }
          }
        }

        if (shareContent().isNotEmpty) {
          // share about url, text, ...
          sendMessage(shareContent(), roomId!, isSecretRoom ?? false);
        }

        if (captionCtl.text.isNotEmpty) {
          // caption of share file
          sendMessage(captionCtl.text, roomId!, isSecretRoom ?? false);
        }
      }
      await UChatLoading.hide();
      Get.back();
    } catch (e) {
      _log.e('handleShare error', e);
      await UChatLoading.hide();
    }
  }

  void sendMessage(String messageStr, String roomId, bool isSecretRoom) async {
    try {
      final currentUserId = UserController.instance.currentUser.value?.id;
      if (currentUserId == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        return;
      }
      final message = MessageCollection(message: messageStr, type: MessageType.text);
      GetIt.I<SendMessageToServerUseCase>().call(SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: isSecretRoom,
        message: message,
        accountId: currentUserId,
      ));
    } catch (e) {
      _log.e('sendMessage error', e);
      handleException(e);
    }
  }

  void reset() async {
    fileList.clear();
    shareContent('');
    selectedList.clear();
    searchCtl.clear();
    captionCtl.clear();
    latestShareList(await searchLastestShare('', limit: latestShareLimit));
    final oaEntities = await GetIt.I<SearchOfficialAccountContactUseCase>().call(
      SearchOfficialAccountContactParams(
        keyword: '',
      ),
    );
    oaList(oaEntities.toCollections());
    final entities = await GetIt.I<SearchCanChatWithContactUseCase>().call('');
    friendList(entities.toCollections());
    groupList(await searchGroupRoom(''));
  }
}
