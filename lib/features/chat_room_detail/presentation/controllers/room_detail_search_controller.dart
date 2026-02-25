import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:uchat/api/payloads.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/routes/app_pages.dart';

final _log = useLogger();

class RoomDetailSearchController extends GetxController {
  final String roomId;

  RoomDetailSearchController({required this.roomId});

  final messageService = MessageService();
  final messageDb = GetIt.I<MessageDb>();
  final isLoading = false.obs;
  final searchTextController = TextEditingController().obs;
  final searchText = ''.obs;
  final searchNotFound = true.obs;

  final PagingController<int, MessageCollection> pagingController = PagingController(firstPageKey: 0);

  MessageListController get messageListCtl {
    return Get.find<MessageListController>(tag: 'chat-room-$roomId');
  }

  MessageLocalRepository get messageLocalRepository => GetIt.I<MessageLocalRepository>();

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchTextController.value.dispose();
    super.onClose();
  }

  /// Get room messages controller
  /// [return] room messages controller
  /// [return] null if not found
  ChatRoomController? get roomCtl {
    try {
      return Get.find<ChatRoomController>(tag: roomId);
    } catch (e, stackTrace) {
      _log.w('Get roomCtl error in RoomDetailController.', e, stackTrace);
      return null;
    }
  }

  /// Get contact from room
  /// [id] is the contact id
  /// [return] contact model
  /// [return] null if not found
  ContactModel? getContact(String id) {
    try {
      // Get contact from room members
      final member = roomCtl?.members.firstWhereOrNull((element) => element.accountId == id);

      return member?.account;
    } catch (e, stackTrace) {
      _log.e('Get contact error', e, stackTrace);
    }
    return null;
  }

  Future<void> handleSearch() async {
    EasyDebounce.debounce(
      'roomMessageSearch',
      const Duration(
        milliseconds: 500,
      ),
      () {
        searchNotFound(false);
        searchText.value = searchTextController.value.text;
        if (searchText.value.length == 1) {
          GetIt.I<TaxonomyService>().sendEvent(EventName.searchingRoomdetails);
        }
        pagingController.refresh();
      },
    );
  }

  void clearSearch() {
    searchText.value = '';
    searchTextController.value.text = '';
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (searchTextController.value.text.trim().isEmpty) {
      return;
    }
    try {
      String searchText = searchTextController.value.text;
      List<MessageCollection> localResult = [];
      try {
        final response = await messageLocalRepository.searchMessageInRoom(
          roomId: roomId,
          keyword: searchText,
          page: pageKey + 1,
          pageSize: UChatConstant.pageSizeInSearchMessageRoomDetail,
        );

        localResult = (response.data ?? []).map((e) => e.toCollection()).toList();

        final isLastPage = (pageKey + 1) >= response.totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(localResult);
        } else {
          pagingController.appendPage(localResult, pageKey + 1);
        }
      } catch (e, stackTrace) {
        _log.e('Local search error', e, stackTrace);
      }
      Map<String, MessageCollection> idToMessage = {};
      // Process local results first
      for (final message in localResult) {
        final displayMessage = message.message?.displayMarkUp(getDisplay: true);
        if (displayMessage != null) {
          if (!displayMessage.contains(searchText)) {
            continue;
          }
        }
        idToMessage[message.id!] = message; // Local results added first
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void handleJumpToMessage({
    required MessageCollection messageSearchResult,
  }) async {
    try {
      // Close search screen and room detail screen
      // and go to room messages screen
      Get.until((route) {
        return route.settings.name == Routes.chatRoomDirect.replaceFirst(':id', roomId);
      });
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchresultRoomdetails);
      eventBus.fire(JumpToMessageEvent(
        message: messageSearchResult,
        roomId: roomId,
        shakeMessage: true,
      ));
    } catch (e, stackTrace) {
      _log.e('Get.back error', e, stackTrace);
    }
  }
}
