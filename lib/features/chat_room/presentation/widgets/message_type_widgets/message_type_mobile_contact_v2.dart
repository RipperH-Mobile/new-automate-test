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
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_mobile_contact_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeMobileContactV2 extends StatelessWidget {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeMobileContactV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  bool get isMyMessage => message.mine;

  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageTypeMobileContactV2Controller>(
      init: MessageTypeMobileContactV2Controller(initMessage: message),
      builder: (controller) {
        return LayoutBuilder(builder: (context, c) {
          return ContextMenuWidget(
            forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
            width: c.maxWidth,
            longPressCallback: () {
              String mediaType = 'contact';
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
              onTap: () => controller.handleViewMobileContact(message.mobileContact),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  color: isMyMessage
                      ? context.theme.appColors.backgroundPrimary
                      : context.theme.appColors.backgroundNeutralLight,
                  borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSpace.space3.horizontalSpace,
                    Assets.vectors.mobileContactAvatar.svg(
                      height: AppSize.size10.spMin,
                      width: AppSize.size10.spMin,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildContactName(context),
                          _buildPhoneNumber(context),
                        ],
                      ),
                    ),
                    AppSpace.space4.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: isMyMessage
                          ? context.theme.appColors.iconPrimaryInverse
                          : context.theme.appColors.iconLighter,
                      size: AppSize.size4,
                    ),
                    AppSpace.space3.horizontalSpace,
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildContactName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        AppSpace.space3,
        AppSpace.space3,
        AppSpace.space1 / 2,
      ),
      child: AppText.body3Bold(
        message.mobileContact?.displayName ?? 'UNKNOWN'.tr,
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
        context: context,
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        0,
        AppSpace.space3,
        AppSpace.space3,
      ),
      child: AppText.body4(
        message.mobileContact?.phoneNumber ?? 'UNKNOWN'.tr,
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
        context: context,
      ),
    );
  }
}
