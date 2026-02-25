/// Parameter class for retrieving messages from server
class GetMessageFromServerParams {
  GetMessageFromServerParams({
    required this.roomId,
    this.pageSize = 30,
    this.afterSequence,
    this.beforeSequence,
    this.isMyNote = false,
    this.bookmarkTagId,
    this.timeout,
  });

  /// ID of the chat room to get messages from
  final String roomId;

  /// Number of messages to retrieve
  final int pageSize;

  /// Retrieve messages after this sequence number
  final int? afterSequence;

  /// Retrieve messages before this sequence number
  final int? beforeSequence;

  /// Flag to retrieve only personal notes
  final bool isMyNote;

  /// ID of bookmark tag to filter messages
  final String? bookmarkTagId;

  /// Request timeout in milliseconds
  final int? timeout;

  GetMessageFromServerParams copyWith({
    String? roomId,
    int? pageSize,
    int? afterSequence,
    int? beforeSequence,
    bool? isMyNote,
    String? bookmarkTagId,
    int? timeout,
  }) {
    return GetMessageFromServerParams(
      roomId: roomId ?? this.roomId,
      pageSize: pageSize ?? this.pageSize,
      afterSequence: afterSequence ?? this.afterSequence,
      beforeSequence: beforeSequence ?? this.beforeSequence,
      isMyNote: isMyNote ?? this.isMyNote,
      bookmarkTagId: bookmarkTagId ?? this.bookmarkTagId,
      timeout: timeout ?? this.timeout,
    );
  }
}
