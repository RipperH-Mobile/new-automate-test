import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class OpenSystemChatAndSaveToDbUseCase extends SimpleUseCase<RoomEntity?, NoParams> {
  final ChatRoomServerRepository chatRoomServerRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final RoomSubLocalRepository roomSubLocalRepository;
  final RoomMemberLocalRepository roomMemberLocalRepository;
  final ContactLocalRepository contactLocalRepository;

  final _log = useLogger();

  OpenSystemChatAndSaveToDbUseCase({
    required this.chatRoomServerRepository,
    required this.chatRoomLocalRepository,
    required this.roomSubLocalRepository,
    required this.roomMemberLocalRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<RoomEntity?> call(NoParams params) async {
    final res = await chatRoomServerRepository.openSystemChat();

    if (res?.room case final resultRoom?) {
      await chatRoomLocalRepository.putRoom(resultRoom);
      await fetchRoomMemberAndSaveToDb(resultRoom.id);
    }

    if (res?.roomSub case final resultRoomSub?) {
      await roomSubLocalRepository.putRoomSubscription(resultRoomSub);
    }

    return res?.room;
  }

  Future<void> fetchRoomMemberAndSaveToDb(String roomId) async {
    int currentPage = 1;
    int totalPage = -1;
    int memberCount = -1;

    while (currentPage <= totalPage || totalPage == -1) {
      try {
        final result = await chatRoomServerRepository.getMembersInRoom(
          GetRoomMembersRequest(
            roomId: roomId,
            page: currentPage,
          ),
        );
        totalPage = result.totalPages;
        currentPage = result.page + 1;
        memberCount = result.total;
        if (result.data != null && result.data!.isNotEmpty) {
          // Get nickname data from contact db and save it in RoomMemberCollection.
          for (final member in result.data!) {
            final contact = await contactLocalRepository.getContact(member.account.id ?? '');
            if (contact?.nickname != null) {
              member.account.nickname = contact?.nickname;
            }
          }
          await roomMemberLocalRepository.updateAllRoomMember(result.data!.toList());
        }
      } catch (e, stacktrace) {
        _log.e('fetchRoomMemberAndSaveToDb error', e, stacktrace);
        rethrow;
      }
    }

    bool hasFirstOtherInRoom = memberCount > 1;
    final roomSub = await roomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId);

    if (roomSub != null) {
      // Create a copy of the entity with updated hasFirstOtherInRoom property
      final updatedRoomSub = roomSub.copyWith(hasFirstOtherInRoom: hasFirstOtherInRoom);
      await roomSubLocalRepository.putRoomSubscription(updatedRoomSub);
    }
  }
}
