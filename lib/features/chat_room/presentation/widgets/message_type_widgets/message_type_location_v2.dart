import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uchat/api/payloads.dart';
import 'package:uchat/api/services.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/map/map_preview_fullscreen.dart';

class MessageTypeLocationV2 extends StatelessWidget {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeLocationV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  bool get isMyMessage => message.mine;

  String get tag => messageTag;

  MapInfoResponse get mapInfo {
    final metaLocation = message.meta;
    final locationLat = metaLocation?.locationLat;
    final locationLng = metaLocation?.locationLng;
    final location = (locationLat == null || locationLng == null) ? null : LatLng(locationLat, locationLng);

    final mapInfo = MapInfoResponse(
      name: metaLocation?.locationName ?? '',
      locationFormattedAddress: metaLocation?.locationFormattedAddress ?? '',
      vicinity: metaLocation?.locationVicinity ?? '',
      locationImgBlurhash: metaLocation?.locationImgBlurhash ?? '',
      locationImgId: metaLocation?.locationImgId ?? '',
      location: location,
    );

    return mapInfo;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        tag: message.id,
        init: MessageTypeController(initMessage: message), // TODO message type location ctl
        builder: (controller) {
          return LayoutBuilder(builder: (context, c) {
            return ContextMenuWidget(
              forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
              width: c.maxWidth,
              longPressCallback: () {
                String mediaType = 'location';
                if (message.type != null) {
                  mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
                }
                GetIt.I<TaxonomyService>().sendEvent(EventName.longpressChatroom,
                    eventProperties: EventProperty.longPressChatRoom(mediaType));
              },
              actions: controller.actions(message),
              topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
              topWidget: controller.canReact
                  ? MessageReactionPopup(
                      messageTag: tag,
                    )
                  : null,
              child: OpenContainer<dynamic>(
                transitionDuration: const Duration(milliseconds: 300),
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
                ),
                openBuilder: (_, closeContainer) {
                  return MapPreviewFullScreen(mapInfo: mapInfo);
                },
                onClosed: (res) {},
                tappable: false,
                closedElevation: 0,
                closedBuilder: (_, openContainer) {
                  return buildMapContainer(
                    openContainer: openContainer,
                    context: context,
                  );
                },
              ),
            );
          });
        });
  }

  Widget buildMapContainer({
    required void Function()? openContainer,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: openContainer,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          color:
              isMyMessage ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: context.theme.appColors.backgroundNeutralLight,
                child: _buildLocationImage(mapInfo),
              ),
              _buildTitle(context),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationImage(MapInfoResponse mapInfo) {
    if (mapInfo.locationImgBlurhash == null && mapInfo.location != null) {
      return UChatImage.network(
        GooglePlaceService().staticMapApi(
          mapInfo.location!,
        ),
        cache: true,
        clearMemoryCacheIfFailed: false,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
      );
    }

    if (mapInfo.locationImgId == null) {
      return BlurHash(
        hash: blurhashDefault(mapInfo.locationImgBlurhash),
      );
    }

    return UChatImage.network(
      mapInfo.mapPreview!,
      fit: BoxFit.cover,
      customLoadingWidget: (state) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Get.theme.appColors.iconPrimary),
            strokeCap: StrokeCap.round,
            strokeWidth: 4,
          ),
        );
      },
      customErrorWidget: (state) {
        if (mapInfo.mapPreview == null) {
          return Container(
            color: Colors.grey.withValues(alpha: 0.3),
            child: const Icon(Icons.warning),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Get.theme.appColors.iconPrimary),
              strokeCap: StrokeCap.round,
              strokeWidth: 4,
            ),
          );
        }
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        AppSpace.space2,
        AppSpace.space3,
        AppSpace.space1,
      ),
      child: AppText.body3Bold(
        message.meta?.locationName ?? '',
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        0,
        AppSpace.space3,
        AppSpace.space3,
      ),
      child: AppText.body4(
        message.meta?.locationVicinity ?? message.meta?.locationVicinity ?? '',
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
      ),
    );
  }
}
