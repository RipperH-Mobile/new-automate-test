import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_shadow.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/theme/app_theme.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/models/models/link_metadata_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/chat_room_call_button_row.dart';
import 'package:uchat/features/chat_room/presentation/widgets/oa_rich_menu/oa_action_bar.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/latest_pin_message.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reply/back_to_reply_button.dart';
import 'package:uchat/features/home/call_appbar.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDirectMobileScreen extends GetView<ChatRoomController> {
  final String roomTag;

  @override
  String get tag => roomTag;

  /// Enable hold and scroll feature
  ///
  /// This feature is used to enable hold and scroll feature.
  ///
  /// Default is false.
  ///
  /// - If true, the chat room app bar, chat room input, and scroll to bottom button will be hidden.
  final bool enableHoldAndScroll;

  const ChatRoomDirectMobileScreen({
    super.key,
    required this.roomTag,
    this.enableHoldAndScroll = false,
  });

  ThemeData themeSelector() {
    if (controller.roomTheme.value == 3) {
      return AppTheme.dark().themeData;
    } else if (controller.roomTheme.value == 2) {
      return AppTheme.blue().themeData;
    } else {
      return AppTheme.light().themeData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Theme(
          data: themeSelector(),
          // Portal is here for FlutterMention to show suggestion list.
          child: Builder(
            builder: (context) {
              return Portal(
                child: CallAppBar(
                  child: Stack(
                    children: [
                      Obx(() {
                        return ScaffoldBasic(
                          backgroundColor: context.theme.appColors.backgroundNeutralLightest,
                          appBar: !enableHoldAndScroll
                              ? PreferredSize(
                                  preferredSize: ChatRoomAppBar.size,
                                  child: _buildAppBar(),
                                )
                              : null,
                          onBodyTap: () async {
                            controller.onBodyTap();
                          },
                          //
                          resizeToAvoidBottomInset: controller.chatRoomInputCtl.useScaffoldBottomPadding ? true : false,
                          child: _buildBody(context),
                        );
                      }),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(() {
                          if (controller.chatRoomInputCtl.isInputModeCustomInput &&
                              controller.chatRoomInputCtl.isCustomInputTypeImageAndVideo) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.decelerate,
                              color: context.theme.appColors.backgroundNeutralLightest,
                              padding: const EdgeInsets.only(
                                top: AppSpace.space2,
                              ),
                              height: controller.chatRoomInputCtl.customInputHeight,
                              child: MediaGallery(
                                onEditImageCompleteCallback: controller.onEditImageComplete,
                                disableSafeArea: true,
                                onDoneCallback: controller.onImageAndVideoPicked,
                                isShowCloseButton: false,
                                onVerticalPositionUpdate: (inversePositionDy) {
                                  final newSize = inversePositionDy + ChatRoomStickerInput.stickerHeaderHeight;
                                  controller.chatRoomInputCtl.swipeKeyboardHeight(newSize);
                                },
                                onVerticalDragEnd: (inversePositionDy) {
                                  if (controller.chatRoomInputCtl.previewSticker.value != null) {
                                    controller.chatRoomInputCtl.swipeKeyboardHeight(0);
                                  } else if (inversePositionDy > 0.60.sh) {
                                    controller.chatRoomInputCtl.swipeKeyboardHeight(1.sh);
                                  } else {
                                    controller.chatRoomInputCtl.swipeKeyboardHeight(0);
                                  }
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                      ),
                      Obx(
                        () {
                          if (controller.isRoomLoading.value || controller.messageListCtl.isLoadingMessage.value) {
                            return Align(
                              alignment: Alignment.center,
                              child: FadeIn(
                                delay: const Duration(milliseconds: 700),
                                child: Container(
                                  padding: const EdgeInsets.all(AppSpace.space4),
                                  decoration: BoxDecoration(
                                    color: context.theme.appColors.backgroundGray.withValues(alpha: .8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: AppSize.size12,
                                    height: AppSize.size12,
                                    child: CircularProgressIndicator(
                                      color: context.theme.appColors.iconInverse,
                                      strokeWidth: 4,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return Obx(
      () => ChatRoomAppBar(
        amountGroupMember: controller.room.value?.isGroup == true ? controller.room()?.memberCount : null,
        controller: controller,
        callType: controller.callType(),
        onAppBarCallButtonPressed: () async {
          controller.onAppBarCallButtonTap();
        },
        onJoinCallPressed: controller.isGroup
            ? controller.isGroupCalling.contains(controller.callStatus())
                ? () {
                    controller.callCtl.onJoinCall(
                      room: controller.room()!,
                    );
                  }
                : null
            : controller.isCallConnect
                ? () {
                    controller.callCtl.onJoinCall(
                      room: controller.room()!,
                    );
                  }
                : null,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Obx(() {
            return Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: !enableHoldAndScroll
                      ? null
                      : () {
                          final room = controller.room.value;
                          if (room != null) {
                            Get.offAndToNamed(
                              Routes.chatRoomDirect.replaceAll(':id', room.id!),
                              arguments: ChatRoomArguments(room: room, fromPage: 'chatList'),
                            );
                          }
                        },
                  child: MainMessageList(
                    controllerTag: 'chat-room-$tag',
                    parentWidth: Get.width,
                    onSelectionTap: controller.toggleSelection,
                    selectedMessages: controller.selectedMessages(),
                    selectionType: controller.selectMessageType.value,
                    onImageItemSelected: controller.onImageItemSelected,
                    enableHoldAndScroll: enableHoldAndScroll,
                    onSwipeReply: controller.setRepliedMessage,
                    onTapToMention: controller.chatRoomInputCtl.onTapToMention,
                    keyboardHeight: controller.chatRoomInputCtl.keyboardHeight,
                    isReplying: controller.repliedMessage.value != null,
                    roomCapability: controller.roomCapability.value,
                  ),
                ),
                Obx(
                  () {
                    final roomId = controller.room.value?.id;
                    final pinMessages = controller.pinMessages.value;
                    if (roomId == null || pinMessages == null || enableHoldAndScroll) return const SizedBox.shrink();

                    return LatestPinMessage(
                      pinMessageEntities: pinMessages,
                      isAbleToPinMessages: controller.isAbleToPinMessages,
                      roomId: roomId,
                    );
                  },
                ),
                GetBuilder<ChatRoomController>(
                  id: ChatRoomIds.callButtonRow,
                  tag: tag,
                  builder: (controller) {
                    return ChatRoomCallButtonRow(
                      height: controller.isCallButtonRowOpen ? AppSize.size16 : 0,
                      onVoiceCallPressed: () async {
                        controller.onCallStart(CallType.voice);
                      },
                      onVideoCallPressed: () async {
                        controller.onCallStart(CallType.video);
                      },
                    );
                  },
                ),
                Obx(
                  () {
                    if (controller.showNotFriend && controller.isRoomLoading.value == false) {
                      return NotFriendBanner(
                        showOnlyAddBtn: controller.showOnlyAddBtn.value == true,
                        isFriendRequesting: controller.isFriendRequesting.value,
                        onAddFriendPress: controller.handleAdd,
                        handleDeclinePress: controller.handleDeclineFriendRequest,
                        onBlockPress: controller.handleBlock,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GetBuilder<ChatRoomController>(
                        tag: roomTag,
                        id: ChatRoomIds.goBackToReplyButton,
                        builder: (controller) {
                          if (controller.showGoBackToReplyButton == true) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpace.space4),
                              child: ZoomIn(
                                // Delay for if the reply message are the same screen,
                                // the button should not appear suddenly (to avoid flickering)
                                duration: const Duration(milliseconds: 500),
                                child: BackToReplyButton(
                                  onPressed: () {
                                    controller.goBackToReply();
                                  },
                                ),
                              ),
                            );
                          } else if (controller.showGoBackToReplyButton == false) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpace.space4),
                              child: ZoomOut(
                                duration: const Duration(milliseconds: 400),
                                child: BackToReplyButton(
                                  onPressed: () {
                                    controller.goBackToReply();
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    _buildUnreadCountBtn(context),
                  ],
                ),
                if (!enableHoldAndScroll)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.transparent,
                      child: _buildUpperMessage(context),
                    ),
                  ),
              ],
            );
          }),
        ),
        if (!enableHoldAndScroll)
          Column(
            children: [
              Obx(() {
                if (controller.selectedMessages.value != null) {
                  return _buildSelectMessageActionBtn(context);
                } else if (controller.isShowOAActionBarMode.value) {
                  return _buildOAActionBarMode(context);
                }
                return _buildChatInput(context);
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: ChatRoomCustomInput(
                  controllerTag: 'chat-room-$tag',
                  onSendSticker: controller.onSendSticker,
                  onSendGif: controller.onSendGif,
                ),
              )
            ],
          ),
      ],
    );
  }

  Widget _buildOAActionBarMode(BuildContext context) {
    if (!controller.isShowOAActionBarMode.value) return const SizedBox.shrink();
    return Obx(() {
      return OaActionBar(
        isLoading: controller.isLoadingOARichMenu.value,
        isShowRichMenu: controller.isShowOARichMenu.value,
        onPressSwitchMode: () => controller.setOAActionBarMode(false),
        onMenuToggle: controller.setShowOARichMenu,
        richMenu: controller.oaRichMenu.value,
        onSendMessage: (message) => controller.onSendText(message: message),
      );
    });
  }

  Widget _buildUpperMessage(BuildContext context) {
    return Obx(
      () {
        bool showLinkPreview = false;

        final currentUrl = controller.chatRoomInputCtl.currentUrl.value;
        final urlMetadataMap = controller.chatRoomInputCtl.urlMetadataMap;

        LinkMetadataModel? metadata;

        if (currentUrl.isNotEmpty) {
          metadata = urlMetadataMap[currentUrl];
          if (metadata?.show == true) {
            showLinkPreview = metadata != null;
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildPreviewSticker(context, controller.onSendSticker),
            _buildReplyingOrEditingBox(context),
            if (showLinkPreview)
              LinkPreviewOverInput(
                metadata: metadata!,
                onTapClose: () => controller.chatRoomInputCtl.onCloseLinkPreview(metadata!.url),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSelectMessageActionBtn(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        // Fill safe area color if selection message is active
        color: controller.selectedMessages.value != null ? context.theme.appColors.backgroundNeutralLightest : null,
        child: SafeArea(
          child: Container(
            color: context.theme.appColors.backgroundNeutralLightest,
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2, vertical: AppSpace.space1),
            child: Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TODO: move to widget button
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      controller.selectedMessages.value = null;
                      controller.selectedMessages.refresh();
                    },
                    style: ButtonStyle(
                      // fixedSize: WidgetStateProperty.all(const Size.fromHeight(55)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: context.theme.appColors.border,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(context.theme.appColors.buttonSecondary),
                    ),
                    child: AppText.button1Bold(
                      'Cancel'.tr,
                      context: context,
                      color: context.theme.appColors.textDarkest,
                    ),
                  ),
                ),

                // TODO: move to widget button
                Expanded(
                  child: TextButton(
                    onPressed:
                        controller.selectedMessages.value?.isEmpty == true ? null : controller.onCompleteSelection,
                    style: ButtonStyle(
                      // fixedSize: WidgetStateProperty.all(const Size.fromHeight(55)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: context.theme.appColors.border,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(context.theme.appColors.buttonSecondary),
                    ),
                    child: AppText.button1Bold(
                      '@type @number'.trParams({
                        'number': (controller.selectedMessages.value == null ||
                                controller.selectedMessages.value?.isEmpty == true)
                            ? ''
                            : '(${controller.selectedMessages.value?.length.toString()})',
                        'type': controller.selectMessageType.value?.buttonName ?? '',
                      }),
                      context: context,
                      color: controller.selectedMessages.value?.isEmpty == true
                          ? context.theme.appColors.backgroundGrayLight
                          : controller.selectMessageType.value?.buttonTextColor == 'ERROR'
                              ? context.theme.appColors.buttonError
                              : context.theme.appColors.buttonPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnreadCountBtn(BuildContext context) {
    if (enableHoldAndScroll) {
      return const SizedBox(
        height: AppSize.size16,
        width: AppSize.size12,
      );
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: AppSize.size14,
        width: AppSize.size12,
        margin: const EdgeInsets.only(bottom: AppSpace.space2, right: AppSpace.space4),
        child: Obx(() {
          if (controller.messageListCtl.showScrollToBottomFloatingButton.value == null) {
            return const SizedBox.shrink();
          }
          return controller.messageListCtl.showScrollToBottomFloatingButton.value == true
              ? ZoomIn(duration: const Duration(milliseconds: 500), child: _buildWidgetUnreadBtn(context))
              : ZoomOut(duration: const Duration(milliseconds: 400), child: _buildWidgetUnreadBtn(context));
        }),
      ),
    );
  }

  Widget _buildWidgetUnreadBtn(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            height: AppSize.size10,
            width: AppSize.size10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.theme.appColors.backgroundNeutralLighter,
              boxShadow: [AppShadow.shadowBlack12],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 5),
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: context.theme.appColors.textDarkest,
                  ),
                  onPressed: controller.onScrollToBottom,
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          final unreadCount = controller.unreadCount.value;

          if (unreadCount <= 0) return const SizedBox.shrink();
          return Container(
            height: AppSize.size6,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space2,
              vertical: AppSpace.space1,
            ),
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundError,
              borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedFlipCounter(
                  value: unreadCount > 99 ? 99 : unreadCount,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  textStyle: context.theme.appTexts.caption1Bold.copyWith(
                    color: context.theme.appColors.textPrimaryInverse,
                  ),
                ),
                if (unreadCount > 99)
                  Text(
                    '+',
                    style: context.theme.appTexts.caption1Bold.copyWith(
                      color: context.theme.appColors.textPrimaryInverse,
                      height: 1,
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return _buildChatInputChild(context);
  }

  Widget _buildChatInputChild(
    BuildContext context,
  ) {
    if (controller.contact()?.isBlocked == true || controller.roomNotAvailable) {
      return Container(
        color: context.theme.appColors.backgroundNeutralLightest,
        alignment: Alignment.center,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(ChatRoomTextInput.textFieldSpacing),
            child: Container(
              height: ChatRoomTextInput.defaultTextFieldHeight,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: context.theme.appColors.border,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: AppText.body3Bold(
                controller.roomNotAvailable ? 'Unavailable'.tr : 'Blocked'.tr,
                context: context,
                color: context.theme.appColors.textLighter,
              ),
            ),
          ),
        ),
      );
    } else if (controller.roomCapability.value.disableSendMessage == true &&
        controller.roomCapability.value.disableSendFile == true) {
      return Container(
        color: context.theme.appColors.backgroundNeutralLightest,
        alignment: Alignment.center,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(
              ChatRoomTextInput.textFieldSpacing,
            ),
            child: Container(
              height: ChatRoomTextInput.defaultTextFieldHeight,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
              ),
              child: AppText.body3(
                'The admin have restricted your ability to send messages'.tr,
                textAlign: TextAlign.center,
                context: context,
                color: context.theme.appColors.textLighter,
              ),
            ),
          ),
        ),
      );
    }
    return ChatRoomInput(
      chatInputTag: 'chat-room-$tag',
      onSendText: controller.onSendText,
      onEditText: controller.onEditText,
      onSendSticker: controller.onSendSticker,
      onSendGif: controller.onSendGif,
      onSendAudioRecording: controller.onSendAudioRecording,
      onImageAndVideoPicked: controller.onImageAndVideoPicked,
      onTakePicture: controller.onTakePicture,
      onSendFile: controller.onSendFile,
      onShareLocation: controller.onShareLocation,
      onShareUChatContact: controller.onShareUChatContact,
      onSharePhoneContact: controller.onSharePhoneContact,
    );
  }

  Widget _buildPreviewSticker(
      BuildContext context, void Function(StickerSendingEntity, {int loopCount}) onSendSticker) {
    return GetBuilder<ChatRoomInputController>(
        tag: 'chat-room-$roomTag',
        builder: (controller) {
          final packID = controller.previewSticker.value?.stickerPackId;
          final fileID = controller.previewSticker.value?.stickerId;
          if (packID?.isNotEmpty != true && fileID?.isNotEmpty != true) {
            return const SizedBox.shrink();
          }
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectSticker(
                    controller.previewSticker.value!,
                    onSendSticker,
                  );
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  color: context.theme.appColors.blanket,
                  width: double.infinity,
                  child: StickerItemPreview(
                    width: 120.spMin,
                    height: 120.spMin,
                    packId: packID!,
                    fileId: fileID!,
                  ),
                ),
              ),
              if (UserController.instance.enableTroubleshoot)
                Positioned(
                  right: AppSpace.space2,
                  top: AppSpace.space2,
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.onSendSampleSticker(
                            packId: packID,
                            fileId: fileID,
                            onSendSticker: onSendSticker,
                          );
                        },
                        child: Assets.vectors.send.svg(
                          width: AppSize.size6,
                          height: AppSize.size6,
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.iconPrimaryInverse,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      AppSpace.space3.horizontalSpace,
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.clearPreviewSticker();
                        },
                        child: Assets.vectors.xClose.svg(
                          width: AppSize.size6,
                          height: AppSize.size6,
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.iconPrimaryInverse,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Positioned(
                  right: AppSpace.space2,
                  top: AppSpace.space2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      controller.clearPreviewSticker();
                    },
                    child: Assets.vectors.xClose.svg(
                      width: AppSize.size6,
                      height: AppSize.size6,
                      colorFilter: ColorFilter.mode(
                        context.theme.appColors.iconPrimaryInverse,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
            ],
          );
        });
  }

  Widget _buildReplyingOrEditingBox(BuildContext context) {
    return GetBuilder<ChatRoomInputController>(
      tag: 'chat-room-$roomTag',
      id: ChatRoomIds.replyingOrEditingBox,
      builder: (controller) {
        if (controller.replyingMessage() == null && controller.editingMessage() == null) {
          return const SizedBox.shrink();
        }

        List<Widget> widgetList = [];
        if (controller.replyingMessage() != null) {
          return ReplyMessagePopUpWidget(
            message: controller.replyingMessage.value!,
            onTapClose: () {
              controller.clearReplyingMessage();
              controller.chatRoomCtl?.setRepliedMessage(null);
            },
          );
        } else if (controller.editingMessage() != null) {
          widgetList = [
            AppText.body4(
              'Editing message'.tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
          ];
        }

        return Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.backgroundNeutralLighter,
            border: Border(top: BorderSide(color: context.theme.appColors.border)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
            vertical: AppSpace.space2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgetList,
              ),
              GestureDetector(
                onTap: () {
                  controller.clearReplyingMessage();
                  controller.clearEditingMessage();
                },
                child: Assets.vectors.xClose.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
