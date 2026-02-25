import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRecentChatStickerGiftTargetParams {
  final int limit;
  final String? keyword;
  final int? offset;

  GetRecentChatStickerGiftTargetParams({
    this.limit = 5,
    this.keyword,
    this.offset,
  });
}

class GetRecentChatStickerGiftTargetUseCase
    extends SimpleUseCase<List<ContactEntity>, GetRecentChatStickerGiftTargetParams> {
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final ContactLocalRepository contactLocalRepository;

  GetRecentChatStickerGiftTargetUseCase({
    required this.chatRoomLocalRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<List<ContactEntity>> call(GetRecentChatStickerGiftTargetParams params) async {
    final roomList = await chatRoomLocalRepository.getRecentDirectChat(
      limit: params.limit,
      keyword: params.keyword,
      offset: params.offset,
    );
    int roomResultLength = roomList.length;
    if (roomList.isEmpty) return [];
    // Convert recent chat room sub entity to list of room id.
    List<String> roomIds = List<String>.from(roomList.map((e) => e.roomId).where((id) => id != null));
    // Get friend data from room ids.
    final firstOthers = await chatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds) ?? [];
    // Convert friend data to list of account id.
    List<String> accountIds = List<String>.from(firstOthers.map((e) => e.account.id).where((id) => id != null));
    // Get contact entity from account ids.
    final contactList = await contactLocalRepository.getContactList(accountIds);

    final result = List<ContactEntity>.from(contactList.where((e) => !e.isOfficial));
    if (result.length < contactList.length && result.length < params.limit) {
      final newResult = await call(GetRecentChatStickerGiftTargetParams(
        limit: params.limit - result.length,
        keyword: params.keyword,
        offset: roomResultLength + (params.offset ?? 0),
      ));
      if (newResult.isNotEmpty) result.addAll(newResult);
    }
    return result;
  }
}
