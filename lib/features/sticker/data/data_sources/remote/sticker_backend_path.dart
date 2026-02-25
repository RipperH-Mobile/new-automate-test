import 'package:uchat/api/backend_path.dart';

class StickerBackendPath {
  StickerBackendPath._();

  static const getStickerMainScreen = BackendPathModel(
    http: 'v3/stickers/group',
    socket: 'v3.stickers.group.get',
  );

  static const getStickerSection = BackendPathModel(
    http: 'v3/stickers',
    socket: 'v3.stickers.get',
  );

  static const getFavoriteStickerPack = BackendPathModel(
    http: 'v3/stickers/favourite',
    socket: 'v3.stickers.favourite.get',
  );

  @Deprecated('This is old endpoint. Use v3 endpoint instead or maybe remove this if it is unused.')
  static const searchStickerByEmoji = BackendPathModel(
    http: 'sticker/emoji',
    socket: 'sticker.searchStickerItemByEmoji',
  );

  static const getStickerDetailV3 = BackendPathModel(
    http: 'v3/stickers/:stickerPackId',
    socket: 'v3.stickers.id.get',
  );

  static const acceptStickerPack = BackendPathModel(
    http: 'v3/stickers/:stickerPackId/add',
    socket: 'v3.stickers.accept.post',
  );

  static const favoriteStickerV3 = BackendPathModel(
    http: 'v3/stickers/:stickerPackId/favourite',
    socket: 'v3.stickers.favourite.post',
  );

  static const reorderStickerPacksToTheTop = BackendPathModel(
    http: 'v3/stickers/me/download-order',
    socket: 'v3.stickers.updateDownloadOrder.update',
  );

  static const reorderAllStickerPack = BackendPathModel(
    http: 'v3/stickers/me/reorder',
    socket: 'v3.stickers.reorder.update',
  );

  static const getAllMySticker = BackendPathModel(
    http: 'v3/stickers/me',
    socket: 'v3.stickers.me.get',
  );

  static const buyStickerV3 = BackendPathModel(
    http: 'v3/stickers/:stickerPackId/buy',
    socket: 'v3.stickers.buy.post',
  );

  static const checkOwnerStickerV3 = BackendPathModel(
    http: 'v3/stickers/:stickerPackId/checkOwner',
    socket: 'v3.stickers.checkOwner.post',
  );

  static const sendGiftStickerV3 = BackendPathModel(
    http: 'v3/stickers/:stickerPackId/buy',
    socket: 'v3.stickers.buy.post',
  );

  static const getHistorySticker = BackendPathModel(
    http: 'v3/stickers/me/history',
    socket: 'v3.stickers.me.history.get',
  );

  static const getReceivedStickerHistory = BackendPathModel(
    http: 'v3/stickers/me/history',
    socket: 'v3.stickers.me.history.get',
  );

  static const getSentStickerHistory = BackendPathModel(
    http: 'v3/stickers/me/history/sent',
    socket: 'v3.stickers.me.history.sent.get',
  );

  static const searchStickers = BackendPathModel(
    http: 'v3/stickers/search-cursor',
    socket: 'v3.stickers.searchCursor.get',
  );
}
