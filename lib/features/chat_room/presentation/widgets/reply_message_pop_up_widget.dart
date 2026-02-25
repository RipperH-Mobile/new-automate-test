import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class ReplyMessagePopUpWidget extends StatelessWidget {
  final MessageEntity message;
  final Function() onTapClose;

  const ReplyMessagePopUpWidget({
    super.key,
    required this.message,
    required this.onTapClose,
  });

  @override
  Widget build(BuildContext context) {
    if (message.type == null) return const SizedBox.shrink();

    switch (message.type) {
      case MessageType.sticker:
        return replyMessagePopup(
          context,
          Expanded(
            child: Row(
              children: [
                if (message.meta?.stickerPack != null && message.meta?.stickerValue != null)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpace.space3),
                    child: StickerItemPreview(
                      packId: message.meta!.stickerPack!,
                      fileId: message.meta!.stickerValue!,
                      width: AppSpace.space10,
                      height: AppSpace.space10,
                    ),
                  ),
                columnShowText(context, description: 'Sticker'.tr),
              ],
            ),
          ),
        );
      case MessageType.stickerSharing:
        return replyMessagePopup(
          context,
          Expanded(
            child: Row(
              children: [
                if (message.meta?.stickerPack != null && message.meta?.stickerCoverId != null)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpace.space3),
                    child: StickerItemPreview(
                      packId: message.meta!.stickerPack!,
                      fileId: message.meta!.stickerCoverId!,
                      width: AppSpace.space10,
                      height: AppSpace.space10,
                    ),
                  ),
                columnShowText(context, description: 'Sticker'.tr),
              ],
            ),
          ),
        );
      case MessageType.gif:
        String? imageUrl = message.meta?.gifUrl;

        return replyMessagePopup(
          context,
          Expanded(
            child: Row(
              children: [
                if (imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpace.space3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpace.space2),
                      child: UChatImage.network(
                        imageUrl,
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.cover,
                        height: AppSpace.space10,
                        width: AppSpace.space10,
                      ),
                    ),
                  ),
                columnShowText(context, description: 'GIF'.tr),
              ],
            ),
          ),
        );

      case MessageType.image:
        String? imageUrl = message.file?.apiFileUrl;

        return replyMessagePopup(
          context,
          Expanded(
            child: Row(
              children: [
                if (imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpace.space3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpace.space2),
                      child: UChatImage.network(
                        imageUrl,
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.cover,
                        height: AppSpace.space10,
                        width: AppSpace.space10,
                      ),
                    ),
                  ),
                columnShowText(context, description: 'Photo'.tr),
              ],
            ),
          ),
        );
      case MessageType.file:
        return replyMessagePopup(
          context,
          columnShowText(context, description: message.file?.name),
        );
      case MessageType.video:
        String? imageUrl = FileService().getFileUrl(message.file?.thumbnailFileId ?? '');

        return replyMessagePopup(
          context,
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSpace.space3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpace.space2),
                    child: UChatImage.network(
                      imageUrl,
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.cover,
                      height: AppSpace.space10,
                      width: AppSpace.space10,
                    ),
                  ),
                ),
                columnShowText(context, description: 'Video'.tr),
              ],
            ),
          ),
        );
      case MessageType.audio:
        return replyMessagePopup(
          context,
          columnShowText(context, description: 'Audio'.tr),
        );
      case MessageType.album:
        return replyMessagePopup(
          context,
          columnShowText(context,
              description: 'Album : @albumName'.trParams({'albumName': message.meta?.albumName ?? ''})),
        );
      case MessageType.location:
        return replyMessagePopup(
          context,
          columnShowText(context, description: message.meta?.locationName ?? ''),
        );
      default:
        return replyMessagePopup(
          context,
          columnShowText(context),
        );
    }
  }

  Widget replyMessagePopup(BuildContext context, Widget content) {
    return Container(
      height: AppSpace.space18,
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLighter,
        border: Border(
          top: BorderSide(
            color: context.theme.appColors.backgroundGrayLightestPressed,
            width: AppSpace.spacePx,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space4,
        top: AppSpace.space3,
        bottom: AppSpace.space3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          content,
          iconClose(),
        ],
      ),
    );
  }

  Widget iconClose() {
    return GestureDetector(
      onTap: () {
        onTapClose();
      },
      child: Assets.vectors.iconCloseNoBorder.svg(),
    );
  }

  Widget columnShowText(
    BuildContext context, {
    String? description,
  }) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText.body4(
              'Replying to '.tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
            Expanded(
              child: AppText.body4Bold(
                (UserController.instance.currentUser()?.id == message.accountId)
                    ? 'yourself'.tr
                    : '@name'.trParams({
                        'name': getNameHelper(
                          id: message.accountId,
                          fallback: message.account?.showName ?? 'UNKNOWN'.tr,
                          roomId: message.roomId,
                        ),
                      }),
                context: context,
                color: context.theme.appColors.textDark,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.space1),
        description != null
            ? AppText.body3(
                description,
                context: context,
                textOverflow: TextOverflow.ellipsis,
                color: context.theme.appColors.textDarkest,
              )
            : MentionTextParse(
                message: message.message ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.theme.appColors.textDarkest,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                styleMatch: TextStyle(
                  color: context.theme.appColors.linkText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                isOnTapEnable: false,
              ),
      ],
    ));
  }
}
