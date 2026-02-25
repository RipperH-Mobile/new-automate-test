import 'package:uchat/use_cases/use_case.dart';

class IsReadMessageParams {
  final int? messageSequence;
  final Map<String, int> memberLastReadAtMap;
  final Map<String, DateTime?>? memberJoinedMap;
  final int? otherLastReadAt;
  final bool isGroup;

  IsReadMessageParams({
    required this.messageSequence,
    required this.memberLastReadAtMap,
    required this.memberJoinedMap,
    this.otherLastReadAt,
    this.isGroup = false,
  });
}

class IsReadMessageUseCase extends SimpleUseCaseSync<(bool, List<String>), IsReadMessageParams> {
  @override
  (bool, List<String>) call(IsReadMessageParams params) {
    final messageSequence = params.messageSequence ?? 0;
    final isGroup = params.isGroup;
    final memberJoinedMap = params.memberJoinedMap ?? {};

    if (messageSequence == 0) {
      return (false, []);
    }

    final memberLastReadAtMap = params.memberLastReadAtMap;

    if (memberLastReadAtMap.isEmpty) {
      return (false, []);
    }

    if (isGroup) {
      bool alreadyRead = false;
      List<String> readIds = [];
      for (var i = 0; i < memberLastReadAtMap.entries.length; i++) {
        final memberLastReadAt = memberLastReadAtMap.entries.elementAt(i).value;

        final accountId = memberLastReadAtMap.entries.elementAt(i).key;
        final joinedAt = memberJoinedMap[accountId];
        final messageSequenceDate = DateTime.fromMillisecondsSinceEpoch(messageSequence);

        // Skip read counting for members who:
        // 1. Never read any message (lastReadAt = 0)
        // 2. Joined after or exactly at the message time
        // Note: We exclude members who joined exactly at message time because they likely
        // couldn't have read the message since they just joined the group at that moment
        if (memberLastReadAt == 0 || (joinedAt != null && !messageSequenceDate.isAfter(joinedAt))) {
          continue;
        }

        if (memberLastReadAt < messageSequence) {
          continue;
        }

        alreadyRead = true;
        readIds.add(accountId);
      }

      return (alreadyRead, readIds);
    } else {
      final otherLastReadAt = params.otherLastReadAt ?? 0;

      if (otherLastReadAt == 0) {
        return (false, []);
      }

      final alreadyRead = otherLastReadAt >= messageSequence;
      return (alreadyRead, alreadyRead ? memberLastReadAtMap.entries.map((e) => e.key).toList() : []);
    }
  }
}
