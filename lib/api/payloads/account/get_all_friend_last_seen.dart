import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/utils/datetime.dart';

class GetAllFriendLastSeenRequest {
  DateTime? lastSyncAt;

  GetAllFriendLastSeenRequest({this.lastSyncAt});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    if (lastSyncAt != null) {
      json['lastSyncAt'] = lastSyncAt?.toUtc().toIso8601String();
    }
    return json;
  }
}

class GetAllFriendLastSeenResponse {
  String friendAccountId;
  DateTime lastSeenAt;
  OnlineStatus onlineStatus;
  bool? friendCanSeeMyLastSeen;

  GetAllFriendLastSeenResponse({
    required this.friendAccountId,
    required this.lastSeenAt,
    required this.onlineStatus,
    this.friendCanSeeMyLastSeen,
  });

  static GetAllFriendLastSeenResponse fromMap(Map<String, dynamic> json) {
    return GetAllFriendLastSeenResponse(
      friendAccountId: json['friendAccountId'],
      lastSeenAt: strToDateTime(json['lastSeenAt'])!,
      onlineStatus: OnlineStatus.from(json['onlineStatus']) ?? OnlineStatus.online,
      friendCanSeeMyLastSeen: json['friendCanSeeMyLastSeen'],
    );
  }
}
