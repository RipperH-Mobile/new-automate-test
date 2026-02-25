import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/create_secret_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/create_secret_room_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_chat_with_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../widgets/loading/loading.dart';

final _log = useLogger();

class CreateChatController extends GetxController {
  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();

  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();
  final scrollController = ScrollController();

  final contacts = <ContactCollection>[].obs;
  final selectedContacts = <ContactCollection>[].obs;
  final keyword = ''.obs;

  String? selectCreateType;

  CreateChatController({this.selectCreateType}) {
    selectCreateType ??= Get.parameters['selectCreate'];
  }

  @override
  void onInit() async {
    getContactsToState();

    searchController.addListener(handleSearch);

    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();

    super.onClose();
  }

  Future<void> getContactsToState() async {
    try {
      final contactEntities = await GetIt.I<GetCanChatWithContactUseCase>().call(NoParams());
      final contactResult = contactEntities.toCollections();
      contacts(contactResult);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('getContactsToState error.', e, stackTrace);
    }
  }

  Future<void> handleSearch() async {
    keyword(searchController.text.toLowerCase());
    final searchedResult = await GetIt.I<SearchCanChatWithContactUseCase>().call(keyword());
    contacts(searchedResult.toCollections());
  }

  void handleBack() {
    Get.back();
  }

  void handleSelectCheckbox(ContactCollection contact) {
    selectedContacts.clear();
    selectedContacts.add(contact);

    // For multiple select
    // bool isSelected = selectedContacts.contains(contact);
    //
    // if (isSelected) {
    //   selectedContacts.remove(contact);
    // } else {
    //   selectedContacts.add(contact);
    // }
  }

  void handleClearSearch() {
    searchController.clear();
  }

  Future<void> handleCreate() async {
    if (selectCreateType == 'Chats') {
      _createDirectChat();
    } else {
      _createSecretChat();
    }
  }

  void _createDirectChat() async {
    if (selectedContacts.length != 1) return;

    try {
      await UChatLoading.show(status: 'Loading...'.tr);

      final contact = selectedContacts.first;
      final id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contact.id ?? '');
      final room = await roomDb.getRoom(id ?? '');

      if (room != null) {
        Get.offNamedUntil(
          Routes.chatRoomDirect.replaceAll(':id', room.id!),
          (r) => r.settings.name == Routes.home,
          arguments: ChatRoomArguments(room: room),
        );
        await UChatLoading.hide();
        if (!UChatScreenUtil.instance.isMobile) {
          Get.back();
        }
        return;
      } else {
        try {
          final room = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
            OpenDirectChatRequest(friendAccountId: contact.id!),
          );

          if (room == null) {
            await UChatLoading.hide();
            return;
          }

          Get.offNamedUntil(
            Routes.chatRoomDirect.replaceAll(':id', room.id),
            (r) => r.settings.name == Routes.home,
            arguments: ChatRoomArguments(
              room: RoomCollection.fromEntity(room),
            ),
          );
          await UChatLoading.hide();
          if (!UChatScreenUtil.instance.isMobile) {
            Get.back();
          }
        } catch (e, stackTrace) {
          _log.e('Call handleCreate create direct chat.', e, stackTrace);
        }
      }
    } on StateError catch (e, stackTrace) {
      _log.e('handleCreate StateError.', e, stackTrace);

      if (e.message == 'No element') {
        ContactCollection contact = selectedContacts.first;

        RoomEntity? room = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: contact.id!),
        );
        if (room == null) {
          await UChatLoading.hide();
          return;
        }

        Get.offNamedUntil(
          Routes.chatRoomDirect.replaceAll(':id', room.id),
          (r) => r.settings.name == Routes.home,
          arguments: ChatRoomArguments(room: RoomCollection.fromEntity(room)),
        );
        if (!UChatScreenUtil.instance.isMobile) {
          Get.back();
        }
        return;
      }

      rethrow;
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleCreate error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    } finally {
      await UChatLoading.hide();
    }
  }

  void _createSecretChat() async {
    if (selectedContacts.first.id == '' || selectedContacts.first.id == null) {
      _log.e('Can not create secret room friendAccountId is empty');
      UChatDialog.showExceptionDialog(
        description: 'Create secret room failed.'.tr,
      );
      return;
    }

    try {
      await UChatLoading.show(status: 'Loading...'.tr);

      final roomEntity = await GetIt.I<CreateSecretRoomUseCase>().call(CreateSecretRoomRequest(
        friendAccountId: selectedContacts.first.id!,
      ));

      if (roomEntity != null) {
        await UChatLoading.hide();

        // Convert entity to collection for UI
        final roomCollection = roomEntity.toCollection();

        // return back to home screen then go to new room
        Get.offNamedUntil(
          Routes.chatRoomDirect.replaceAll(':id', roomEntity.id),
          (r) => r.settings.name == Routes.home,
          arguments: ChatRoomArguments(room: roomCollection),
        );

        await UChatLoading.hide();
        if (!UChatScreenUtil.instance.isMobile) {
          Get.back();
        }
      }
    } catch (e) {
      await UChatLoading.hide();
      UChatDialog.showExceptionDialog(
        description: 'Cannot create group.'.tr,
      );
    }
  }
}
