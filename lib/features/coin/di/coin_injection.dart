import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/entities/services/announcement_db.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/coin/data/data_sources/remote/coin_http_data_source.dart';
import 'package:uchat/features/coin/data/data_sources/remote/coin_socket_data_source.dart';
import 'package:uchat/features/coin/data/repositories/coin_remote_repository_impl.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/features/coin/domain/use_cases/do_not_show_promotion_today_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_coin_packages_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_coin_transaction_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_my_coin_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/get_coin_ads_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/get_coin_promotion_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_pending_refund_reason_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/send_coin_refund_reason_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/verify_purchase_use_case.dart';

Future<void> registerCoinSingletonDependencies({
  required HttpCaller httpCaller,
  required SocketCaller socketCaller,
}) async {
  final getIt = GetIt.instance;

  final httpDataSource = getIt.registerSingleton<CoinHttpDataSource>(
    CoinHttpDataSource(httpCaller: httpCaller),
  );

  final socketDataSource = getIt.registerSingleton<CoinSocketDataSource>(
    CoinSocketDataSource(socketCaller: socketCaller),
  );

  getIt.registerSingleton<CoinRemoteRepository>(
    CoinRemoteRepositoryImpl(httpDataSource: httpDataSource, socketDataSource: socketDataSource),
  );
}

Future<void> registerCoinFactoryDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerFactory<GetCoinPromotionUseCase>(
    () => GetCoinPromotionUseCase(configDbGeneral: getIt<ConfigDb>().general, announcementDb: getIt<AnnouncementDb>()),
  );

  getIt.registerFactory<DoNotShowPromotionTodayUseCase>(
    () => DoNotShowPromotionTodayUseCase(configDbGeneral: getIt<ConfigDb>().general),
  );

  getIt.registerFactory<FetchMyCoinUseCase>(
    () => FetchMyCoinUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );
  getIt.registerFactory<FetchPendingRefundReasonUseCase>(
    () => FetchPendingRefundReasonUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );
  getIt.registerFactory<SendCoinRefundReasonUseCase>(
    () => SendCoinRefundReasonUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );

  getIt.registerFactory<FetchCoinPackagesUseCase>(
    () => FetchCoinPackagesUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );

  getIt.registerFactory<FetchCoinTransactionUseCase>(
    () => FetchCoinTransactionUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );

  getIt.registerFactory<VerifyPurchaseUseCase>(
    () => VerifyPurchaseUseCase(coinRemoteRepository: getIt<CoinRemoteRepository>()),
  );

  getIt.registerFactory<GetCoinAdsUseCase>(
    () => GetCoinAdsUseCase(announcementDb: getIt<AnnouncementDb>()),
  );
}
