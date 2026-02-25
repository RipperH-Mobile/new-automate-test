import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';

class MessageTypeStickerV2 extends GetView<MessageTypeStickerV2Controller> {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeStickerV2({super.key, required this.message, required this.messageTag});

  @override
  String get tag => messageTag;

  String get widgetKey {
    final stickerPackId = message.meta?.stickerPack ?? '';
    final stickerFileId = message.meta?.stickerValue ?? '';

    return '${message.type?.value}-${message.ref ?? message.id}-$stickerPackId-$stickerFileId';
  }

  String get stickerPackId => message.meta?.stickerPack ?? '';

  String get stickerFileId => message.meta?.stickerValue ?? '';

  double get stickerSize => min(Get.width * 0.40, 200.spMin);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: controller.stickerWidgetKey,
      builder: (context, c) {
        return ContextMenuWidget(
          forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
          width: c.maxWidth,
          childBoxConstraints: BoxConstraints(
            maxWidth: stickerSize,
          ),
          longPressCallback: () {
            String mediaType = 'sticker';
            if (message.type != null) {
              mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
            }
            GetIt.I<TaxonomyService>()
                .sendEvent(EventName.longpressChatroom, eventProperties: EventProperty.longPressChatRoom(mediaType));
          },
          actions: controller.actions(message),
          topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
          topWidget: controller.canReact
              ? MessageReactionPopup(
                  messageTag: tag,
                )
              : null,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => controller.onOpenStickerDetail(),
            child: Obx(
              () {
                final visible =
                    !controller.enableWarMode() || (controller.enableWarMode() && controller.animatedDone());
                return Opacity(
                  opacity: visible ? 1 : 0,
                  child: buildSticker(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildSticker() {
    if (UChatConstant.fallbackStickerPackId.contains(stickerPackId)) {
      return RepaintBoundary(
        child: Image(
          key: ValueKey(widgetKey),
          image: AssetImage(
            'assets/stickers/$stickerPackId/$stickerFileId.webp',
          ),
          width: stickerSize,
        ),
      );
    } else {
      return RepaintBoundary(
        child: StickerItemPreview(
          packId: stickerPackId,
          fileId: stickerFileId,
          width: stickerSize,
          height: stickerSize,
        ),
      );
    }
  }
}
