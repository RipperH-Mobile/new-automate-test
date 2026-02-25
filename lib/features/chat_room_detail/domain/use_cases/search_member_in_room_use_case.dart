import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class SearchMemberInRoomParams {
  final String roomId;
  final String name;

  const SearchMemberInRoomParams({
    required this.roomId,
    required this.name,
  });
}

class SearchMemberInRoomUseCase extends SimpleUseCase<List<RoomMemberEntity>, SearchMemberInRoomParams> {
  final ChatRoomDetailLocalRepository chatRoomDetailLocalRepository;

  SearchMemberInRoomUseCase({
    required this.chatRoomDetailLocalRepository,
  });

  @override
  Future<List<RoomMemberEntity>> call(SearchMemberInRoomParams params) {
    return chatRoomDetailLocalRepository.searchMemberInRoom(params.roomId, params.name);
  }
}
