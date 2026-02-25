class RoomPhotoAndVideoRequest {
  String roomId;
  int? page;
  int? pageSize;
  String? sequence;
  String? beforeSequence;
  String? afterSequence;

  /// This is the _id from response
  String? afterRoomFileId;

  /// This is the _id from response
  String? beforeRoomFileId;

  RoomPhotoAndVideoRequest({
    required this.roomId,
    this.page,
    this.pageSize = 40,
    this.sequence,
    this.beforeSequence,
    this.afterSequence,
    this.afterRoomFileId,
    this.beforeRoomFileId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'roomId': roomId};

    if (sequence != null) {
      json['sequence'] = sequence.toString();
    }

    if (pageSize != null) {
      json['pageSize'] = pageSize.toString();
    }

    if (beforeSequence != null) {
      json['beforeSequence'] = beforeSequence;
    }

    if (afterSequence != null) {
      json['afterSequence'] = afterSequence;
    }

    if (page != null) {
      json['page'] = page.toString();
    }

    if (afterRoomFileId != null) {
      json['afterRoomFileId'] = afterRoomFileId;
    }

    if (beforeRoomFileId != null) {
      json['beforeRoomFileId'] = beforeRoomFileId;
    }

    return json;
  }
}
