import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_member_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchRoomMemberUseCase extends SimpleUseCase<(List<RoomMemberEntity>, bool?), FetchRoomMemberParams> {
  final LoggerService log;
  final RoomMemberDb roomMemberDb;
  final RoomSubscriptionDb roomSubDb;
  final ChatRoomApiService chatRoomApiService;
  final ContactLocalRepository contactLocalRepository;

  FetchRoomMemberUseCase({
    required this.log,
    required this.roomMemberDb,
    required this.roomSubDb,
    required this.chatRoomApiService,
    required this.contactLocalRepository,
  });

  @override
  Future<(List<RoomMemberEntity>, bool?)> call(FetchRoomMemberParams params) async {
    final roomId = params.roomId;
    final useTransaction = params.useTransaction;
    final saveToDb = params.saveToDb;

    final List<RoomMemberEntity> returnMembers = [];

    if (roomId == null || roomId.isEmpty) return (returnMembers, false);

    int currentPage = 1;
    int totalPage = -1;

    while (currentPage <= totalPage || totalPage == -1) {
      try {
        final result = await chatRoomApiService.getMembersInRoom(
          GetRoomMembersRequest(
            roomId: roomId,
            page: currentPage,
            pageSize: 100,
          ),
        );

        totalPage = result.totalPages;
        currentPage = result.page + 1;

        if (result.data case final members?) {
          // Get nickname data from contact db and save it in RoomMemberCollection.
          for (final member in result.data!) {
            if (member.accountId case final accountId?) {
              final contact = await contactLocalRepository.getContact(accountId);
              // final contact = await GetIt.I<GetContactUseCase>().call(ContactParams(accountId: member.accountId ?? ''));
              if (contact?.nickname != null) {
                member.account?.nickname = contact?.nickname;
              }
            }
          }

          final memberList = members.toList();

          if (saveToDb) {
            if (useTransaction) {
              await roomMemberDb.updateAllRoomMember(memberList);
            } else {
              await roomMemberDb.updateAllRoomMemberWithoutTxn(memberList);
            }
          }

          returnMembers.addAll(memberList.toEntities());
        }
      } catch (e, stacktrace) {
        log.e('fetchRoomMemberAndSaveToDb error', e, stacktrace);
        rethrow;
      }
    }

    final hasFirstOtherInRoom = await _updateHasFirstOtherInRoomInRoomSub(
      members: returnMembers,
      roomId: roomId,
      useTransaction: useTransaction,
      saveToDb: saveToDb,
    );

    return (returnMembers, hasFirstOtherInRoom);
  }

  Future<bool> _updateHasFirstOtherInRoomInRoomSub({
    required List<RoomMemberEntity> members,
    required String roomId,
    required bool useTransaction,
    required bool saveToDb,
  }) async {
    try {
      final hasFirstOtherInRoom = members.length > 1;
      final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(roomId);

      if (roomSub != null) {
        roomSub.hasFirstOtherInRoom = hasFirstOtherInRoom;

        if (saveToDb) {
          if (useTransaction) {
            await roomSubDb.putRoomSubscription(roomSub);
          } else {
            await roomSubDb.putRoomSubscriptionWithoutTxn(roomSub);
          }
        }
      }

      return hasFirstOtherInRoom;
    } catch (e, stacktrace) {
      log.e('update first other error', e, stacktrace);
    }

    return false;
  }
}
