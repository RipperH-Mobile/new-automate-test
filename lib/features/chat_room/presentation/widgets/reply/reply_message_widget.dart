import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_system_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_album_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_audio_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_file_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_gif_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_location_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_sharing_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_video_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_emoji.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';

class ReplyMessageWidget extends StatelessWidget {
  final MessageModel? repliedMessage;
  final MessageModel? message;
  final bool isMyMessage;
  final void Function()? onReplyTap;

  const ReplyMessageWidget({
    super.key,
    required this.repliedMessage,
    required this.message,
    required this.isMyMessage,
    this.onReplyTap,
  });

  String get shortOthersDisplayName {
    final displayName = repliedMessage?.displayName ?? 'Someone'.tr;

    final characters = displayName.characters;
    if (characters.length > 20) {
      final frontName = displayName.characters.take(15);

      return '$frontName...';
    } else {
      return displayName;
    }
  }

  String get repliedName {
    final isRepliedMessageMine = repliedMessage?.mine ?? false;

    if (isRepliedMessageMine && isMyMessage) {
      //NOTE. my new message reply my message
      return 'yourself'.tr;
    } else if (!isRepliedMessageMine && isMyMessage) {
      //NOTE. my new message reply others
      return shortOthersDisplayName;
    } else if (isRepliedMessageMine && !isMyMessage) {
      //NOTE. others reply my message
      return 'you'.tr;
    } else if (!isRepliedMessageMine && !isMyMessage) {
      if (repliedMessage?.accountId == message?.accountId) {
        //NOTE. others reply themself
        return 'themself'.tr;
      } else {
        //NOTE. others reply another message
        return shortOthersDisplayName;
      }
    }
    return 'Someone'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpace.space2, top: AppSpace.space1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              //NOTE. You replied to yourself ...
              AppText.caption1(
                isMyMessage ? 'You replied to '.tr : 'Replied to '.tr,
                textAlign: TextAlign.start,
                context: context,
              ),
              Flexible(
                child: AppText.caption1Bold(
                  repliedName,
                  textAlign: TextAlign.start,
                  context: context,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isMyMessage)
                  //NOTE. Line vertical of others
                  Container(
                    margin: const EdgeInsets.only(
                      right: AppSpace.space2,
                    ),
                    width: 3.spMin,
                    color: context.theme.appColors.backgroundGrayLightest,
                  ),
                //NOTE. replied message
                // This Flexible is to fix gif overflow on receiver side.
                Flexible(child: _buildRepliedWidget(context)),
                //NOTE. Line vertical of mine
                if (isMyMessage)
                  Container(
                    margin: const EdgeInsets.only(
                      left: AppSpace.space2,
                    ),
                    width: 3.spMin,
                    color: context.theme.appColors.backgroundGrayLightest,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepliedWidget(BuildContext context) {
    final isRepliedMessageMine = repliedMessage?.mine ?? false;
    final repliedMessageCollection = repliedMessage?.toCollection();
    MessageType? type = repliedMessage?.type;

    if (repliedMessage?.isParentDeleted == true ||
        (repliedMessage?.type == MessageType.system &&
            repliedMessage?.systemMessage?.type == MessageSystemType.unSentMessage) ||
        (message?.isParentDeleted == true && message?.replyMessage == null) ||
        (repliedMessage?.isMediaMessage == true && repliedMessageCollection?.files == null)) {
      return _buildText(context, isRepliedMessageMine);
    } else if (repliedMessageCollection == null) {
      return const SizedBox.shrink();
    }

    final messageTag = MessageBinding.getMessageTypeTagWithSuffix(repliedMessageCollection, 'reply-${message?.ref}');

    switch (type) {
      case MessageType.sticker:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeStickerV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildSticker(),
          ),
        );
      case MessageType.stickerSharing:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeStickerSharingV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildStickerImg(context),
          ),
        );
      case MessageType.file:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeFileV2(
                    messageTag: '${repliedMessageCollection.type?.value}-${repliedMessageCollection.ref}-reply',
                    status: null)
                .buildReplyFile(context, repliedMessageCollection),
          ),
        );
      case MessageType.album:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeAlbumV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildAlbum(context),
          ),
        );

      case MessageType.image:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeImageV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildImage(context, const BoxConstraints(maxWidth: 0, maxHeight: 0), true),
          ),
        );

      case MessageType.audio:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeAudioV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildVoiceAudio(context),
          ),
        );

      case MessageType.video:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeVideoV2(
              message: repliedMessageCollection,
              messageTag: messageTag,
            ).buildVideo(
              context,
              isCanClick: false,
              isReply: true,
            ),
          ),
        );

      case MessageType.gif:
        return RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: MessageTypeGifWidget(
              gifId: repliedMessageCollection.meta?.giphyId,
              gifUrl: repliedMessageCollection.meta?.gifUrl,
              width: repliedMessageCollection.meta?.gifWidth,
              height: repliedMessageCollection.meta?.gifHeight,
            ),
          ),
        );

      case MessageType.location:
        return RepaintBoundary(
          child: SizedBox(
            width: AppSpace.space70,
            child: Opacity(
              opacity: 0.5,
              child: MessageTypeLocationV2(
                message: repliedMessageCollection,
                messageTag: messageTag,
              ).buildMapContainer(openContainer: null, context: context),
            ),
          ),
        );

      default:
        if (repliedMessageCollection.meta?.isEmoji == true) {
          final message = (repliedMessageCollection.message ?? '').replaceAll('\n', '');

          return RepaintBoundary(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                padding: EdgeInsets.only(
                  left: isMyMessage ? AppSpace.space6 : AppSpace.space0,
                  top: AppSpace.space2,
                  bottom: AppSpace.space2,
                ),
                child: MessageTypeEmoji(
                  message: message,
                  msgLength: repliedMessageCollection.message?.effectiveLength ?? 0,
                  isReplyMsg: true,
                ),
              ),
            ),
          );
        }

        return _buildText(context, isRepliedMessageMine);
    }
  }

  String _buildTextContent() {
    if (message?.isParentDeleted == true) {
      return 'This message is unavailable'.tr;
    } else if (repliedMessage?.type == MessageType.remove || repliedMessage?.type == MessageType.removeOthers) {
      return 'This message was deleted'.tr;
    } else if (repliedMessage?.type == MessageType.system &&
        repliedMessage?.systemMessage?.type == MessageSystemType.unSentMessage) {
      return 'This message was unsent'.tr;
    } else if (repliedMessage?.isMediaMessage == true && repliedMessage?.files == null) {
      /// If somehow files is null, Fallback to message was deleted message instead of empty space.
      return 'This message was deleted'.tr;
    } else {
      final message = repliedMessage?.message ?? '';

      // Make multiple lines to one line by adding a space
      return message.replaceAll('\n', ' ');
    }
  }

  Widget _buildText(BuildContext context, bool isRepliedMessageMine) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // add space (= datetime size) to adjust the container are the original message
        if (isMyMessage) AppSpace.space8.horizontalSpace,
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
              color: isRepliedMessageMine
                  ? context.theme.appColors.backgroundPrimary.withValues(alpha: 0.60)
                  : context.theme.appColors.backgroundNeutralLight.withValues(alpha: 0.60),
            ),
            child: MentionTextParse(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              message: _buildTextContent(),
              isReply: true,
              onReplyTap: onReplyTap,
              style: context.theme.appTexts.body2.copyWith(
                color: isRepliedMessageMine
                    ? context.theme.appColors.textPrimaryInverse
                    : context.theme.appColors.textDarkest.withValues(alpha: 0.60),
              ),
              styleMatch: context.theme.appTexts.body2Bold.copyWith(
                color: isRepliedMessageMine
                    ? context.theme.appColors.textPrimaryInverse
                    : context.theme.appColors.textDarkest.withValues(alpha: 0.60),
              ),
            ),
          ),
        ),

        // add space (= datetime size) to adjust the container are the original message
        if (!isMyMessage) AppSpace.space8.horizontalSpace,
      ],
    );
  }
}
