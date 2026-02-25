import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:popover/popover.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/api/payloads/message/edit_message.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/enums/chat_room_keyboard_type.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/send_icon.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_text_field.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/input/app_text_field.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

class ChatRoomTextInput extends GetView<ChatRoomInputController> {
  final String chatInputTag;
  final void Function({List<MessageLinkModel> links, required String message, int loopCount}) onSendText;
  final Function(EditMessageRequest) onEditText;
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final Function(MediaGalleryResult, {int loopCount}) onImageAndVideoPicked;
  final Function(FileInfoModel) onTakePicture;
  final Function(FileInfoModel, {int loopCount}) onSendFile;
  final Function(MapInfoResponse) onShareLocation;
  final Function(List<ContactCollection>) onShareUChatContact;
  final Function(List<Contact>) onSharePhoneContact;

  const ChatRoomTextInput({
    super.key,
    required this.chatInputTag,
    required this.onSendText,
    required this.onEditText,
    required this.onSendSticker,
    required this.onSendGif,
    required this.onImageAndVideoPicked,
    required this.onTakePicture,
    required this.onSendFile,
    required this.onShareLocation,
    required this.onShareUChatContact,
    required this.onSharePhoneContact,
  });

  @override
  String? get tag => chatInputTag;

  static const double defaultTextFieldHeight = 40;
  static const double textFieldSpacing = AppSpace.space2;
  static const double inputHeight = defaultTextFieldHeight + (textFieldSpacing * 2);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: context.theme.appColors.border,
        width: 1,
      ),
    );
    return Container(
      color: context.theme.appColors.backgroundNeutralLightest,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(
        textFieldSpacing,
      ),
      child: Obx(() {
        return MentionTextField(
          enabled: !(controller.chatRoomCtl?.roomCapability.value.disableSendMessage == true),
          showPreviewText: controller.showPreviewText.value,
          key: controller.textFieldGlobalKey,
          scrollController: controller.textFieldScrollController,
          mentions: [controller.mentionMarkModel.value],
          focusNode: controller.textFieldFocusNode,
          onChanged: controller.onTextFieldChanged,
          onTap: controller.onKeyboardTap,
          suggestionPosition: MentionSuggestionPosition.top,
          suggestionOverlayOffset: const Offset(0, -AppSpace.space2),
          hideSuggestionList: controller.chatRoomCtl?.room.value?.isGroup != true,
          minLines: 1,
          maxLines: controller.isInputModeClose ? 1 : 4,
          keyboardType: TextInputType.multiline,
          maxLength: UChatConstant.maxMessageInputLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxMessageInputLength)],
          cursorColor: context.theme.appColors.textPrimary,
          cursorRadius: const Radius.circular(AppRadius.roundedSm),
          style: context.theme.appTexts.body2.copyWith(color: context.theme.appColors.textDarkest),
          decoration: InputDecoration(
            hintText: controller.chatRoomCtl?.roomCapability.value.disableSendMessage == true
                ? 'Messaging blocked'.tr
                : 'Messages'.tr,
            hintStyle: TextStyle(
                color: controller.chatRoomCtl?.roomCapability.value.disableSendMessage == true
                    ? context.theme.appColors.textDisable
                    : context.theme.appColors.textLighter),
            fillColor: controller.chatRoomCtl?.roomCapability.value.disableSendMessage == true
                ? context.theme.appColors.backgroundNeutralLightestPressed
                : context.theme.appColors.backgroundNeutralLighterPressed,
            filled: true,
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(
              top: AppSpace.space2,
              bottom: AppSpace.space2,
              left: AppSpace.space4,
              right: _SuffixIcon.iconSizeWithPadding,
            ),
            counterText: '',
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: inputBorder,
            disabledBorder: inputBorder,
          ),
          customSuffixIcon: _SuffixIcon(
            chatInputTag: chatInputTag,
          ),
          leading: Obx(
            () {
              if (controller.chatRoomCtl == null) {
                return const SizedBox.shrink();
              }
              return _LeftSide(
                textInputContext: context,
                chatInputTag: chatInputTag,
                roomCapability: controller.chatRoomCtl!.roomCapability.value,
                keyboardType: controller.keyboardType.value,
                onImageAndVideoPicked: onImageAndVideoPicked,
                onSendFile: onSendFile,
                onShareLocation: onShareLocation,
                onShareUChatContact: onShareUChatContact,
                onSharePhoneContact: onSharePhoneContact,
                onArrowIconPressed: controller.expandKeyboardIcons,
                onSendText: onSendText,
                onCameraIconPressed: () {
                  controller.openCamera(onTakePicture);
                },
              );
            },
          ),
          trailing: (controller.chatRoomCtl != null)
              ? _RightSide(
                  roomCapability: controller.chatRoomCtl!.roomCapability.value,
                  chatInputTag: chatInputTag,
                  onSendText: onSendText,
                  onEditText: onEditText,
                  onSendSticker: onSendSticker,
                  onSendGif: onSendGif,
                )
              : null,
          contextMenuBuilder: (
            BuildContext context,
            EditableTextState editableTextState,
          ) {
            final buttons = controller.getButtonItems(editableTextState, onSendText: onSendText);

            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: buttons,
            );
          },
        );
      }),
    );
  }
}

class _SuffixIcon extends GetView<ChatRoomInputController> {
  const _SuffixIcon({
    required this.chatInputTag,
  });

  @override
  String? get tag => chatInputTag;

  static const double iconSize = 24;
  static const double iconPadding = AppSpace.space2;
  static const double iconSizeWithPadding = iconSize + (iconPadding * 2);

  final String chatInputTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget child;
        if (controller.chatRoomCtl == null) {
          return const SizedBox.shrink();
        }
        final roomCapability = controller.chatRoomCtl!.roomCapability;
        final canSticker = !(roomCapability.value.disableSendSticker && roomCapability.value.disableSendGif);
        if (!canSticker) {
          return const SizedBox.shrink();
        }

        if (controller.keyboardType.value == ChatRoomKeyboardType.switchMode) {
          child = _buildKeyboardIcon(context);
        } else {
          child = _buildStickerIcon(context);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              key: ValueKey<Key?>(child.key),
              scale: animation,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  Widget _buildStickerIcon(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('sticker-icon'),
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.openCustomInput();
      },
      child: Padding(
        padding: const EdgeInsets.all(iconPadding),
        child: Assets.vectors.keyboardEmoji.svg(
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            context.theme.appColors.icon,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboardIcon(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('keyboard-icon'),
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.closeCustomInput();
      },
      child: Padding(
        padding: const EdgeInsets.all(iconPadding),
        child: Assets.vectors.keyboard03.svg(
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconLight,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _LeftSide extends GetView<ChatRoomInputController> {
  const _LeftSide({
    required this.textInputContext,
    required this.chatInputTag,
    required this.roomCapability,
    required this.keyboardType,
    required this.onCameraIconPressed,
    required this.onArrowIconPressed,
    required this.onSendText,
    required this.onImageAndVideoPicked,
    required this.onSendFile,
    required this.onShareLocation,
    required this.onShareUChatContact,
    required this.onSharePhoneContact,
  });

  @override
  String? get tag => chatInputTag;

  static const double _iconSize = 24;
  static const double _iconPadding = AppSpace.space2;

  final BuildContext textInputContext;
  final String chatInputTag;
  final RoomCapabilityEntity roomCapability;
  final ChatRoomKeyboardType keyboardType;
  final VoidCallback onCameraIconPressed;
  final VoidCallback onArrowIconPressed;
  final void Function({List<MessageLinkModel> links, required String message, int loopCount}) onSendText;
  final Function(MediaGalleryResult, {int loopCount}) onImageAndVideoPicked;
  final Function(FileInfoModel, {int loopCount}) onSendFile;
  final Function(MapInfoResponse) onShareLocation;
  final Function(List<ContactCollection>) onShareUChatContact;
  final Function(List<Contact>) onSharePhoneContact;

  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const Curve _animationCurve = Curves.easeInOut;

  bool get _hasCamera => !roomCapability.disableCamera;

  bool get _hasAnyExtra =>
      _hasCamera ||
      !roomCapability.disableSendVoice ||
      !roomCapability.disableSendImage ||
      !roomCapability.disableSendSticker ||
      !roomCapability.disableSendGif ||
      !roomCapability.disableSendFile ||
      !roomCapability.disableSendLocation ||
      !roomCapability.disableSendContact;

  bool get _canGallery => !(roomCapability.disableSendImage && roomCapability.disableSendVideo);

  bool get _canFile => !roomCapability.disableSendFile;

  bool get _canLocation => !roomCapability.disableSendLocation;

  bool get _canContact => !roomCapability.disableSendContact;

  /// “More” is shown when at least *one* of the sub-features is enabled
  bool get _canMore => _canFile || _canLocation || _canContact;

  @override
  Widget build(BuildContext context) {
    if (controller.chatRoomCtl == null) {
      return const SizedBox.shrink();
    }

    // nothing to show at all
    if (!_hasAnyExtra) {
      return const SizedBox.shrink();
    }

    Widget child;
    Offset offset;
    if (keyboardType == ChatRoomKeyboardType.collapsed) {
      // show the “expand” chevron only if something can expand
      child = GestureDetector(
        onTap: onArrowIconPressed,
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpace.space2,
          ),
          child: Assets.vectors.chevronForwardIos.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.icon,
              BlendMode.srcIn,
            ),
            width: _iconSize,
            height: _iconSize,
          ),
        ),
      );
      offset = const Offset(1.0, 0.0); // Start from right
    } else {
      child = Obx(() {
        return Row(
          children: [
            // use textInputContext to show the popover in the right context
            if (_canMore) _buildShowMoreOptionIcon(textInputContext),
            if (_hasCamera) _buildCameraButton(context),
            if (_canGallery) _buildGalleryButton(context),
          ],
        );
      });
      offset = const Offset(-1.0, 0.0); // Start from left
    }

    return Row(
      children: [
        // hamburger menu to change to oa panel mode
        _buildOpenOAPanelIcon(context),
        AnimatedSwitcher(
          duration: _animationDuration,
          switchInCurve: _animationCurve,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              key: ValueKey<Key?>(child.key),
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: child,
        ),
      ],
    );
  }

  Widget _buildOpenOAPanelIcon(BuildContext context) {
    return Obx(() {
      if (controller.chatRoomCtl?.isShowHamburgerMenu.value == false) {
        return const SizedBox.shrink();
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          controller.chatRoomCtl?.setOAActionBarMode(true);
        },
        child: Padding(
          padding: const EdgeInsets.all(
            _iconPadding,
          ),
          child: Assets.vectors.iconHambergerBar.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.icon,
              BlendMode.srcIn,
            ),
            // width: _iconSize,
            // height: _iconSize,
          ),
        ),
      );
    });
  }

  Widget _buildCameraButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onCameraIconPressed,
      child: Padding(
        padding: const EdgeInsets.all(
          _iconPadding,
        ),
        child: Assets.vectors.keyboardCamera.svg(
          colorFilter: ColorFilter.mode(
            controller.isOpenMoreMenu.value ? context.theme.appColors.iconLighter : context.theme.appColors.icon,
            BlendMode.srcIn,
          ),
          width: _iconSize,
          height: _iconSize,
        ),
      ),
    );
  }

  Widget _buildGalleryButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.openGalleryPicker(onImageAndVideoPicked);
      },
      child: Padding(
        padding: const EdgeInsets.all(
          _iconPadding,
        ),
        child: Assets.vectors.photoOutlined.svg(
          colorFilter: ColorFilter.mode(
            controller.isOpenMoreMenu.value ? context.theme.appColors.iconLighter : context.theme.appColors.icon,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildShowMoreOptionIcon(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        GetIt.I<TaxonomyService>().sendEvent(EventName.clickAddIcon);
        _showPopup(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(
          _iconPadding,
        ),
        child: Obx(
          () => SvgPicture.asset(
            controller.isOpenMoreMenu.value ? Assets.vectors.moreClose.path : Assets.vectors.more.path,
            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
            width: _iconSize,
            height: _iconSize,
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext ctx) async {
    controller.toggleMoreMenu();
    final result = await UChatPopover.open(
      context: ctx,
      width: 220,
      contentDxOffset: -300,
      direction: PopoverDirection.top,
      menu: [
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.chatRoomCtl?.sendRoomInfo(onSendText: onSendText);
            },
            icon: Assets.vectors.roomInfo.svg(),
            title: 'Send room info'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.chatRoomCtl?.showRoomChangeHistoryDialog();
            },
            icon: Assets.vectors.roomChangesHistory.svg(),
            title: 'View room changes'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.chatRoomCtl?.showRoomUpdateEventHistoryDialog();
            },
            icon: const Icon(Icons.webhook),
            title: 'View room update events'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.showDebugSendSequenceMessageSliderDialog(onSendText: onSendText);
            },
            icon: Assets.vectors.bombMessage.svg(),
            title: 'Bomb messages'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.showDebugSendMockMessageSliderDialog();
            },
            icon: Assets.vectors.mockMessage.svg(),
            title: 'Mock messages'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.debugSendSampleMessage(onSendText: onSendText);
            },
            icon: Assets.vectors.mockMessage.svg(),
            title: 'Sample messages'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.showMessageStateDetailsDialog();
            },
            icon: Assets.vectors.troubleshootEasyAccess.svg(),
            title: 'Notification debugger'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.showQueueMonitorDashboard();
            },
            icon: const Icon(Icons.monitor_heart),
            title: 'Queue Monitor'.tr,
            hasBottomDivider: true,
          ),
        if (controller.isTroubleshootEnabled)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.sendSampleFile(onSendFile);
            },
            hasBottomDivider: true,
            icon: Assets.vectors.folderOpen.svg(),
            title: 'Share a sample file'.tr,
          ),
        if (_canFile)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              // TODO (chat room refactor) Add share file.
              controller.sendFile(onSendFile);
            },
            hasBottomDivider: true,
            icon: Assets.vectors.folderOpen.svg(),
            title: 'Share a file'.tr,
          ),
        if (_canLocation)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              controller.toggleMoreMenu();
              controller.showMoreSendOption(onShareLocation);
            },
            hasBottomDivider: true,
            icon: Assets.vectors.locationOn.svg(),
            title: 'Location'.tr,
          ),
        if (_canContact)
          PopoverMenuItem(
            onPressed: (_) async {
              Get.back(result: true);
              GetIt.I<TaxonomyService>().sendEvent(EventName.clickAddContact);
              await _showPopupContact(ctx);
            },
            icon: Assets.vectors.accountCircle2.svg(),
            title: 'Contact'.tr,
          ),
      ],
    );
    if (result == null) {
      controller.toggleMoreMenu();
    }
  }

  Future<void> _showPopupContact(BuildContext ctx) async {
    await UChatPopover.open(
      context: ctx,
      width: 220,
      contentDxOffset: -110.spMin,
      // This number come from trail and error (MAGIC).
      direction: PopoverDirection.top,
      menu: [
        PopoverMenuItem(
          onPressed: (_) async {
            Get.back();
            controller.showMoreSendOptionUChatContact(onShareUChatContact);
          },
          hasBottomDivider: true,
          icon: Assets.vectors.iconChat.svg(),
          title: 'UChat friends'.tr,
        ),
        PopoverMenuItem(
          onPressed: (_) async {
            Get.back();
            controller.showMoreSendOptionMobileContact(onSharePhoneContact);
          },
          hasBottomDivider: true,
          icon: Assets.vectors.accountCircle2.svg(),
          title: 'Device contacts'.tr,
        ),
      ],
    );
    controller.toggleMoreMenu();
  }
}

class _RightSide extends GetView<ChatRoomInputController> {
  final String chatInputTag;
  final void Function({List<MessageLinkModel> links, required String message}) onSendText;
  final Function(EditMessageRequest) onEditText;
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final RoomCapabilityEntity roomCapability;

  const _RightSide({
    required this.roomCapability,
    required this.chatInputTag,
    required this.onSendText,
    required this.onEditText,
    required this.onSendSticker,
    required this.onSendGif,
  });

  @override
  String? get tag => chatInputTag;

  static const double _iconSize = 24;

  bool get _canVoice => !roomCapability.disableSendVoice;

  @override
  Widget build(BuildContext context) {
    if (controller.chatRoomCtl == null) {
      return const SizedBox.shrink();
    }
    return Obx(
      () {
        Widget child;
        if (controller.showSendButton.value || roomCapability.disableSendFile == true) {
          child = _buildSendButton();
        } else if (_canVoice) {
          child = _buildRecordAudioButton(context);
        } else {
          child = const SizedBox.shrink();
        }
        return AnimatedSwitcher(
          duration: MentionTextField.iconAnimationDuration,
          switchInCurve: MentionTextField.iconAnimationCurve,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  Widget _buildSendButton() {
    return SendIcon(
      onTap: () {
        controller.onSendPressed(
          onSendText: onSendText,
          onEditText: onEditText,
          onSendSticker: onSendSticker,
        );
      },
      enabled: controller.textFieldController?.text.isNotEmpty == true,
    );
  }

  Widget _buildRecordAudioButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.startRecording();
      },
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpace.space2,
        ),
        child: Assets.vectors.microphone.svg(
          height: _iconSize,
          width: _iconSize,
          colorFilter: ColorFilter.mode(
            controller.isOpenMoreMenu.value ? context.theme.appColors.iconLighter : context.theme.appColors.icon,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
