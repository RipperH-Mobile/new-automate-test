import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/models/member_typing_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';

/// Handles the user typing event in a chat room
///
/// When a user is typing in a room, this function updates the typing indicator
/// for that user in the message list.
///
/// [event] The typing event containing roomId, accountId, and typing status
/// [currentRoomId] The ID of the current chat room
/// [currentUserId] The ID of the current user
/// [members] List of members in the room
/// [messageListController] The controller that manages the message list and typing indicators
Future<void> handleUserInRoomTyping({
  required UserInRoomTypingEvent event,
  required String currentRoomId,
  required String? currentUserId,
  required List<dynamic> members,
  required MessageListController messageListController,
}) async {
  // Skip if event is for a different room
  if (event.roomId != currentRoomId) return;

  // Find the member who is typing
  final member = members.firstWhereOrNull((e) => e.accountId == event.accountId);

  // Skip if member not found or is the current user
  if (member == null || member.accountId == null || member.accountId == currentUserId) return;

  // Get contact information for the typing member
  var contactAccount =
      member.account ?? await GetIt.I<GetContactUseCase>().call(ContactParams(accountId: member.accountId!));

  // Skip if contact information not found
  if (contactAccount == null) return;

  // Update typing indicator in the message list
  messageListController.updateTypingMember(MemberTypingModel(
    accountId: member.accountId!,
    lastTypeAt: event.lastTypedAt,
    contact: contactAccount,
    isTyping: event.isTyping,
  ));
}
