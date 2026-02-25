enum UpdateStateType {
  // Group: default
  unknown,
  updateUser,
  banWarning,
  deleteBookmarkEmojiTag,
  deleteBookmarkMessage,
  newAlbum,
  reactMessage,
  refundReason,
  refundReasonPremiumPackage,
  rejectSession,
  updateAlbum,
  updateBookmarkEmojiTag,
  updateCoin,
  updateImageAlbum,
  deleteImageAlbum,
  updateSubscriptionChatFolder,
  newCallLog,
  reorderSticker,
  updateRoomReadAll,

  // Group: friend
  deleteFriend,
  newFriend,
  updateFriend,

  // Group: message
  newMessage,
  updateMessage,

  // Group: room
  addRoomMember,
  deleteAlbum,
  deleteImage,
  deleteRoom,
  newRoom,
  updateRoom,
  updateAdminsRoom,
  removeRoomMember,
  updateInvitedUser,
  updateMembersAlbum,
  updateRoomMember,
  updateRoomMemberLastSeen,
  updateUserDeletedRoom,
  assignRoomAdmin,
  revokeRoomAdmin,
  updateRoomAdminPermissions,
  updateRoomPermissions,
  ownershipTransferred,
  updateRoomMemberRequest,
  // Group: subscription
  newSubscription,
  updateSubscription,
  deleteSubscription,
  pinMessage,
  unpinMessage,
  unpinAllMessage,
  updateRoomInviteLink,
  notificationCenterAccountDeleted;

  String get value {
    switch (this) {
      case UpdateStateType.updateUser:
        return 'updateUser';
      case UpdateStateType.updateInvitedUser:
        return 'updateInvitedUser';
      case UpdateStateType.newAlbum:
        return 'newAlbum';
      case UpdateStateType.updateAlbum:
        return 'updateAlbum';
      case UpdateStateType.updateImageAlbum:
        return 'updateImageAlbum';
      case UpdateStateType.deleteImageAlbum:
        return 'deleteImageAlbum';
      case UpdateStateType.deleteAlbum:
        return 'deleteAlbum';
      case UpdateStateType.deleteImage:
        return 'deleteImage';
      case UpdateStateType.updateMembersAlbum:
        return 'updateMembersAlbum';
      case UpdateStateType.newFriend:
        return 'newFriend';
      case UpdateStateType.updateFriend:
        return 'updateFriend';
      case UpdateStateType.deleteFriend:
        return 'deleteFriend';
      case UpdateStateType.newMessage:
        return 'newMessage';
      case UpdateStateType.updateMessage:
        return 'updateMessage';
      case UpdateStateType.newRoom:
        return 'newRoom';
      case UpdateStateType.updateRoom:
        return 'updateRoom';
      case UpdateStateType.addRoomMember:
        return 'addRoomMember';
      case UpdateStateType.updateRoomMember:
        return 'updateRoomMember';
      case UpdateStateType.removeRoomMember:
        return 'removeRoomMember';
      case UpdateStateType.updateRoomMemberLastSeen:
        return 'updateRoomMemberLastSeen';
      case UpdateStateType.updateAdminsRoom:
        return 'updateAdminsRoom';
      case UpdateStateType.updateUserDeletedRoom:
        return 'updateUserDeletedRoom';
      case UpdateStateType.deleteRoom:
        return 'deleteRoom';
      case UpdateStateType.newSubscription:
        return 'newSubscription';
      case UpdateStateType.updateSubscription:
        return 'updateSubscription';
      case UpdateStateType.deleteSubscription:
        return 'deleteSubscription';
      case UpdateStateType.rejectSession:
        return 'rejectSession';
      case UpdateStateType.banWarning:
        return 'banWarning';
      case UpdateStateType.updateSubscriptionChatFolder:
        return 'updateSubscriptionChatFolder';
      case UpdateStateType.refundReason:
        return 'refundReason';
      case UpdateStateType.deleteBookmarkMessage:
        return 'deleteBookmarkMessage';
      case UpdateStateType.deleteBookmarkEmojiTag:
        return 'deleteBookmarkEmojiTag';
      case UpdateStateType.reactMessage:
        return 'reactMessage';
      case UpdateStateType.updateCoin:
        return 'updateCoin';
      case UpdateStateType.refundReasonPremiumPackage:
        return 'refundReasonPremiumPackage';
      case UpdateStateType.updateBookmarkEmojiTag:
        return 'updateBookmarkEmojiTag';
      case UpdateStateType.newCallLog:
        return 'newCallLog';
      case UpdateStateType.reorderSticker:
        return 'reorderSticker';
      case UpdateStateType.assignRoomAdmin:
        return 'assignRoomAdmin';
      case UpdateStateType.updateRoomPermissions:
        return 'updateRoomPermissions';
      case UpdateStateType.revokeRoomAdmin:
        return 'revokeRoomAdmin';
      case UpdateStateType.updateRoomAdminPermissions:
        return 'updateRoomAdminPermissions';
      case UpdateStateType.ownershipTransferred:
        return 'ownershipTransferred';
      case UpdateStateType.pinMessage:
        return 'pinMessage';
      case UpdateStateType.unpinMessage:
        return 'unpinMessage';
      case UpdateStateType.unpinAllMessage:
        return 'unpinAllMessage';
      case UpdateStateType.updateRoomMemberRequest:
        return 'updateRoomMemberRequest';
      case UpdateStateType.updateRoomInviteLink:
        return 'updateRoomInviteLink';
      case UpdateStateType.updateRoomReadAll:
        return 'updateRoomReadAll';
      case UpdateStateType.notificationCenterAccountDeleted:
        return 'notificationCenterAccountDeleted';
      default:
        return 'unknown';
    }
  }

  static UpdateStateType from(String? val) {
    switch (val) {
      case 'updateUser':
        return UpdateStateType.updateUser;
      case 'updateInvitedUser':
        return UpdateStateType.updateInvitedUser;
      case 'newAlbum':
        return UpdateStateType.newAlbum;
      case 'updateAlbum':
        return UpdateStateType.updateAlbum;
      case 'updateImageAlbum':
        return UpdateStateType.updateImageAlbum;
      case 'deleteImageAlbum':
        return UpdateStateType.deleteImageAlbum;
      case 'deleteAlbum':
        return UpdateStateType.deleteAlbum;
      case 'deleteImage':
        return UpdateStateType.deleteImage;
      case 'updateMembersAlbum':
        return UpdateStateType.updateMembersAlbum;
      case 'newFriend':
        return UpdateStateType.newFriend;
      case 'updateFriend':
        return UpdateStateType.updateFriend;
      case 'deleteFriend':
        return UpdateStateType.deleteFriend;
      case 'newMessage':
        return UpdateStateType.newMessage;
      case 'updateMessage':
        return UpdateStateType.updateMessage;
      case 'newRoom':
        return UpdateStateType.newRoom;
      case 'updateRoom':
        return UpdateStateType.updateRoom;
      case 'addRoomMember':
        return UpdateStateType.addRoomMember;
      case 'updateRoomMember':
        return UpdateStateType.updateRoomMember;
      case 'removeRoomMember':
        return UpdateStateType.removeRoomMember;
      case 'updateRoomMemberLastSeen':
        return UpdateStateType.updateRoomMemberLastSeen;
      case 'updateAdminsRoom':
        return UpdateStateType.updateAdminsRoom;
      case 'updateUserDeletedRoom':
        return UpdateStateType.updateUserDeletedRoom;
      case 'deleteRoom':
        return UpdateStateType.deleteRoom;
      case 'newSubscription':
        return UpdateStateType.newSubscription;
      case 'updateSubscription':
        return UpdateStateType.updateSubscription;
      case 'deleteSubscription':
        return UpdateStateType.deleteSubscription;
      case 'rejectSession':
        return UpdateStateType.rejectSession;
      case 'banWarning':
        return UpdateStateType.banWarning;
      case 'updateSubscriptionChatFolder':
        return UpdateStateType.updateSubscriptionChatFolder;
      case 'refundReason':
        return UpdateStateType.refundReason;
      case 'deleteBookmarkMessage':
        return UpdateStateType.deleteBookmarkMessage;
      case 'deleteBookmarkEmojiTag':
        return UpdateStateType.deleteBookmarkEmojiTag;
      case 'reactMessage':
        return UpdateStateType.reactMessage;
      case 'updateCoin':
        return UpdateStateType.updateCoin;
      case 'refundReasonPremiumPackage':
        return UpdateStateType.refundReasonPremiumPackage;
      case 'updateBookmarkEmojiTag':
        return UpdateStateType.updateBookmarkEmojiTag;
      case 'newCallLog':
        return UpdateStateType.newCallLog;
      case 'reorderSticker':
        return UpdateStateType.reorderSticker;
      case 'assignRoomAdmin':
        return UpdateStateType.assignRoomAdmin;
      case 'updateRoomPermissions':
        return UpdateStateType.updateRoomPermissions;
      case 'revokeRoomAdmin':
        return UpdateStateType.revokeRoomAdmin;
      case 'updateRoomAdminPermissions':
        return UpdateStateType.updateRoomAdminPermissions;
      case 'ownershipTransferred':
        return UpdateStateType.ownershipTransferred;
      case 'pinMessage':
        return UpdateStateType.pinMessage;
      case 'unpinMessage':
        return UpdateStateType.unpinMessage;
      case 'unpinAllMessage':
        return UpdateStateType.unpinAllMessage;
      case 'updateRoomMemberRequest':
        return UpdateStateType.updateRoomMemberRequest;
      case 'updateRoomInviteLink':
        return UpdateStateType.updateRoomInviteLink;
      case 'updateRoomReadAll':
        return UpdateStateType.updateRoomReadAll;
      case 'notificationCenterAccountDeleted':
        return UpdateStateType.notificationCenterAccountDeleted;
      default:
        return UpdateStateType.unknown;
    }
  }
}
