import 'package:uchat/api/backend_path.dart';

const declineFriendPath = BackendPathModel(
  http: 'v3/friend/decline',
  socket: 'v3.friend.decline.post',
);

const addContactPath = BackendPathModel(
  http: 'v3/add-friend',
  socket: 'v3.friend.add.post',
);

const checkIfRequestingFriendPath = BackendPathModel(
  http: 'v3/friend/is-request',
  socket: 'v3.friends.isRequest.get',
);

const getNotAcceptFriendListPath = BackendPathModel(
  http: 'new-friends',
  socket: 'friend.apiFriendNotAcceptList',
);

const getFriendRequestListPath = BackendPathModel(
  http: 'v3/new-friends',
  socket: 'v3.friends.pending.get',
);

const hideFriendPath = BackendPathModel(
  http: 'v3/hide-friend',
  socket: 'v3.friend.hide.post',
);

const removeFriendPath = BackendPathModel(
  http: 'remove-friend',
  socket: 'friend.removeFriend',
);

const searchContactPath = BackendPathModel(
  http: 'find-account',
  socket: 'account.findAccount',
);

const unhideFriendPath = BackendPathModel(
  http: 'unhide-friend',
  socket: 'friend.unhideFriend',
);

const unblockFriendPath = BackendPathModel(
  http: 'unblock-friend',
  socket: 'friend.unblockFriend',
);

const updateNicknamePath = BackendPathModel(
  http: 'friend/:friendAccountId/set/nickname',
  socket: 'friend.setFriendNickname',
);

const deleteContactPath = BackendPathModel(
  http: '',
  socket: 'friend.rejectFriend',
);

const blockFriendPath = BackendPathModel(
  http: 'v3/block-friend',
  socket: 'v3.friend.block.post',
);

const addFriendInGroupPath = BackendPathModel(
  http: 'add-friend-in-group/:roomId',
  socket: 'friend.addFriendInGroup',
);
