import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/chat_room/data/models/enums/sequence_condition.dart';

class GetMessageFromServerRequest {
  String roomId;
  SequenceCondition? seqCondition = SequenceCondition.and;
  int? pageSize;
  int? page;
  int? beforeSequence;
  int? afterSequence;
  bool isMyNote;
  String? bookmarkTagId;
  Duration timeout;

  GetMessageFromServerRequest({
    required this.roomId,
    this.beforeSequence,
    this.afterSequence,
    this.seqCondition,
    this.pageSize,
    this.page,
    this.isMyNote = false,
    this.bookmarkTagId,
    this.timeout = const Duration(milliseconds: UChatConstant.messageFetchTimeOut),
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> reqParams = {
      'roomId': roomId,
    };

    if (pageSize != null) {
      reqParams['pageSize'] = pageSize;
    }

    if (page != null) {
      reqParams['page'] = page;
    }

    // Convert integer sequence numbers to hexadecimal string representation
    if (beforeSequence != null) {
      reqParams['beforeSequence'] = beforeSequence!.toRadixString(16);
    }

    if (afterSequence != null) {
      reqParams['afterSequence'] = afterSequence!.toRadixString(16);
    }

    if (seqCondition != null) {
      reqParams['seqCondition'] = seqCondition!.value;
    }

    if (isMyNote) {
      reqParams['isMyNote'] = isMyNote;
    }

    if (bookmarkTagId != null) {
      reqParams['emojiTagId'] = bookmarkTagId;
    }

    return reqParams;
  }

  @override
  String toString() {
    return 'roomId: $roomId\n'
        'beforeSequence: ${beforeSequence?.toRadixString(16)}\n'
        'afterSequence: ${afterSequence?.toRadixString(16)}\n'
        'seqCondition: $seqCondition';
  }
}
