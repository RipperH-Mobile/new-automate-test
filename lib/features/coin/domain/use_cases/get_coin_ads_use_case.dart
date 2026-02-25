import 'package:uchat/entities/collections/announcement_collection.dart';
import 'package:uchat/entities/services/announcement_db.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetCoinAdsParams {
  final String currentRoute;

  GetCoinAdsParams({this.currentRoute = ''});
}

class GetCoinAdsUseCase extends SimpleUseCase<AnnouncementCollection?, GetCoinAdsParams> {
  final AnnouncementDb announcementDb;

  GetCoinAdsUseCase({required this.announcementDb});

  @override
  Future<AnnouncementCollection?> call(GetCoinAdsParams params) async {
    final coinAdsList = await announcementDb.getCoinAds();
    final coinAds = coinAdsList.firstOrNull;

    if (coinAds == null) {
      return null;
    }

    final now = DateTime.now();

    if (now.isAfter(coinAds.expireAt)) {
      return null;
    }

    return coinAds;
  }
}
