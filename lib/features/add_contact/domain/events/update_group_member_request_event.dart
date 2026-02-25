import 'package:uchat/entities/enum/group_request_type.dart';

class UpdateGroupMemberRequestEvent {
  final String roomId;
  final String requestId;
  final String accountId;
  final GroupRequestType type;

  const UpdateGroupMemberRequestEvent({
    required this.roomId,
    required this.requestId,
    required this.accountId,
    required this.type,
  });
}
