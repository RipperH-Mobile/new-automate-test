import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/use_cases/use_case.dart';

class SyncHandleUpdateMessageBookmarkTagsParams {
  final List<BookmarkTagModel> bookmarkEmojiTags;

  SyncHandleUpdateMessageBookmarkTagsParams({required this.bookmarkEmojiTags});
}

class SyncHandleUpdateMessageBookmarkTagsUseCase
    implements SimpleUseCase<List<BookmarkTagModel>?, SyncHandleUpdateMessageBookmarkTagsParams> {
  @override
  Future<List<BookmarkTagModel>?> call(SyncHandleUpdateMessageBookmarkTagsParams params) async {
    try {
      final addedTags = UserController.instance.currentUser()?.allBookmarkEmojiTags;

      if (addedTags == null) return null;

      List<BookmarkTagModel> result = [];

      for (int i = 0; i < params.bookmarkEmojiTags.length; i++) {
        final index = addedTags.indexWhere((e) => e.emojiTagId == params.bookmarkEmojiTags[i].emojiTagId);

        if (index != -1) {
          result.add(addedTags[index]);
        }
      }

      return result;
    } catch (e, stackTrace) {
      useLogger().e('updateMessageBookmarkTags error.', e, stackTrace);
    }

    return null;
  }
}
