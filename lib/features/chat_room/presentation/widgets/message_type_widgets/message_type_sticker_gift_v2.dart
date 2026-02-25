import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_gift_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeStickerGiftV2 extends GetView<MessageTypeStickerGiftV2Controller> {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeStickerGiftV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  bool get isMyMessage => message.mine;

  @override
  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return ContextMenuWidget(
        forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
        width: c.maxWidth,
        longPressCallback: () {
          String mediaType = 'sticker_gift';
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
        child: InkWell(
          onTap: () => controller.onGoToStickerGift(
            message.meta?.stickerPack ?? '',
            isGift: isMyMessage == false,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpace.space3),
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              color: isMyMessage
                  ? context.theme.appColors.backgroundPrimary
                  : context.theme.appColors.backgroundNeutralLight,
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StickerItemPreview(
                  packId: message.meta?.stickerPack ?? '',
                  fileId: message.meta?.stickerCoverId ?? '',
                  height: AppSize.size24,
                  width: AppSize.size24,
                ),
                AppSpace.space2.verticalSpace,
                AppText.body3(
                  message.mine ? message.meta?.stickerName ?? '' : 'You have received a gift!'.tr,
                  color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
                  maxLines: 2,
                  context: context,
                ),
                AppSpace.space3.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.space2, horizontal: AppSpace.space10),
                  decoration: BoxDecoration(
                    color: isMyMessage
                        ? context.theme.appColors.backgroundPrimaryBolder
                        : context.theme.appColors.backgroundNeutralLightPressed,
                    borderRadius: const BorderRadius.all(Radius.circular(AppSpace.space2)),
                  ),
                  child: AppText.caption1Bold(
                    message.mine ? 'View sticker'.tr : 'Receive a gift'.tr,
                    color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDark,
                    maxLines: 2,
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
