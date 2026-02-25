import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/announcement_collection.dart';
import 'package:uchat/entities/manager.dart';

typedef IsarAnnouncementCollection = IsarCollection<AnnouncementCollection>;

class AnnouncementDb {
  // Dependency injection for testing
  Isar? customDbInstance;

  AnnouncementDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().generalInstance!;
  }

  IsarAnnouncementCollection get announcementCollection {
    return dbInstance.announcement;
  }

  Future<void> putAnnouncements({required List<AnnouncementCollection> announcements}) async {
    await dbInstance.writeTxn(() async {
      await announcementCollection.putAll(announcements);
    });
  }

  Future<List<AnnouncementCollection>> getAnnouncement() async {
    return announcementCollection
        .filter()
        .announceTypeEqualTo('ANNOUNCE')
        .announceAtLessThan(DateTime.now())
        .expireAtGreaterThan(DateTime.now())
        .deletedEqualTo(false)
        .sortByAnnounceAtDesc()
        .limit(4)
        .findAll();
  }

  Future<AnnouncementCollection?> getMaintenance() async {
    return await announcementCollection
        .filter()
        .announceTypeEqualTo('MAINTENANCE')
        .announceAtLessThan(DateTime.now())
        .expireAtGreaterThan(DateTime.now())
        .deletedEqualTo(false)
        .sortByAnnounceAt()
        .findFirst();
  }

  Future<List<AnnouncementCollection>> getCoinPromotion() async {
    return announcementCollection
        .filter()
        .announceTypeEqualTo('COIN')
        .announceAtLessThan(DateTime.now())
        .expireAtGreaterThan(DateTime.now())
        .deletedEqualTo(false)
        .sortByAnnounceAt()
        .limit(1)
        .findAll();
  }

  Future<List<AnnouncementCollection>> getCoinAds() async {
    return announcementCollection
        .filter()
        .announceTypeEqualTo('COIN_ADS')
        .announceAtLessThan(DateTime.now())
        .expireAtGreaterThan(DateTime.now())
        .deletedEqualTo(false)
        .sortByAnnounceAtDesc()
        .limit(1)
        .findAll();
  }
}
