import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class ReadAllRoomInLocalParams {
  final bool withTxn;

  const ReadAllRoomInLocalParams({this.withTxn = true});
}

class ReadAllRoomInLocalUseCase extends SimpleUseCase<void, ReadAllRoomInLocalParams> {
  final ChatRoomLocalRepository chatRoomLocalRepository;

  ReadAllRoomInLocalUseCase({required this.chatRoomLocalRepository});

  @override
  Future<void> call(ReadAllRoomInLocalParams params) async {
    final res = await chatRoomLocalRepository.getAllUnreadRoom();
    final newRes = res?.map((e) => e.copyWith(unreadCount: 0)).toList();
    if (newRes != null) {
      await chatRoomLocalRepository.saveAll(newRes, withTxn: params.withTxn);
    }
  }
}
