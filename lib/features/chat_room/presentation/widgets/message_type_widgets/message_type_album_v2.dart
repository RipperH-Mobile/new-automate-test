import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_album_v2_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/album_grid_delegate.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeAlbumV2 extends GetView<MessageTypeAlbumV2Controller> {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeAlbumV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  @override
  String get tag => messageTag;

  static const double widgetWidth = 260;

  @override
  Widget build(BuildContext context) {
    return ContextMenuWidget(
      forceAlignment: controller.isMyMessage ? Alignment.centerLeft : Alignment.centerRight,
      width: widgetWidth.spMin,
      actions: controller.actions(message),
      longPressCallback: () {
        String mediaType = 'album';
        if (message.type != null) {
          mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
        }
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.longpressChatroom, eventProperties: EventProperty.longPressChatRoom(mediaType));
      },
      child: GestureDetector(
        onTap: () {
          controller.openAlbumScreen(context);
        },
        child: buildAlbum(context),
      ),
    );
  }

  Widget buildAlbum(BuildContext context) {
    final isMine = message.mine;

    final Color backgroundColor =
        isMine ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight;
    final Color albumNameColor =
        isMine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest;
    final Color itemCountColor = isMine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widgetWidth.spMin,
            height: widgetWidth.spMin,
            child: GridView.builder(
              gridDelegate: AlbumGridDelegate(
                itemSize: widgetWidth.spMin / 2,
                spacing: AppSpace.spacePx,
                itemCount: min(message.files?.length ?? 0, 4),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: min(message.files?.length ?? 0, 4),
              itemBuilder: (BuildContext context, int index) {
                final fileUrl = message.files?[index].albumImageUrl;
                if (fileUrl == null) {
                  return const AlbumErrorImageBox();
                }
                return Stack(
                  children: [
                    SizedBox.expand(
                      child: UChatImage.network(fileUrl, fit: BoxFit.cover, customErrorWidget: (state) {
                        return const AlbumErrorImageBox();
                      }),
                    ),
                    if (index == 3 && (message.meta?.albumTasks?.totalImages ?? 0) > 4)
                      SizedBox.expand(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6)),
                          child: Center(
                            child: AppText.heading4(
                              '+${(message.meta?.albumTasks?.totalImages ?? 0) - 3}',
                              color: context.theme.appColors.textPrimaryInverse,
                              context: context,
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: backgroundColor),
            width: widgetWidth.spMin,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space3,
                    top: AppSpace.space3,
                    right: AppSpace.space3,
                    bottom: AppSpace.space05,
                  ),
                  child: SizedBox(
                    /// Use infinity width to make text align work.
                    width: widgetWidth.spMin,
                    child: AppText.body3Bold(
                      message.meta?.albumName ?? 'UNKNOWN'.tr,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      color: albumNameColor,
                      context: context,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space3,
                    right: AppSpace.space3,
                    bottom: AppSpace.space3,
                  ),
                  child: SizedBox(
                    /// Use infinity width to make text align work.
                    width: widgetWidth.spMin,
                    child: AppText.body3(
                      message.meta?.isCreatedAlbum == true
                          ? '@count Photos'.trParams({'count': (message.meta?.albumTasks?.totalImages ?? 0).toString()})
                          : '@count items added to album'
                              .trParams({'count': (message.meta?.albumTasks?.totalImages ?? 0).toString()}),
                      color: itemCountColor,
                      context: context,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
