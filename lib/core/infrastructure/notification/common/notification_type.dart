enum NotificationType {
  unknown,
  newMessage,
  call,
  declineCall,
  acceptCall,
  ringingCall,
  ackCall,
  cancelCall,
  missedCall,
  incomingCall, // Group call incoming
  acceptInvited,
  newFriendRequest,
  newGroupInvitation,
  acceptFriendRequest;

  String get value {
    switch (this) {
      case NotificationType.newMessage:
        return 'NEW_MESSAGE_NOTIFICATION';
      case NotificationType.call:
        return 'CALL_NOTIFICATION';
      case NotificationType.declineCall:
        return 'DECLINE_CALL_NOTIFICATION';
      case NotificationType.acceptCall:
        return 'ACCEPT_CALL_NOTIFICATION';
      case NotificationType.ringingCall:
        return 'RINGING_CALL_NOTIFICATION';
      case NotificationType.ackCall:
        return 'ACK_CALL_NOTIFICATION';
      case NotificationType.cancelCall:
        return 'CANCEL_CALL_NOTIFICATION';
      case NotificationType.missedCall:
        return 'MISSED';
      case NotificationType.incomingCall:
        return 'INCOMING';
      case NotificationType.acceptInvited:
        return 'ACCEPT_INVITED';
      case NotificationType.newFriendRequest:
        return 'NEW_FRIEND_REQUEST';
      case NotificationType.newGroupInvitation:
        return 'NEW_GROUP_INVITATION';
      case NotificationType.acceptFriendRequest:
        return 'ACCEPT_FRIEND_REQUEST';
      default:
        return 'UNKNOWN';
    }
  }

  String get taxonomyType {
    switch (this) {
      case NotificationType.newMessage:
        return 'chat message';
      case NotificationType.call:
      case NotificationType.declineCall:
      case NotificationType.acceptCall:
      case NotificationType.ringingCall:
      case NotificationType.ackCall:
      case NotificationType.cancelCall:
      case NotificationType.missedCall:
      case NotificationType.incomingCall:
        return 'call';
      case NotificationType.newFriendRequest:
      case NotificationType.acceptFriendRequest:
        return 'friend request';
      case NotificationType.newGroupInvitation:
      case NotificationType.acceptInvited:
        return 'group invite';
      default:
        return 'UNKNOWN';
    }
  }

  static NotificationType from(String val) {
    switch (val) {
      case 'NEW_MESSAGE_NOTIFICATION':
        return NotificationType.newMessage;
      case 'CALL_NOTIFICATION':
        return NotificationType.call;
      case 'DECLINE_CALL_NOTIFICATION':
        return NotificationType.declineCall;
      case 'ACCEPT_CALL_NOTIFICATION':
        return NotificationType.acceptCall;
      case 'RINGING_CALL_NOTIFICATION':
        return NotificationType.ringingCall;
      case 'ACK_CALL_NOTIFICATION':
        return NotificationType.ackCall;
      case 'CANCEL_CALL_NOTIFICATION':
        return NotificationType.cancelCall;
      case 'MISSED':
        return NotificationType.missedCall;
      case 'INCOMING':
        return NotificationType.incomingCall;
      case 'ACCEPT_INVITED':
        return NotificationType.acceptInvited;
      case 'NEW_FRIEND_REQUEST':
        return NotificationType.newFriendRequest;
      case 'NEW_GROUP_INVITATION':
        return NotificationType.newGroupInvitation;
      case 'ACCEPT_FRIEND_REQUEST':
        return NotificationType.acceptFriendRequest;
      default:
        return NotificationType.unknown;
    }
  }

  @override
  String toString() {
    return value;
  }
}
