import 'package:uchat/constants/uchat_constant.dart';

class GetMessageFromServerParam {
  /// Id of the room that the message belongs to
  final String roomId;

  /// isMyNote is the message in bookmark room
  /// My note is the message that I sent in the bookmark room
  final bool isMyNote;

  /// id of the emoji tag
  final String? bookmarkTagId;

  /// If this is true, it will only fetch the message after the last message in the list
  final bool onlyAfter;

  /// If this is true, it will only fetch the message before the first message in the list
  final bool onlyPrevious;

  /// timeout for fetching message from server
  /// default is 5 seconds
  final Duration timeout;

  /// page size for fetching message from server
  /// default is 120 [UChatConstant.defaultPageSize]
  final int pageSize;

  GetMessageFromServerParam({
    required this.roomId,
    this.isMyNote = false,
    this.bookmarkTagId,
    this.onlyAfter = false,
    this.onlyPrevious = false,
    this.timeout = const Duration(milliseconds: UChatConstant.messageFetchTimeOut),
    this.pageSize = UChatConstant.defaultPageSize,
  });

  GetMessageFromServerParam copyWith({
    String? roomId,
    bool? isMyNote,
    String? bookmarkTagId,
    bool? onlyAfter,
    bool? onlyPrevious,
    Duration? timeout,
    int? pageSize,
  }) {
    return GetMessageFromServerParam(
      roomId: roomId ?? this.roomId,
      isMyNote: isMyNote ?? this.isMyNote,
      bookmarkTagId: bookmarkTagId ?? this.bookmarkTagId,
      onlyAfter: onlyAfter ?? this.onlyAfter,
      onlyPrevious: onlyPrevious ?? this.onlyPrevious,
      timeout: timeout ?? this.timeout,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  String toString() {
    return 'roomId: $roomId\n'
        'isMyNote: $isMyNote\n'
        'bookmarkTagId: $bookmarkTagId\n'
        'onlyAfter: $onlyAfter\n'
        'onlyPrevious: $onlyPrevious\n'
        'timeout: $timeout\n'
        'pageSize: $pageSize';
  }
}
