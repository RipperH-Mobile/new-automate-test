import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';
import 'package:uchat/features/coin/domain/enums/coin_history_tab.dart';
import 'package:uchat/features/coin/domain/enums/coin_transaction_type.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_coin_transaction_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_my_coin_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class CoinHistoryIds {
  CoinHistoryIds._();

  static const String coinHistoryBalance = 'coinHistoryBalance';
  static const String coinHistoryTab = 'coinHistoryTab';
  static const String coinHistoryAllList = 'coinHistoryAllList';
  static const String coinHistoryPurchaseList = 'coinHistoryPurchaseList';
  static const String coinHistoryUsageList = 'coinHistoryUsageList';
  static const String coinHistoryOffline = 'coinHistoryOffline';
}

typedef MapCoinTransactionSet = Map<CoinHistoryTab, Set<CoinTransactionEntity>>;

class CoinHistoryController extends GetxController with GetSingleTickerProviderStateMixin {
  bool isOffline = false;

  bool isLoadingCoinBalance = true;
  bool isLoadingCoinList = true;

  late TabController coinHistoryTabController;

  int coinBalance = 0;
  int currentPage = 1;
  int totalPage = -1;

  /// Scroll controller for each category tab
  final allScrollController = ScrollController();
  final purchaseScrollController = ScrollController();
  final usageScrollController = ScrollController();

  MapCoinTransactionSet coinTransactionSet = {
    CoinHistoryTab.all: {},
    CoinHistoryTab.purchase: {},
    CoinHistoryTab.usage: {},
  };

  @override
  onInit() {
    super.onInit();
    coinHistoryTabController = TabController(length: CoinHistoryTab.values.length, vsync: this);
    coinHistoryTabController.addListener(listenOnTabChanged);

    fetchInitialMyCoin();
    fetchInitialCoinHistory();

    allScrollController.addListener(() => listenScroll(CoinHistoryTab.all));
    purchaseScrollController.addListener(() => listenScroll(CoinHistoryTab.purchase));
    usageScrollController.addListener(() => listenScroll(CoinHistoryTab.usage));
  }

  Future<void> listenOnTabChanged() async {
    final tab = CoinHistoryTab.values[coinHistoryTabController.index];
    final historySet = coinTransactionSet[tab] ?? {};

    if (historySet.length < 20 && !isLoadingCoinList && currentPage < totalPage) {
      EasyThrottle.throttle(
        'get_initial_coin_history',
        const Duration(milliseconds: 500),
        () async {
          await fetchMoreCoinHistory();
        },
      );
    }
  }

  Future<void> listenScroll(CoinHistoryTab tab) async {
    ScrollController scrollController;
    switch (tab) {
      case CoinHistoryTab.all:
        scrollController = allScrollController;
        break;
      case CoinHistoryTab.purchase:
        scrollController = purchaseScrollController;
        break;
      case CoinHistoryTab.usage:
        scrollController = usageScrollController;
        break;
    }

    final currentPixel = scrollController.position.pixels;
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    if (shouldLoadMore && !isLoadingCoinList && currentPage < totalPage) {
      EasyThrottle.throttle(
        'get_more_coin_history',
        const Duration(milliseconds: 500),
        () async {
          await fetchMoreCoinHistory();
        },
      );
    }
  }

  Future<void> fetchInitialMyCoin() async {
    try {
      final myCoin = await GetIt.I<FetchMyCoinUseCase>().call(NoParams());
      coinBalance = myCoin?.coins ?? 0;
    } on FailedHostLookupException catch (_) {
      isOffline = true;
      update([CoinHistoryIds.coinHistoryOffline]);
    } catch (e, stackTrace) {
      _log.e('Error fetching my coin', e, stackTrace);
    } finally {
      isLoadingCoinBalance = false;
      update([CoinHistoryIds.coinHistoryBalance]);
    }
  }

  Future<void> fetchInitialCoinHistory() async {
    try {
      final (totalPage, transactions) = await GetIt.I<FetchCoinTransactionUseCase>().call(
        FetchCoinTransactionParams(page: currentPage),
      );

      this.totalPage = totalPage;
      coinTransactionSet = {
        CoinHistoryTab.all: transactions,
        CoinHistoryTab.purchase: transactions.where((t) => t.type == CoinTransactionType.topUp).toSet(),
        CoinHistoryTab.usage: transactions
            .where((t) => t.type == CoinTransactionType.spend || t.type == CoinTransactionType.refund)
            .toSet(),
      };
    } on FailedHostLookupException catch (_) {
      isOffline = true;
      update([CoinHistoryIds.coinHistoryOffline]);
    } catch (e, stackTrace) {
      _log.e('Error fetching coin history', e, stackTrace);
    } finally {
      isLoadingCoinList = false;
      update([
        CoinHistoryIds.coinHistoryAllList,
        CoinHistoryIds.coinHistoryPurchaseList,
        CoinHistoryIds.coinHistoryUsageList
      ]);
    }
  }

  Future<void> fetchMoreCoinHistory() async {
    if (isLoadingCoinList || currentPage >= totalPage) return;

    isLoadingCoinList = true;
    update([
      CoinHistoryIds.coinHistoryAllList,
      CoinHistoryIds.coinHistoryPurchaseList,
      CoinHistoryIds.coinHistoryUsageList
    ]);

    try {
      final (totalPage, transactions) = await GetIt.I<FetchCoinTransactionUseCase>().call(
        FetchCoinTransactionParams(page: ++currentPage),
      );

      this.totalPage = totalPage;
      coinTransactionSet[CoinHistoryTab.all]?.addAll(transactions);
      coinTransactionSet[CoinHistoryTab.purchase]
          ?.addAll(transactions.where((t) => t.type == CoinTransactionType.topUp));
      coinTransactionSet[CoinHistoryTab.usage]?.addAll(
          transactions.where((t) => t.type == CoinTransactionType.spend || t.type == CoinTransactionType.refund));
    } on FailedHostLookupException catch (_) {
      isOffline = true;
      update([CoinHistoryIds.coinHistoryOffline]);
    } catch (e, stackTrace) {
      _log.e('Error fetching more coin history', e, stackTrace);
    } finally {
      isLoadingCoinList = false;
      update([
        CoinHistoryIds.coinHistoryAllList,
        CoinHistoryIds.coinHistoryPurchaseList,
        CoinHistoryIds.coinHistoryUsageList
      ]);
    }
  }
}
