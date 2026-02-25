import 'package:get/get.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/app_env.dart';
import 'message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/gen/assets.gen.dart';

class MessageTypeStickerSharingV2Controller extends MessageTypeController {
  MessageTypeStickerSharingV2Controller({required super.initMessage});

  @override
  handleCopy() async {
    Get.back();
    await Clipboard.setData(
      ClipboardData(
        text: '${'Sticker "@name" available on UChat. Download now !!!'.trParams(
          {
            'name': initMessage.meta?.stickerName ?? '',
          },
        )} \n'
            '${AppEnv.stickerSharingPrefix}${initMessage.meta?.stickerPack}',
      ),
    );
    AppToast.showToast(
      context: Get.context!,
      message: 'Copied message to clipboard'.tr,
      icon: Assets.vectors.contentCopy.svg(
        colorFilter: ColorFilter.mode(
          Get.context!.theme.appColors.iconPrimaryInverse,
          BlendMode.srcIn,
        ),
      ),
      sbMargin: const EdgeInsets.only(bottom: 42), // chat input height
    );
  }

  Future<void> onGoToSticker(String packId) async {
    if (packId.isEmpty) return;

    await Get.toNamed(
      Routes.stickerDetail.replaceAll(':stickerPackId', packId),
      arguments: {'isGift': false},
    );
  }
}
