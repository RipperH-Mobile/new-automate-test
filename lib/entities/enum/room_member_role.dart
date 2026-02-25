enum RoomMemberRole {
  owner,
  admin,
  member;

  String get value {
    switch (this) {
      case RoomMemberRole.owner:
        return 'OWNER';
      case RoomMemberRole.admin:
        return 'ADMIN';
      case RoomMemberRole.member:
        return 'MEMBER';
    }
  }

  String get nameInAdminScreen {
    switch (this) {
      case RoomMemberRole.owner:
        return 'Owner';
      case RoomMemberRole.admin:
        return 'Admin';
      case RoomMemberRole.member:
        return 'Member';
    }
  }

  static RoomMemberRole? from(String? val) {
    if (val == null) return null;
    switch (val) {
      case 'OWNER':
        return RoomMemberRole.owner;
      case 'ADMIN':
        return RoomMemberRole.admin;
      case 'MEMBER':
        return RoomMemberRole.member;
      default:
        return null;
    }
  }
}
