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
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_contact_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class MessageTypeContactV2 extends StatelessWidget {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeContactV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  Color _backgroundColor(BuildContext context) {
    if (message.mine == true) {
      return context.theme.appColors.backgroundPrimary;
    }
    return context.theme.appColors.backgroundNeutralLight;
  }

  Color _textColor(BuildContext context) {
    if (message.mine == true) {
      return context.theme.appColors.textPrimaryInverse;
    }
    return context.theme.appColors.textDarkest;
  }

  Color _buttonBackgroundColor(BuildContext context) {
    if (message.mine == true) {
      return context.theme.appColors.backgroundPrimaryBolder;
    }
    return context.theme.appColors.backgroundNeutralLightPressed;
  }

  Color _buttonTextColor(BuildContext context) {
    if (message.mine == true) {
      return context.theme.appColors.textPrimaryInverse;
    }
    return context.theme.appColors.textDark;
  }

  bool get _isStatusMessageExist {
    return message.contact?.statusMessage != null && message.contact?.statusMessage.isNotEmpty == true;
  }

  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: tag,
      init: MessageTypeContactV2Controller(initMessage: message),
      id: MessageTypeContactV2Ids.all,
      builder: (controller) {
        return RepaintBoundary(
          child: LayoutBuilder(builder: (_, c) {
            return ContextMenuWidget(
              forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
              width: 164.spMin,
              longPressCallback: () {
                String mediaType = 'contact';
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
              child: GestureDetector(
                onTap: controller.onViewContact,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                  child: Container(
                    width: 164.spMin,
                    color: _backgroundColor(context),
                    padding: const EdgeInsets.only(
                      top: AppSpace.space4,
                      bottom: AppSpace.space3,
                      left: AppSpace.space3,
                      right: AppSpace.space3,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 350.spMin,
                    ),
                    child: Column(
                      children: [
                        AvatarWrapper<ContactInterface>(
                          data: message.contact,
                          radius: 20,
                          onlineStatusSize: 7.spMin,
                        ),
                        AppSpace.space3.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                          child: AppText.body3Bold(
                            controller.nickname ?? message.contact?.displayName ?? '',
                            context: context,
                            color: _textColor(context),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        AppSpace.space05.verticalSpace,
                        if (_isStatusMessageExist)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                            child: AppText.caption2(
                              message.contact!.statusMessage,
                              context: context,
                              color: _textColor(context),
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        AppSpace.space3.verticalSpace,
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: AppSize.size8,
                          ),
                          decoration: BoxDecoration(
                            color: _buttonBackgroundColor(context),
                            borderRadius: BorderRadius.circular(AppRadius.roundedLg),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: AppText.caption1Bold(
                              'View contact'.tr,
                              context: context,
                              color: _buttonTextColor(context),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
