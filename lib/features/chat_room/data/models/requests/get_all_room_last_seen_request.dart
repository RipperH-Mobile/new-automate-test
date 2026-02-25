class GetAllRoomLastSeenRequest {
  DateTime? lastSyncAt;

  GetAllRoomLastSeenRequest({this.lastSyncAt});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (lastSyncAt != null) {
      json['lastSyncAt'] = lastSyncAt?.toUtc().toIso8601String();
    }
    return json;
  }
}
