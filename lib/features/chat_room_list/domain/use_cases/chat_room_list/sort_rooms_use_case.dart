import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

class SortRoomParams {
  final List<RoomSubscriptionCollection> roomList;
  final ChatSortingType sortType;

  SortRoomParams({
    required this.roomList,
    this.sortType = ChatSortingType.timeLastest,
  });
}

class SortRoomsUseCase extends SimpleUseCaseSync<List<RoomSubscriptionCollection>, SortRoomParams> {
  RoomSubscriptionDb get roomSubDb => GetIt.I<RoomSubscriptionDb>();

  @override
  List<RoomSubscriptionCollection> call(params) {
    final roomSubList = params.roomList;
    final sortType = params.sortType;

    if (sortType == ChatSortingType.nameDESC || sortType == ChatSortingType.nameASC) {
      roomSubList.sort((b, a) {
        if (a.title.isEmpty && b.title.isEmpty) {
          return -1;
        } else if (a.title.isEmpty && b.title.isNotEmpty) {
          return -1;
        } else if (a.title.isNotEmpty && b.title.isEmpty) {
          return 1;
        }

        final aRoomName = a.title;
        final bRoomName = b.title;
        if (sortType == ChatSortingType.nameASC) {
          return customAlphaSort(bRoomName, aRoomName);
        }
        return customAlphaSort(aRoomName, bRoomName);
      });
    }
    if (sortType == ChatSortingType.timeLastest || sortType == ChatSortingType.timeOldest) {
      roomSubDb.getRoomSubscriptionWithIdsSync(
        roomSubList.map((e) => e.id ?? '').toList(),
        desc: sortType == ChatSortingType.timeOldest,
      );
      roomSubList.sort((b, a) {
        if (a.roomLocalDateTime == null && b.roomLocalDateTime == null) {
          return -1;
        } else if (a.roomLocalDateTime == null && b.roomLocalDateTime != null) {
          return -1;
        } else if (a.roomLocalDateTime != null && b.roomLocalDateTime == null) {
          return 1;
        }

        final aCreatedAt = a.roomLocalDateTime!;
        final bCreatedAt = b.roomLocalDateTime!;
        if (sortType == ChatSortingType.timeOldest) {
          return bCreatedAt.compareTo(aCreatedAt);
        }
        return aCreatedAt.compareTo(bCreatedAt);
      });

      return roomSubList;
    } else if (sortType == ChatSortingType.unread) {
      final List<RoomSubscriptionCollection> unreadRooms = roomSubList
          .where(
            (element) => (element.unreadCount ?? 0) > 0,
          )
          .toList();
      final List<RoomSubscriptionCollection> readRooms = roomSubList
          .where(
            (element) => (element.unreadCount ?? 0) <= 0,
          )
          .toList();

      unreadRooms.sort((b, a) {
        if (a.roomLocalDateTime == null && b.roomLocalDateTime == null) {
          return -1;
        } else if (a.roomLocalDateTime == null && b.roomLocalDateTime != null) {
          return -1;
        } else if (a.roomLocalDateTime != null && b.roomLocalDateTime == null) {
          return 1;
        }

        final aCreatedAt = a.roomLocalDateTime!;
        final bCreatedAt = b.roomLocalDateTime!;

        return aCreatedAt.compareTo(bCreatedAt);
      });
      readRooms.sort((b, a) {
        if (a.roomLocalDateTime == null && b.roomLocalDateTime == null) {
          return -1;
        } else if (a.roomLocalDateTime == null && b.roomLocalDateTime != null) {
          return -1;
        } else if (a.roomLocalDateTime != null && b.roomLocalDateTime == null) {
          return 1;
        }

        final aCreatedAt = a.roomLocalDateTime!;
        final bCreatedAt = b.roomLocalDateTime!;

        return aCreatedAt.compareTo(bCreatedAt);
      });

      return [...unreadRooms, ...readRooms];
    }

    return roomSubList;
  }

  int customAlphaSort(String a, String b) {
    int minLen = a.length < b.length ? a.length : b.length;

    for (int i = 0; i < minLen; i++) {
      String charA = a[i];
      String charB = b[i];

      // Compare letters ignoring case
      int caseInsensitive = charA.toLowerCase().compareTo(charB.toLowerCase());
      if (caseInsensitive != 0) return caseInsensitive;

      // If equal ignoring case, prioritize uppercase
      if (charA != charB) {
        if (charA.compareTo(charB) != 0) {
          return charA.compareTo(charB);
        }
      }
    }

    // If all characters equal up to min length, shorter string comes first
    return a.length.compareTo(b.length);
  }
}
