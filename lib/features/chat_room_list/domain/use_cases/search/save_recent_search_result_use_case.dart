import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_result_model.dart';
import 'package:uchat/features/chat_room_list/data/models/room_recent_search_model.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SaveRecentSearchResultUseCase extends SimpleUseCase<List<RecentSearchCollection>, List<RecentSearchResultModel>> {
  final RoomMemberDb roomMemberDb;
  final RoomDb roomDb;
  final ChatListSearchLocalRepository chatListSearchLocalRepository;

  SaveRecentSearchResultUseCase({
    required this.roomMemberDb,
    required this.roomDb,
    required this.chatListSearchLocalRepository,
  });

  @override
  Future<List<RecentSearchCollection>> call(List<RecentSearchResultModel> params) async {
    final newList = <RecentSearchCollection>[];

    for (final data in params) {
      final createdAt = data.createdAt ?? DateTime.now();

      if (data.type == RecentSearchType.room) {
        if (data.value case final roomId?) {
          RoomMemberCollection? contact;
          final room = await roomDb.getRoom(roomId);

          if (room?.isDirect == true) {
            contact = roomMemberDb.getFirstOtherInRoomSync(roomId);
          }

          newList.add(RecentSearchCollection(
            id: data.id,
            room: room != null ? RoomRecentSearchModel.fromCollection(room) : null,
            contact: contact != null ? ContactModel.fromRoomMember(contact) : null,
            type: RecentSearchType.room,
            createdAt: createdAt,
          ));
        }
      } else {
        newList.add(RecentSearchCollection(
          id: data.id,
          keyword: data.value,
          type: RecentSearchType.search,
          createdAt: createdAt,
        ));
      }
    }

    await chatListSearchLocalRepository.clearCollection();
    await chatListSearchLocalRepository.putAllRecentSearch(newList);

    return newList;
  }
}
