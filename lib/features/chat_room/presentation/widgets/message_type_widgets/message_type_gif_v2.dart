import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/uchat_image.dart';

class MessageTypeGifV2 extends StatelessWidget {
  final String? gifId;
  final String? gifUrl;
  final double? width;
  final double? height;
  final MessageCollection message;
  final String messageTag;

  const MessageTypeGifV2({
    super.key,
    this.gifId,
    this.gifUrl,
    this.width,
    this.height,
    required this.message,
    required this.messageTag,
  });

  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: message.id,
      init: MessageTypeController(initMessage: message), // TODO message type gif ctl
      builder: (controller) {
        return LayoutBuilder(builder: (context, c) {
          return ContextMenuWidget(
            forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
            width: c.maxWidth,
            longPressCallback: () {
              String mediaType = 'gif';
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
            child: MessageTypeGifWidget(
              gifId: gifId,
              gifUrl: gifUrl,
              width: width,
              height: height,
            ),
          );
        });
      },
    );
  }
}

/// A widget that displays a gif image
///
/// This widget is used to display a gif image in the chat room
class MessageTypeGifWidget extends StatelessWidget {
  /// The unique identifier of the gif
  ///
  /// This is used to cache the gif image in the memory
  /// so that the gif image can be displayed faster when it is loaded again
  final String? gifId;

  /// The url of the gif image
  ///
  /// This is used to load the gif image from the internet
  /// if the gif image is not cached in the memory
  final String? gifUrl;

  /// The width of the gif image
  ///
  /// This is used to calculate the aspect ratio of the gif image
  /// so that the gif image can be displayed correctly
  ///
  /// If the width is null or 0, the aspect ratio will be 1
  final double? width;

  /// The height of the gif image
  ///
  /// This is used to calculate the aspect ratio of the gif image
  /// so that the gif image can be displayed correctly
  ///
  /// If the height is null or 0, the aspect ratio will be 1
  final double? height;

  const MessageTypeGifWidget({
    super.key,
    this.gifId,
    this.gifUrl,
    this.width,
    this.height,
  });

  /// The aspect ratio of the gif image
  ///
  /// This is calculated by dividing the width by the height
  ///
  /// - If the width or height is null, the aspect ratio will be 1
  /// - If the width or height is 0, the aspect ratio will be 1
  double get aspectRation {
    // If the width or height is null, the aspect ratio will be 1
    if (width == null || height == null) {
      return 1;
    }

    // If the width or height is 0, the aspect ratio will be 1
    if (width == 0 || height == 0) {
      return 1;
    }

    return width! / height!;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      child: Container(
        color: context.theme.appColors.backgroundGrayLighter,
        constraints: BoxConstraints(
          maxWidth: 350.spMin,
        ),
        child: AspectRatio(
          aspectRatio: aspectRation,
          child: Builder(
            builder: (context) {
              // If the gif url is null, display an error icon
              if (gifUrl == null) {
                return RepaintBoundary(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: UTheme.color.accent,
                        size: 24,
                      ),
                    ),
                  ),
                );
              }

              // Display the gif image from the internet if the gif url is not null
              return RepaintBoundary(
                child: UChatImage.network(
                  gifUrl!,
                  useUChatHeader: false,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  cache: true,
                  cacheKey: gifId,
                  customLoadingWidget: (state) {
                    // Display a loading indicator while the gif image is loading
                    return SizedBox(
                      width: width,
                      height: height,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            context.theme.appColors.iconPrimary,
                          ),
                          strokeCap: StrokeCap.round,
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  },
                  customErrorWidget: (state) {
                    // Display an error icon if the gif image fails to load
                    return RepaintBoundary(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: UTheme.color.accent,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
