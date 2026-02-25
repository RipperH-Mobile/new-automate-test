enum WaitingMemberUpdateType {
  add,
  remove;

  String value() {
    switch (this) {
      case WaitingMemberUpdateType.add:
        return 'add';
      case WaitingMemberUpdateType.remove:
        return 'remove';
    }
  }

  static WaitingMemberUpdateType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'add':
        return WaitingMemberUpdateType.add;
      case 'remove':
        return WaitingMemberUpdateType.remove;
      default:
        throw ArgumentError('Invalid WaitingMemberUpdateType: $type');
    }
  }
}

class WaitingMemberData {
  String accountId;
  String? displayName;
  String? avatarId;

  WaitingMemberData({
    required this.accountId,
    this.displayName,
    this.avatarId,
  });

  factory WaitingMemberData.fromMap(Map<String, dynamic> data) {
    return WaitingMemberData(
      accountId: data['_id'],
      displayName: data['displayName'],
      avatarId: data['avatarId'] as String?,
    );
  }

  @override
  String toString() => 'WaitingMemberData(accountId: $accountId, displayName: $displayName, avatarId: $avatarId)';
}

class WaitingMemberUpdateEvent {
  String roomId;
  List<WaitingMemberData> members;
  WaitingMemberUpdateType type;

  WaitingMemberUpdateEvent({
    required this.roomId,
    required this.members,
    required this.type,
  });

  factory WaitingMemberUpdateEvent.fromMap(Map<String, dynamic> data) {
    final members = <WaitingMemberData>[];
    for (final member in data['accounts']) {
      members.add(WaitingMemberData.fromMap(member));
    }
    return WaitingMemberUpdateEvent(
      roomId: data['roomId'],
      members: members,
      type: WaitingMemberUpdateType.fromString(data['type']),
    );
  }

  @override
  String toString() => 'WaitingMemberUpdateEvent(roomId: $roomId, members: $members, type: $type)';
}
