import 'package:uchat/api/backend_path.dart';

/// ChatFolderService
const createFolderPath = BackendPathModel(
  http: 'v3/chat-folders',
  socket: 'v3.chatFolders.post',
);

const pinChatRoomInFoldersPath = BackendPathModel(
  http: 'v3/chat-folders/:chatFolderId/pin',
  socket: 'v3.chatFolders.pin.post',
);

const fetchFoldersPath = BackendPathModel(
  http: 'v3/chat-folders/me',
  socket: 'v3.chatFolders.me.get',
);

const updateFolderPath = BackendPathModel(
  http: 'v3/chat-folders/:chatFolderId',
  socket: 'v3.chatFolders.update',
);

const deleteFolderPath = BackendPathModel(
  http: 'v3/chat-folders/:chatFolderId',
  socket: 'v3.chatFolders.delete',
);

const reorderFolderPath = BackendPathModel(
  http: 'v3/chat-folders/reorder',
  socket: 'v3.chatFolders.reorder.post',
);

const addRoomSubscriptionToChatFolderPath = BackendPathModel(
  http: 'v3/chat-folders/:chatFolderId/add-room-sub',
  socket: 'v3.chatFolders.addRoomSub.post',
);

const removeRoomSubscriptionFromChatFolderPath = BackendPathModel(
  http: 'v3/chat-folders/:chatFolderId/remove-room-sub',
  socket: 'v3.chatFolders.removeRoomSub.post',
);
