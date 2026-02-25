import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/search_all_contact_result_argument.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/get_room_id_from_contact_or_chat_helper.dart';

final _log = useLogger();

class SearchAllContactResultController extends GetxController {
  final keyword = ''.obs;
  final title = ''.obs;
  final contactPreviewList = <ContactSearchResultModel>[].obs;

  ChatListSearchUseCase useCase = GetIt.I<ChatListSearchUseCase>();

  @override
  void onInit() async {
    final arg = Get.arguments as SearchAllContactResultArgument;
    keyword.value = arg.keyword;
    title.value = 'Search "@keyword"'.trParams({'keyword': keyword.value});
    contactPreviewList.addAll(arg.contactPreviewList);

    super.onInit();
  }

  void handleSelectContact(ContactSearchResultModel contact) async {
    if (contact.contact != null) {
      onSelectContact(contact.contact!);
    } else if (contact.room != null) {
      onSelectedRoom(contact.room!);
    }
  }

  void onSelectedRoom(RoomCollection room) async {
    useCase.addRecentSearch(room);

    final roomId = room.id;

    if (roomId == null) {
      _log.w('room id is null');
      return;
    }

    await GetIt.I<ProfileService>().openGroupProfile(
      roomId: roomId,
    );
  }

  void onSelectContact(ContactInterface contact) async {
    // TODO (refactor clean) Move this logic to use case
    String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contact.id ?? '');
    RoomCollection? room = await roomDb.getRoom(id ?? '');
    // If room in local db is not found, Get it from server.
    if (room == null) {
      final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
        OpenDirectChatRequest(friendAccountId: contact.id!),
      );
      if (roomEntity != null) {
        room = RoomCollection.fromEntity(roomEntity);
      }
    }
    final contactId = contact.id;
    if (room != null && contactId != null) {
      useCase.addRecentSearch(room);
      GetIt.I<ProfileService>().openProfileScreen(
        contactId: contactId,
      );
    } else {
      _log.w('room with first other account id $contactId not found');
    }
  }
}
