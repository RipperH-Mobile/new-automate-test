import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/bookmark_tag_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

typedef IsarBookmarkTagCollection = IsarCollection<BookmarkTagCollection>;
typedef BookmarkTagCollectionList = List<BookmarkTagCollection>;
typedef MessageQueryAfterSortBy = QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>;

class BookmarkTagDb {
  // Singleton pattern
  static final BookmarkTagDb instance = BookmarkTagDb._internal();

  factory BookmarkTagDb() => instance;

  BookmarkTagDb._internal();

  // Start body
  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarBookmarkTagCollection get bookmarkTagCollection {
    return dbInstance.bookmarkTag;
  }

  static const namePrefix = 'bookmarkTag';

  Future<List<BookmarkTagCollection>?> getAllBookmarkTags({required String msgId}) async {
    return bookmarkTagCollection.where().emojiTagIdIsNotNull().findAll();
  }

  Future<BookmarkTagCollection?> getBookmarkTagByMsgId({required String msgId}) async {
    return bookmarkTagCollection.where().msgIdEqualTo(msgId).findFirst();
  }

  Future<List<BookmarkTagCollection>?> getAllBookmarkTagByMsgId({required String msgId}) async {
    return bookmarkTagCollection.where().msgIdEqualTo(msgId).sortByCreatedAt().findAll();
  }

  Future<void> putBookmarkTag(BookmarkTagCollection bookmarkTag) async {
    await dbInstance.writeTxn(() async {
      try {
        final localBookmarkTag = await getBookmarkTagByMsgId(
          msgId: bookmarkTag.msgId!,
        );
        if (localBookmarkTag != null) {
          // if update bookmarkTag
          localBookmarkTag.update(bookmarkTag);
          await bookmarkTagCollection.put(localBookmarkTag);
        } else {
          // if new bookmarkTag
          await bookmarkTagCollection.put(bookmarkTag);
        }
      } catch (e, stacktrace) {
        _log.e('putBookmarkTag error', e, stacktrace);
        return null;
      }
    });
  }

  Future<BookmarkTagCollection?> putBookmarkTagWithoutTxn(
    BookmarkTagCollection bookmarkTag,
  ) async {
    try {
      final localBookmarkTag = await getBookmarkTagByMsgId(
        msgId: bookmarkTag.msgId!,
      );
      if (localBookmarkTag != null) {
        // if update bookmarkTag
        localBookmarkTag.update(bookmarkTag);
        await bookmarkTagCollection.put(localBookmarkTag);

        return localBookmarkTag;
      } else {
        // if new bookmarkTag
        await bookmarkTagCollection.put(bookmarkTag);

        return await getBookmarkTagByMsgId(msgId: bookmarkTag.msgId!);
      }
    } catch (e, stacktrace) {
      _log.e('putBookmarkTagWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> putAllBookmarkTag(List<BookmarkTagCollection> bookmarkTag) async {
    await dbInstance.writeTxn(() async {
      await bookmarkTagCollection.putAll(bookmarkTag);
    });
  }

  Future<void> putAllBookmarkTagWithoutTxn(List<BookmarkTagCollection> bookmarkTag) async {
    await bookmarkTagCollection.putAll(bookmarkTag);
  }

  Future<void> deleteAllBookmarkTagByEmojiTagId({required String id}) async {
    await dbInstance.writeTxn(() async {
      await bookmarkTagCollection.where().emojiTagIdEqualTo(id).deleteAll();
    });
  }

  Future<void> deleteAllBookmarkTagByIdWithoutTxn({required String id}) async {
    await bookmarkTagCollection.where().emojiTagIdEqualTo(id).deleteAll();
  }

  Future<void> deleteAllBookmarkTagByMsgId({required String msgId}) async {
    await dbInstance.writeTxn(() async {
      await bookmarkTagCollection.where().msgIdEqualTo(msgId).deleteAll();
    });
  }

  Future<void> deleteAllBookmarkTagByMsgIdWithoutTxn({required String msgId}) async {
    await bookmarkTagCollection.where().msgIdEqualTo(msgId).deleteAll();
  }

  Future<void> deleteBookmarkTagById({required String id}) async {
    await dbInstance.writeTxn(() async {
      await bookmarkTagCollection.delete(fastHash(id));
    });
  }

  Future<void> deleteBookmarkTagByIdWithoutTxn({required String id}) async {
    await bookmarkTagCollection.delete(fastHash(id));
  }

  Future<void> clearCollection() async {
    await dbInstance.writeTxn(() async {
      await bookmarkTagCollection.clear();
    });
  }

  Future<void> clearCollectionWithoutTxn() async {
    await bookmarkTagCollection.clear();
  }
}
