import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_text_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_link_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_text_parse.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_emoji.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';

class MessageTypeTextV2 extends GetView<MessageTypeTextV2Controller> {
  final String messageTag;
  final Widget? status;
  final List<Widget>? actions;

  const MessageTypeTextV2({
    super.key,
    required this.messageTag,
    this.status,
    this.actions,
  });

  @override
  String get tag => messageTag;

  bool get shouldShowLinkPreview {
    final link = controller.message.value?.links?.firstOrNull;
    if (link == null) return false;
    return link.hasImage || (link.description?.isNotEmpty == true && link.title?.isNotEmpty == true);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    return Obx(() {
      if (controller.isRegEx ||
          controller.message.value?.createdAt?.isBefore(DateTime(2025, 4)) == true ||
          controller.isHaveLinks) {
        /// If [isRegX] is true, that means it needed markup container

        if (controller.isEmoji && !controller.isLengthOverLimit.value) {
          /// If it's only emoji and not overflowed

          child = MessageTypeEmoji(
            message: controller.message.value?.message ?? '',
            msgLength: controller.msgLength.value,
          );
        } else {
          /// If on of [isLengthOverLimit], [isMention], [hasPhoneNumber] and [hasEmail] is true

          child = Obx(() {
            return controller.message.value == null
                ? const SizedBox.shrink()
                : MessageTextParse(
                    message: controller.message.value!,
                    isMinimizeText: controller.isMinimizeText.value,
                    isLengthOverLimit: controller.isLengthOverLimit.value,
                    limitedLength: UChatConstant.maxTextCharacter,
                    onReadMorePressed: controller.onReadMorePressed,
                  );
          });
        }
      } else {
        /// If message is just a [regularText] and not overflowed

        child = MessageTypeRegularText(
          message: controller.message.value?.message ?? '',
          isMyMessage: controller.isMyMessage,
        );
      }

      return LayoutBuilder(
        builder: (context, c) {
          return ContextMenuWidget(
            forceAlignment: controller.isMyMessage ? Alignment.centerLeft : Alignment.centerRight,
            width: c.maxWidth,
            longPressCallback: () {
              String mediaType = 'text';
              GetIt.I<TaxonomyService>()
                  .sendEvent(EventName.longpressChatroom, eventProperties: EventProperty.longPressChatRoom(mediaType));
            },
            actions: actions ??
                controller.actions(
                  controller.message.value,
                ),
            topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
            topWidget: controller.canReact
                ? MessageReactionPopup(
                    messageTag: messageTag,
                  )
                : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: controller.isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: controller.isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!shouldShowLinkPreview && controller.isMyMessage)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: status ?? const SizedBox.shrink(),
                      ),
                    Flexible(child: child),
                    if (!shouldShowLinkPreview && !controller.isMyMessage)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: status ?? const SizedBox.shrink(),
                      ),
                  ],
                ),
                if (shouldShowLinkPreview)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    textDirection: controller.isMyMessage ? TextDirection.ltr : TextDirection.rtl,
                    children: [
                      status ?? const SizedBox.shrink(),
                      AppSpace.space2.horizontalSpace,
                      Flexible(
                        child: Column(
                          children: _buildMessageLinks(context),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          );
        },
      );
    });
  }

  List<Widget> _buildMessageLinks(BuildContext context) {
    final link = controller.message.value?.links?.firstOrNull;
    if (link == null) {
      return [];
    }
    // If there are multiple links, just show preview of the first one.
    return [
      AppSpace.space2.verticalSpace,
      MessageTypeLinkV2(link: link, isMyMessage: controller.isMyMessage),
    ];
  }
}
