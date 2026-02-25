import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_my_coin_use_case.dart';
import 'package:uchat/features/sticker/data/models/payloads/coin_sticker_payload.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/features/sticker/domain/events/favorite_sticker_event.dart';
import 'package:uchat/features/sticker/domain/events/sticker_pack_download_status_event.dart';
import 'package:uchat/features/sticker/domain/use_cases/acquire_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/buy_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/favorite_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sticker_detail_use_case.dart';
import 'package:uchat/features/sticker/presentation/arguments/sticker_gift_choose_friend_argument.dart';
import 'package:uchat/features/sticker/presentation/arguments/sticker_pack_detail_argument.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class StickerPackDetailIds {
  StickerPackDetailIds._();

  static const String likeButton = 'sticker-pack-detail-like-button';
  static const String header = 'sticker-pack-detail-header';
  static const String downloadButton = 'sticker-pack-detail-download-button';
  static const String itemGrid = 'sticker-pack-detail-item-grid';
  static const String rightButton = 'sticker-detail-right-button';
  static const String buttonRow = 'sticker-detail-button-row';
}

class StickerPackDetailController extends GetxController {
  late final String stickerPackId;
  late final bool? isGift;

  StickerPackDetailController({
    required this.stickerPackId,
    bool? isGift = false,
  }) {
    this.isGift = isGift ?? false;

    if (Get.arguments != null && Get.arguments is StickerPackDetailArgument) {
      final argument = Get.arguments as StickerPackDetailArgument;
      this.isGift = argument.isGift;
    }
  }

  StoreStickerPackEntity? stickerPack;
  bool isLoadingStickerDetail = false;
  StickerDownloadStatus downloadStatus = StickerDownloadStatus.idle;
  double downloadProgress = 0.0;
  String selectedFileId = '';

  int currentCoin = 0;

  StreamSubscription? downloadStatusSubscription;

  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;

  bool get isFavorite {
    if (stickerPack == null) return false;
    return stickerPack?.isFavorite ?? false;
  }

  StickerDownloaderService get stickerDownloaderService => GetIt.I<StickerDownloaderService>();

  @override
  void onInit() {
    super.onInit();
    initialize();
    _loadWarModeConfig();

    downloadStatusSubscription = eventBus.on<StickerPackDownloadStatusEvent>().listen(onStickerPackDownloading);
  }

  @override
  onClose() {
    downloadStatusSubscription?.cancel();
    super.onClose();
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
    refresh();
  }

  Future<void> initialize() async {
    try {
      isLoadingStickerDetail = true;
      update([StickerPackDetailIds.header, StickerPackDetailIds.itemGrid]);

      await Future.wait([getCurrentCoin(), getStickerPackDetail()]);
      await initializeDownloadStatus();

      final previousRoute = Get.previousRoute;

      String entryPoint = 'unknown';
      if (previousRoute.startsWith('/sticker')) {
        entryPoint = 'sticker page';
      } else if (previousRoute.startsWith('/chat-room')) {
        entryPoint = 'chat room';
      }

      GetIt.I<TaxonomyService>().sendEvent(
        EventName.stickerDetailViewed,
        eventProperties: EventProperty.stickerDetailViewed(
          stickerPack?.name ?? 'UNKNOWN'.tr,
          stickerPack?.publisher ?? 'UNKNOWN'.tr,
          stickerPack?.price ?? 0,
          stickerPack?.price == 0,
          entryPoint,
        ),
      );
    } on FailedHostLookupException catch (_) {
      Get.back();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('initialize error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      isLoadingStickerDetail = false;
      update([
        StickerPackDetailIds.header,
        StickerPackDetailIds.itemGrid,
        StickerPackDetailIds.likeButton,
      ]);
    }
  }

  Future<void> initializeDownloadStatus() async {
    final stickerList = stickerPack?.stickerItems;
    if (stickerList == null || stickerList.isEmpty) {
      downloadStatus = StickerDownloadStatus.idle;
      downloadProgress = 0.0;
      return;
    }

    final isDownloaded = await stickerDownloaderService.isPackDownloaded(
      packId: stickerPackId,
      stickerCount: stickerList.length,
    );
    if (isDownloaded) {
      downloadStatus = StickerDownloadStatus.completed;
      downloadProgress = 1.0;
      return;
    }

    final isInQueue = stickerDownloaderService.isInQueue(stickerPackId);
    if (isInQueue) {
      final (status, progress) = stickerDownloaderService.getDownloadProgress(stickerPackId);
      if (status.isInProgress) {
        downloadStatus = status;
        downloadProgress = progress;
        return;
      }

      if (status.isInQueue) {
        downloadStatus = StickerDownloadStatus.inQueue;
        downloadProgress = 0.0;
        return;
      }

      return;
    }

    downloadStatus = StickerDownloadStatus.idle;
    downloadProgress = 0.0;
  }

  void onTapSticker(String fileId) {
    if (selectedFileId == fileId) {
      selectedFileId = '';
    } else {
      selectedFileId = fileId;
    }

    update([StickerPackDetailIds.itemGrid]);
  }

  Future<void> onStickerPackDownloading(StickerPackDownloadStatusEvent event) async {
    if (event.packId != stickerPackId) return;

    downloadStatus = event.status;
    downloadProgress = event.progress;

    if (event.status.isCompleted) {
      // If the sticker pack is downloaded, we can update the sticker pack state.
      stickerPack = stickerPack?.copyWith(isDownloaded: true);
      update([StickerPackDetailIds.downloadButton]);
    }

    update([StickerPackDetailIds.downloadButton]);
  }

  Future<void> getCurrentCoin() async {
    final coin = await GetIt.I<FetchMyCoinUseCase>().call(NoParams());
    if (coin != null) {
      currentCoin = coin.coins;
      update([StickerPackDetailIds.header]);
    } else {
      _log.e('Failed to fetch current coins.');
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  Future<void> getStickerPackDetail() async {
    stickerPack = await GetIt.I<FetchStickerDetailUseCase>().call(
      FetchStickerDetailParams(stickerPackId: stickerPackId),
    );

    if (stickerPack == null || stickerPack?.isPublish != true) {
      Get.back();
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  Future<bool?> onTapHeartButton(bool value) async {
    try {
      await GetIt.I<FavoriteStickerPackUseCase>().call(
        FavoriteStickerPackParams(stickerPackId: stickerPackId),
      );

      stickerPack = stickerPack?.copyWith(isFavorite: !value);
      update([StickerPackDetailIds.likeButton]);
      eventBus.fire(
        FavoriteStickerEvent(
          packId: stickerPackId,
          isFavorite: !value,
        ),
      );

      return stickerPack?.isFavorite ?? false;
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('onTapHeartButton error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      });
      return null;
    }
  }

  Future<void> onTapShareButton() async {
    if (ConnectivityController.instance.isOffline) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      return;
    }
    if (stickerPack == null) {
      // If stickerPack is null, Do nothing.
      return;
    }
    GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        newMessage: MessageCollection(
          type: MessageType.stickerSharing,
          meta: MessageMetaModel(
            stickerPack: stickerPackId,
            stickerCoverId: stickerPack?.coverId ?? '',
            stickerName: stickerPack?.name ?? 'UNKNOWN'.tr,
            stickerDescription: stickerPack?.description,
            stickerPrice: stickerPack?.price ?? 0.0,
          ),
        ),
      ),
    );
  }

  Future<void> onAcquireStickerPack(String packId) async {
    try {
      final stickerResult = await GetIt.I<AcquireStickerPackUseCase>().call(
        AcquireStickerPackParams(stickerPackId: packId),
      );

      if (stickerResult == null) {
        _log.e('Failed to acquire sticker pack with id: $packId');
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        return;
      } else {
        stickerPack = stickerResult;
        update([StickerPackDetailIds.header, StickerPackDetailIds.downloadButton]);
      }
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleAcceptStickerPack error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      });
    }
  }

  Future<void> onTapDownloadPack() async {
    if (stickerPack == null) return;

    try {
      await stickerDownloaderService.downloadStickerPack<StoreStickerPackEntity>(stickerPack: stickerPack!);
      downloadStatus = StickerDownloadStatus.inQueue;
      downloadProgress = 0.0;
      update([StickerPackDetailIds.downloadButton]);
    } on NoInternetException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      _log.e('onTapDownloadPack ApiException error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
    } catch (e, stackTrace) {
      _log.e('onTapDownloadPack error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> onTapDeletePack() async {
    if (stickerPack == null) return;
    try {
      await stickerDownloaderService.deleteStickerPack(packId: stickerPack!.id);
      stickerPack = stickerPack?.copyWith(isDownloaded: false);
      downloadStatus = StickerDownloadStatus.idle;
      downloadProgress = 0.0;
      update([StickerPackDetailIds.downloadButton]);
    } catch (e, stackTrace) {
      _log.e('onTapDeletePack error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handlePurchasePressed() async {
    if (stickerPack == null) return;
    try {
      final coin = await GetIt.I<FetchMyCoinUseCase>().call(NoParams());
      if (coin == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        return;
      }
      if (coin.coins >= stickerPack!.price) {
        UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Purchase this sticker'.tr,
          description: 'Would you like to confirm the purchase of this sticker for @amount coins?'.trParams({
            'amount': stickerPack!.price.toInt().toString(),
          }),
          cancelText: 'Cancel'.tr,
          confirmText: 'Confirm'.tr,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
          onConfirm: () async {
            try {
              final response = await GetIt.I<BuyStickerUseCase>().call(stickerPack!.id);
              stickerPack = stickerPack?.copyWith(isOwner: true);
              List<String> updateUiList = [StickerPackDetailIds.rightButton];

              if (response?.coin != null) {
                currentCoin = response!.coin!.coins;
                updateUiList.add(StickerPackDetailIds.header);
              }

              update(updateUiList);

              GetIt.I<TaxonomyService>().sendEvent(
                EventName.stickerPurchased,
                eventProperties: EventProperty.stickerPurchased(
                  stickerPack?.name ?? 'UNKNOWN'.tr,
                  stickerPack?.publisher ?? 'UNKNOWN'.tr,
                  stickerPack?.price ?? 0.0,
                ),
              );
              UChatNewDialog.showPurchasedStickerSuccessDialog(packId: stickerPack!.id, fileId: stickerPack!.coverId);
            } on FailedHostLookupException catch (_) {
              UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
            } on ApiException catch (e, stackTrace) {
              switch (e.type) {
                case 'ERR_ACCOUNT_NOT_FOUND':
                case 'ERR_TARGET_ACCOUNT_NOT_FOUND':
                case 'ERR_ROOM_ACCOUNT_IS_NOT_FRIEND':
                case 'ERR_ROOM_ACCOUNT_IS_BLOCK_FRIEND':
                case 'ERR_STICKER_NOT_FOUND':
                case 'ERR_STICKER_NOT_FOR_SALE':
                case 'ERR_STICKER_NAME_IS_DUPLICATE':
                  _log.e('handlePurchasePressed was unsuccessful.', e, stackTrace);
                  UChatNewDialog.showSingleButtonDialog(
                    context: Get.context!,
                    title: 'Your purchase was unsuccessful. Please try again.'.tr,
                    confirmTextColor: Get.context!.theme.appColors.textPrimary,
                  );
                  break;
                case 'ERR_COIN_NOT_ENOUGH':
                  UChatNewDialog.showCoinNotEnoughDialog();
                  break;
                default:
                  _log.e('handlePurchasePressed ApiException error.', e, stackTrace);
                  UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
                  break;
              }
            } catch (e, stackTrace) {
              _log.e('handlePurchasePressed error: ', e, stackTrace);
              UChatNewDialog.showGeneralErrorDialog(
                context: Get.context!,
                e: e is Exception ? e : null,
              );
            }
          },
        );
      } else {
        UChatNewDialog.showCoinNotEnoughDialog();
      }
    } on PlatformException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handlePurchasePressed error: ', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handleSendAsGiftPressed() async {
    if (stickerPack == null) return;
    final response = await Get.toNamed(
      Routes.stickerGiftChooseFriend,
      arguments: StickerGiftChooseFriendArgument(
        stickerPack: stickerPack!,
      ),
    );
    if (response != null && response is CoinStickerResponse) {
      currentCoin = response.coins;
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.stickerSentAsGift,
        eventProperties: EventProperty.stickerSentAsGift(
          stickerPack?.name ?? 'UNKNOWN'.tr,
          stickerPack?.publisher ?? 'UNKNOWN'.tr,
        ),
      );
      update([StickerPackDetailIds.header]);
    }
  }
}
