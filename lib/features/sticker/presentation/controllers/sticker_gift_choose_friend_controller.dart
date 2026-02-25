import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_my_coin_use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_chat_with_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';
import 'package:uchat/features/sticker/data/models/payloads/send_gift_payload.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_recent_chat_sticker_gift_target_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/send_gift_sticker_use_case.dart';
import 'package:uchat/features/sticker/presentation/arguments/sticker_gift_choose_friend_argument.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class StickerGiftChooseFriendIds {
  StickerGiftChooseFriendIds._();

  static const String body = 'sticker_gift_choose_friend_body';
  static const String recentChatText = 'sticker_gift_recent_chat_text';
  static const String recentChatList = 'sticker_gift_recent_chat_list';
  static const String contactText = 'sticker_gift_contact_text';
  static const String contactList = 'sticker_gift_contact_list';
}

final _log = useLogger();

class StickerGiftChooseFriendController extends GetxController {
  List<ContactEntity> recentChatList = [];
  List<ContactEntity> contactList = [];

  final searchTextFieldController = TextEditingController();

  @override
  void onInit() async {
    try {
      final result = await GetIt.I<GetCanChatWithContactUseCase>().call(NoParams());
      contactList = result;
      recentChatList = await GetIt.I<GetRecentChatStickerGiftTargetUseCase>().call(
        GetRecentChatStickerGiftTargetParams(),
      );
    } catch (e, stackTrace) {
      _log.e('init sticker gift choose friend error', e, stackTrace);
    }

    update([
      StickerGiftChooseFriendIds.recentChatText,
      StickerGiftChooseFriendIds.recentChatList,
      StickerGiftChooseFriendIds.contactText,
      StickerGiftChooseFriendIds.contactList,
    ]);

    super.onInit();
  }

  @override
  void onClose() {
    searchTextFieldController.dispose();
    super.onClose();
  }

  void onSearchTextFieldChanged(String value) async {
    final result = await GetIt.I<SearchCanChatWithContactUseCase>().call(value);
    contactList = result;
    recentChatList = await GetIt.I<GetRecentChatStickerGiftTargetUseCase>().call(
      GetRecentChatStickerGiftTargetParams(
        keyword: value.isNotEmpty ? value : null,
      ),
    );

    update([
      StickerGiftChooseFriendIds.body,
      StickerGiftChooseFriendIds.recentChatText,
      StickerGiftChooseFriendIds.recentChatList,
      StickerGiftChooseFriendIds.contactText,
      StickerGiftChooseFriendIds.contactList,
    ]);
  }

  Future<void> handleGiftSticker(ContactEntity entity) async {
    try {
      String platform = '';
      if (Platform.isIOS) {
        platform = 'APPLE';
      } else if (Platform.isAndroid) {
        platform = 'GOOGLE_PLAY';
      }
      final arg = Get.arguments as StickerGiftChooseFriendArgument;
      String stickerId = arg.stickerPack.id;
      if (entity.id == null || platform.isEmpty) {
        return;
      }

      final coin = await GetIt.I<FetchMyCoinUseCase>().call(NoParams());
      if (coin == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        return;
      }
      if (coin.coins >= arg.stickerPack.price) {
        UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Send sticker to @name'.trParams({'name': entity.name ?? 'UNKNOWN'.tr}),
          description: 'Would you like to confirm the purchase of this sticker for @amount coins?'.trParams({
            'amount': arg.stickerPack.price.toInt().toString(),
          }),
          cancelText: 'Cancel'.tr,
          confirmText: 'Send as gift'.tr,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
          onConfirm: () async {
            try {
              final response = await GetIt.I<SendGiftStickerUseCase>().call(SendGiftRequest(
                stickerId: stickerId,
                type: 'GIFT',
                platform: platform,
                targetAccountId: entity.id!,
              ));
              Get.back(result: response?.coin);

              UChatNewDialog.showSendGiftStickerSuccessDialog(
                packId: arg.stickerPack.id,
                fileId: arg.stickerPack.coverId,
                friendName: entity.name ?? 'UNKNOWN'.tr,
              );
            } on FailedHostLookupException catch (_) {
              UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
            } on ApiException catch (e, stackTrace) {
              switch (e.type) {
                case 'ERR_ACCOUNT_NOT_FOUND':
                case 'ERR_TARGET_ACCOUNT_NOT_FOUND':
                case 'ERR_ROOM_ACCOUNT_IS_NOT_FRIEND':
                case 'ERR_STICKER_NOT_FOUND':
                case 'ERR_STICKER_NOT_FOR_SALE':
                  _log.e('handlePurchasePressed was unsuccessful.', e, stackTrace);
                  UChatNewDialog.showSingleButtonDialog(
                    context: Get.context!,
                    title: 'Your purchase was unsuccessful. Please try again.'.tr,
                    confirmTextColor: Get.context!.theme.appColors.textPrimary,
                  );
                  break;
                case 'ERR_ROOM_ACCOUNT_IS_BLOCK_FRIEND':
                case 'ERR_STICKER_NAME_IS_DUPLICATE':
                  UChatNewDialog.showSingleButtonDialog(
                    context: Get.context!,
                    title: 'Your friend already has this sticker'.tr,
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
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleGiftSticker error', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }
}
