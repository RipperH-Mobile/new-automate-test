import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

class NextOwnerSuggestionModel {
  final int countMembers;
  final List<RoomMemberEntity> suggestionMembers;

  NextOwnerSuggestionModel({
    required this.countMembers,
    required this.suggestionMembers,
  });
}
