import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/date.dart';

class GetCoinPromotionParams {
  final String currentRoute;

  GetCoinPromotionParams({this.currentRoute = ''});
}

class GetCoinPromotionUseCase extends SimpleUseCase<AnnouncementCollection?, GetCoinPromotionParams> {
  final ConfigInstance configDbGeneral;
  final AnnouncementDb announcementDb;

  GetCoinPromotionUseCase({required this.configDbGeneral, required this.announcementDb});

  @override
  Future<AnnouncementCollection?> call(GetCoinPromotionParams params) async {
    if (params.currentRoute.isEmpty) {
      // If current route is empty, we assume it's not a valid route to show the promotion.
      return null;
    }

    if (params.currentRoute != Routes.coinStore) {
      // If current route is not CoinStore, we don't show the promotion.
      return null;
    }

    final announcementList = await announcementDb.getCoinPromotion();
    final coinPromotion = announcementList.firstOrNull;

    if (coinPromotion == null) {
      return null;
    }

    final now = DateTime.now();

    if (now.isAfter(coinPromotion.expireAt)) return null;

    final dateTime = await configDbGeneral.getDateTime(
      key: ConfigDb.getDontShowCoinPromotionDateTimeConfigKey(),
    );

    // Don't show dialog if user press don't show again today.
    if (dateTime != null && now.isSameDay(dateTime)) {
      return null;
    }

    return coinPromotion;
  }
}
