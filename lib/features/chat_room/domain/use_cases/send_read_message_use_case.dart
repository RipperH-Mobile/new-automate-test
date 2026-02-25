import 'package:easy_debounce/easy_debounce.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SendReadMessageParams {
  final String roomId;

  /// The last time the user read the chat room
  ///
  /// This is the timestamp of the last message that the user has read.
  final int lastReadAt;

  /// The unread message count in the room
  final int unreadCount;

  /// The last message seen by the user.
  ///
  /// This is the message created at that the user has seen last.
  final DateTime? seenMessageAt;

  final Future<void> Function(DateTime)? onCompleted;

  SendReadMessageParams({
    required this.roomId,
    required this.lastReadAt,
    required this.unreadCount,
    this.seenMessageAt,
    this.onCompleted,
  });

  @override
  String toString() {
    return 'SendReadMessageParams(roomId: $roomId, lastReadAt: $lastReadAt, seenMessageAt: $seenMessageAt, onCompleted: $onCompleted)';
  }
}

/// Trigger the read message event.
///
/// This method will trigger the read message event to the server.
///
/// If the [messageCreatedAt] is not null, it will set the seen message timestamp to the [messageCreatedAt].
/// Otherwise, it will set the seen message timestamp to the current time.
class SendReadMessageUseCase extends SimpleUseCase<void, SendReadMessageParams> {
  final _log = useLogger();

  @override
  Future<void> call(SendReadMessageParams params) async {
    try {
      final lastReadAt = params.lastReadAt;
      final messageCreatedAt = params.seenMessageAt;

      if ((messageCreatedAt?.millisecondsSinceEpoch ?? 0) <= lastReadAt) {
        if (params.unreadCount > 0) {
          // If the unread count is greater than 0, then trigger the read message event to avoid bug
          await _triggerReadMessage(params, true);

          return;
        }
        // If message created time is older than my last read time, do nothing
        // because I already read it.
        return;
      }

      EasyDebounce.debounce(
        'trigger_read_message_${params.roomId}',
        const Duration(milliseconds: 400),
        () async => await _triggerReadMessage(params, false),
      );
    } catch (e, stackTrace) {
      _log.e('SendReadMessageUseCase error.', e, stackTrace);
    }
  }

  Future<void> _triggerReadMessage(SendReadMessageParams params, bool isUseDateTimeNow) async {
    try {
      // Set the seen message timestamp to the [messageCreatedAt] or the current time.
      // and then update the last read message timestamp of the current user.
      // and then calculate the last read message timestamp of the members in the room.
      final seenMessageAt = isUseDateTimeNow ? DateTime.now() : params.seenMessageAt ?? DateTime.now();
      final request = ReadMessageRequest(
        roomId: params.roomId,
        seenMessageAt: seenMessageAt,
      );

      await GetIt.I<ChatRoomServerRepository>().triggerReadMessage(request);
      await params.onCompleted?.call(seenMessageAt);
    } catch (e, stackTrace) {
      _log.e('Failed to trigger read message', e, stackTrace);
    }
  }
}
