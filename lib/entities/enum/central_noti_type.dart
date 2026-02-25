enum CentralNotiType {
  /// other sent friend request to me, and not yet accept
  newFriend,

  /// friend sent invite group to me, but I decline
  declineFriend,

  /// me accept friend request from other
  acceptFriend,

  /// me sent friend request to other, and other accept
  friendAccept,

  /// friend sent invite group to me, and I not yet accept
  inviteGroup,

  /// friend sent invite group to me, but I decline
  declineGroup,

  /// friend sent invite group to me, and I accept
  acceptGroup,

  /// friend accept my invite group
  groupAccept,

  /// friend send gift sticker to me
  sendGiftSticker,

  /// group deleted but noti still show
  groupDeleted,

  /// friend deleted account but noti still show
  friendDeleted,

  requestGroup,

  requestGroupApproved,

  requestGroupDeclined,

  requestGroupJoined,

  groupDeclined,

  unknown;

  //NEW_FRIEND = "NEW_FRIEND",
  //ACCEPTED_FRIEND = "ACCEPTED_FRIEND",
  //FRIEND_ACCEPTED = "FRIEND_ACCEPTED",
  //INVITED_GROUP = "INVITED_GROUP",
  //DECLINED_GROUP = "DECLINED_GROUP",
  //ACCEPTED_GROUP = "ACCEPTED_GROUP",
  //GROUP_ACCEPTED = "GROUP_ACCEPTED",
  //SEND_GIFT_STICKER = "SEND_GIFT_STICKER",

  String get value {
    switch (this) {
      case CentralNotiType.newFriend:
        return 'NEW_FRIEND';
      case CentralNotiType.declineFriend:
        return 'DECLINED_FRIEND';
      case CentralNotiType.acceptFriend:
        return 'ACCEPTED_FRIEND';
      case CentralNotiType.friendAccept:
        return 'FRIEND_ACCEPTED';
      case CentralNotiType.inviteGroup:
        return 'INVITED_GROUP';
      case CentralNotiType.declineGroup:
        return 'DECLINED_GROUP';
      case CentralNotiType.acceptGroup:
        return 'ACCEPTED_GROUP';
      case CentralNotiType.groupAccept:
        return 'GROUP_ACCEPTED';
      case CentralNotiType.sendGiftSticker:
        return 'SEND_GIFT_STICKER';
      case CentralNotiType.groupDeleted:
        return 'GROUP_DELETED';
      case CentralNotiType.friendDeleted:
        return 'FRIEND_DELETED';
      case CentralNotiType.requestGroup:
        return 'REQUEST_GROUP';
      case CentralNotiType.requestGroupApproved:
        return 'REQUEST_GROUP_APPROVED';
      case CentralNotiType.requestGroupDeclined:
        return 'REQUEST_GROUP_DECLINED';
      case CentralNotiType.requestGroupJoined:
        return 'REQUEST_GROUP_JOINED';
      case CentralNotiType.groupDeclined:
        return 'GROUP_DECLINED';
      default:
        return 'UNKNOWN';
    }
  }

  static CentralNotiType from(String? val) {
    switch (val) {
      case 'NEW_FRIEND':
        return CentralNotiType.newFriend;
      case 'DECLINED_FRIEND':
        return CentralNotiType.declineFriend;
      case 'ACCEPTED_FRIEND':
        return CentralNotiType.acceptFriend;
      case 'FRIEND_ACCEPTED':
        return CentralNotiType.friendAccept;
      case 'INVITED_GROUP':
        return CentralNotiType.inviteGroup;
      case 'DECLINED_GROUP':
        return CentralNotiType.declineGroup;
      case 'ACCEPTED_GROUP':
        return CentralNotiType.acceptGroup;
      case 'GROUP_ACCEPTED':
        return CentralNotiType.groupAccept;
      case 'SEND_GIFT_STICKER':
        return CentralNotiType.sendGiftSticker;
      case 'GROUP_DELETED':
        return CentralNotiType.groupDeleted;
      case 'FRIEND_DELETED':
        return CentralNotiType.friendDeleted;
      case 'REQUEST_GROUP':
        return CentralNotiType.requestGroup;
      case 'REQUEST_GROUP_APPROVED':
        return CentralNotiType.requestGroupApproved;
      case 'REQUEST_GROUP_DECLINED':
        return CentralNotiType.requestGroupDeclined;
      case 'REQUEST_GROUP_JOINED':
        return CentralNotiType.requestGroupJoined;
      case 'GROUP_DECLINED':
        return CentralNotiType.groupDeclined;
      default:
        return CentralNotiType.unknown;
    }
  }
}
