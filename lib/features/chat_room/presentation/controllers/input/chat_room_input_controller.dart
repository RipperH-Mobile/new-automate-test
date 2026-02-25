import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:emoji_extension/emoji_extension.dart' as emoji;
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/api/payloads/message/edit_message.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/controllers/user_interface_controller.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/unsupported_format_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_logger.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/link_metadata_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_last_typed_at_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_images_from_clipboard_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_text_from_clipboard_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/paste_board_image_preview_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sample_file_message_config_dialog.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sample_message_config_dialog.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sample_sticker_config_dialog.dart';
import 'package:uchat/features/chat_room/presentation/widgets/paste_board_image_preview/paste_board_image_preview.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/contact_selection/contact_selection_controller.dart';
import 'package:uchat/screens/contact_selection/contact_selection_screen.dart';
import 'package:uchat/screens/room_messages/enum/input_mode_state.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/fix_url.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/sheet/modal_bottom_sheet_new.dart';

class ChatRoomInputController extends GetxController {
  final _log = useLogger();
  final config = GetIt.I<ConfigDb>().authenticated;

  static const paddingKeyboard = AppSpace.space4;
  static const int keyboardAnimationDuration = 250;

  // This is a magic number to check whether the keyboard is opened or not because keyboard height value from native
  // when keyboard is closed is not zero.
  static const int minValidOpenedKeyboardHeight = 100;

  // GetX controller tag in this format : 'chat-room-roomID'
  final String tag;
  final bool enableMention;
  final String roomId;
  final enableWarMode = false.obs;

  ChatRoomInputController({
    required this.tag,
    required this.roomId,
    this.enableMention = false,
  });

  /// Global key for text field for mention.
  ///
  /// This key is used to control the mention text field.
  final GlobalKey<MentionTextFieldState> textFieldGlobalKey = GlobalKey<MentionTextFieldState>();
  final FocusNode textFieldFocusNode = FocusNode();
  final ScrollController textFieldScrollController = ScrollController();

  final hasCopiedImages = false.obs;

  final hasCopiedText = false.obs;

  /// Input mode state for keyboard, custom input, close
  final inputModeState = InputModeState.close.obs;

  ///  Previous input mode state for keyboard, custom input, close
  InputModeState prevInputModeState = InputModeState.close;

  /// If true, Show send message button.
  final showSendButton = false.obs;

  /// Keyboard type for show icon in text field.
  final keyboardType = ChatRoomKeyboardType.expanded.obs;

  /// Edit message data. Will be use to sent to server after send button is pressed.
  final editingMessage = Rx<MessageEntity?>(null);

  /// Reply message data. Will be use to display message and sender on top of text field and sent to server after
  /// send button is pressed.
  final replyingMessage = Rx<MessageEntity?>(null);

  /// Preview sticker data. Will be use to display sticker on top of text field.
  final previewSticker = Rx<StickerSendingEntity?>(null);

  /// Selected tab of custom input.
  final customInputType = Rx<ChatRoomCustomInputType>(ChatRoomCustomInputType.sticker);

  /// Snap keyboard height for sticker, gif.
  final swipeKeyboardHeight = 0.0.obs;

  /// Show more menu
  final isOpenMoreMenu = false.obs;

  final audioPlayerController = PlayerController();

  final recorderController = RecorderController();

  StreamSubscription<Duration>? recorderDurationSubscription;

  StreamSubscription<PlayerState>? playerStateSubscription;

  StreamSubscription? _contactUpdateSub;
  StreamSubscription? _onAppInActiveSub;
  StreamSubscription? _keyboardUpdateSub;

  /// If true, Will show recording audio ui instead of text field.
  final isRecordingAudio = false.obs;

  /// This is used to show waveform after stop record button is pressed.
  final isAudioRecordFinished = false.obs;

  /// This is used to show play or stop icon when playing recorded audio.
  final isPlayingAudioRecording = false.obs;

  /// File path of the recorded audio file.
  final audioRecordingPath = ''.obs;

  /// Duration of the recorded audio file.
  final recorderDuration = const Duration().obs;

  /// Mentionable members list.
  ///
  /// This list is used to show mention suggestion in text field.
  ///
  /// This list will be updated when members list is updated.
  final _mentionableMembers = <MentionInfoModel>[];

  /// Current url in text field.
  ///
  /// This url is used to get metadata of the url.
  final currentUrl = ''.obs;

  /// Map of url metadata.
  ///
  /// This map is used to store metadata of the url that user typed in text field.
  /// It stores all the link that happen in the text field, not only the current one.
  ///
  /// The key is the url and the value is the metadata of the url.
  final urlMetadataMap = <String, LinkMetadataModel>{}.obs;

  final mentionMarkModel = MentionMarkModel(
    trigger: '@',
    style: TextStyle(color: Get.context?.theme.appColors.textPrimary),
    matchAll: true,
    data: [],
    suggestionBuilder: (info) {
      return MentionSuggestionItem(data: info, onSelected: (info) {});
    },
  ).obs;

  /// Chat room controller
  ChatRoomController? get chatRoomCtl {
    try {
      return Get.find<ChatRoomController>(tag: roomId);
    } catch (e) {
      _log.e('ChatRoomController not found for roomId: $roomId', e);
      return null;
    }
  }

  ChatRoomStickerInputController? get chatStickerInputCtl {
    try {
      return Get.find<ChatRoomStickerInputController>(tag: 'chat-room-$roomId');
    } catch (e) {
      _log.e('ChatRoomController not found for roomId: $roomId', e);
      return null;
    }
  }

  String? get currentUserDisplayName {
    try {
      return UserController.instance.currentUser.value?.displayName;
    } catch (e) {
      return null;
    }
  }

  /// AnnotationEditingController is a customized TextEditingController from FlutterMention.
  /// Return a controller to control input text field (FlutterMentions).
  AnnotationTextEditingController? get textFieldController {
    return textFieldGlobalKey.currentState?.textEditingController;
  }

  final showPreviewText = false.obs;

  /// MentionTextFieldState is a customized State from FlutterMention.
  ///
  /// Return a state to control input text field (FlutterMentions).
  MentionTextFieldState get mentionTextFieldState {
    return textFieldGlobalKey.currentState!;
  }

  bool get isInputModeClose {
    return inputModeState.value == InputModeState.close;
  }

  bool get isInputModeKeyboard {
    return inputModeState.value == InputModeState.keyboard;
  }

  bool get isInputModeCustomInput {
    return inputModeState.value == InputModeState.customInput;
  }

  double get defaultCustomInputHeight {
    return Get.height * 0.45;
  }

  double get customInputHeightExpanded {
    return Get.height * 0.65;
  }

  bool get isCustomInputTypeImageAndVideo {
    return customInputType.value == ChatRoomCustomInputType.imageAndVideo;
  }

  /// mange custom input height
  double get customInputHeight {
    if (isInputModeCustomInput && isCustomInputTypeImageAndVideo) {
      if (swipeKeyboardHeight.value != 0) {
        return swipeKeyboardHeight.value;
      }
      return Get.height * 0.45;
    }
    if (swipeKeyboardHeight.value != 0) {
      return swipeKeyboardHeight.value;
    } else {
      return openedKeyboardHeight ?? defaultCustomInputHeight;
    }
  }

  // Whether or not to use scaffold resizeToAvoidBottomInset opening native keyboard.
  bool get useScaffoldBottomPadding {
    // First condition is to not use resizeToAvoidBottomInset after custom input is opened.
    // After switching or open custom input, We will use bottom padding to push the custom input up. not resizeToAvoidBottomInset.
    // Because switching from using bottom padding to resizeToAvoidBottomInset will cause the ui to bounce but switching
    // from resizeToAvoidBottomInset to bottom padding can be done seamlessly by setting animation duration to 0.
    // Second condition is to animate keyboard closing with resizeToAvoidBottomInset.
    return (inputModeState.value == InputModeState.keyboard && prevInputModeState != InputModeState.customInput);
  }

  // Whether or not to use empty box at the bottom of the screen to push the text field up.
  bool get useBottomPadding {
    // First condition is to use bottom padding when custom input is opened.
    // Second condition is to use bottom padding when switching from custom input to keyboard.
    // Because switching from using bottom padding to resizeToAvoidBottomInset will cause the ui to bounce but switching
    // from resizeToAvoidBottomInset to bottom padding can be done seamlessly by setting animation duration to 0.
    return inputModeState.value == InputModeState.customInput ||
        (inputModeState.value == InputModeState.keyboard && prevInputModeState == InputModeState.customInput);
  }

  // Whether or not to animate the bottom padding when keyboard height is changed.
  bool get showBottomPaddingAnimation {
    // Do not animate when switching from keyboard to image custom input because text field is already in correct position
    // and image bottom sheet should be opened immediately without any animation.
    if (inputModeState.value == InputModeState.customInput && prevInputModeState == InputModeState.keyboard) {
      return false;
    }

    // Animate bottom padding when opening or closing custom input.
    // But do not animate when switching from keyboard to custom input because when keyboard is already open, text field
    // is already in correct position from using resizeToAvoidBottomInset and we need to replace resizeToAvoidBottomInset
    // with empty box immediately to prevent ui bounce.
    return (inputModeState.value == InputModeState.customInput || prevInputModeState == InputModeState.customInput) &&
        prevInputModeState != InputModeState.keyboard;
  }

  double? openedKeyboardHeight;

  /// Get keyboard height for padding bottom of the screen.
  double get keyboardHeight {
    if (isInputModeClose) {
      // _log.d('keyboardHeight: ${Get.mediaQuery.viewPadding.bottom + paddingKeyboard}');
      return Get.mediaQuery.viewPadding.bottom + paddingKeyboard;
    }
    if (isInputModeKeyboard) {
      final keyboardData = UserInterfaceController.instance.keyboardData.value;

      // minValidOpenedKeyboardHeight is some random magic number. Because native returns non zero value when keyboard
      // is closed and on Android when opening keyboard it returns some small value once and then it returns the actual
      // height of keyboard. This Condition is used to ensure that we get the full height of keyboard.
      // When that happens, ui will show the keyboard with some small height and then it will animate to the actual height.
      // which cause to ui to bounce and looks weird.
      // This condition is to ignore that small value and only use the actual height of keyboard.
      if (keyboardData.height > minValidOpenedKeyboardHeight) {
        openedKeyboardHeight = keyboardData.height;
        return keyboardData.height;
      }

      // If keyboardData.height is some random small value, then we will use  the actual height of keyboard if we have that info.
      final savedHeight = openedKeyboardHeight;
      if (savedHeight != null) {
        return savedHeight;
      }
    }
    if (isInputModeCustomInput) {
      if (isCustomInputTypeImageAndVideo && swipeKeyboardHeight.value == 1.sh) {
        return Get.mediaQuery.viewPadding.bottom + paddingKeyboard;
      }

      return customInputHeight;
    }
    return Get.mediaQuery.viewPadding.bottom + AppSpace.space2;
  }

  String get audioDurationText {
    final duration = isAudioRecordFinished() ? recorderController.recordedDuration : recorderDuration.value;

    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  /// Throttle tag for send typing status.
  String get typingThrottleTag => 'sendIsTyping_$roomId';

  StickerController get stickerCtl {
    return Get.find<StickerController>();
  }

  @override
  void onInit() async {
    super.onInit();
    recorderDurationSubscription = recorderController.onCurrentDuration.listen((duration) {
      recorderDuration(duration);
    });

    final room = await GetIt.I<RoomDb>().getRoom(roomId);
    if (room?.draftMessage != null && room?.draftMessage != '') {
      setDraftMessage(room?.draftMessage ?? '');
    }

    if (room?.draftReplyMessage != null) {
      replyingMessage.value = room?.draftReplyMessage?.toEntity();
    }

    final ctl = chatRoomCtl;
    if (ctl != null) {
      ever(ctl.members, (changedMembers) async {
        await findMentionableMembers(
          members: changedMembers,
          roomCapability: ctl.roomCapability.value,
        );
      });
      ever(ctl.roomCapability, (roomCapability) async {
        await findMentionableMembers(
          members: ctl.members,
          roomCapability: roomCapability,
        );
      });
      _loadWarModeConfig();
    }

    _contactUpdateSub = eventBus.on<ContactUpdateEvent>().listen(
      (event) {
        onUpdateMentionInChatInput(event.contact);
      },
    );
    _onAppInActiveSub = eventBus.on<AppInactiveEvent>().listen(
      (event) async {
        await audioPlayerController.pauseAllPlayers();
      },
    );
    _keyboardUpdateSub = eventBus.on<UiKeyboardUpdateEvent>().listen((event) async {
      EasyDebounce.debounce('chat_keyboard_update', const Duration(milliseconds: 500), () {
        //! customInputFullScreen & customInput is a special state when custom input (GIF Search keyboard) is opened.
        if (event.keyboardUpdate.height > minValidOpenedKeyboardHeight &&
            inputModeState.value != InputModeState.customInputFullScreen &&
            inputModeState.value != InputModeState.customInput) {
          inputModeState.value = InputModeState.keyboard;
        } else {
          if (inputModeState.value == InputModeState.keyboard) {
            inputModeState.value = InputModeState.close;
          }
        }
      });
    });

    ever(inputModeState, (value) {
      if (value == InputModeState.close) {
        showPreviewText.value = true;

        // When keyboard is closed, reset text field selection. This fixes the issue paste button doesn't show up after
        // keyboard is closed.
        // step to reproduce the issue:
        // - tap text field to open keyboard
        // - long press to show paste button
        // - tap outside / do something to close keyboard
        // - long press text field again, paste button doesn't show up
        // This issue fixes itself when back out from chat screen or text field text has changed.
        // Possible reason is that flutter doesn't call contextMenuBuilder when text field state isn't changed so we
        // need to reset text field selection to force flutter to call contextMenuBuilder again.
        resetTextFieldSelection();
      } else {
        showPreviewText.value = false;
      }
    });

    // Get openedKeyboardHeight from local db if available. For calculating keyboard animation.
    openedKeyboardHeight = await GetIt.I<ConfigDb>().general.getDouble(key: ConfigDb.getOpenedKeyboardHeightKey());
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
  }

  @override
  void onClose() async {
    textFieldFocusNode.dispose();
    textFieldScrollController.dispose();
    audioPlayerController.dispose();
    await recorderDurationSubscription?.cancel();
    await playerStateSubscription?.cancel();
    await _contactUpdateSub?.cancel();
    await _onAppInActiveSub?.cancel();
    await _keyboardUpdateSub?.cancel();
    sendTypingStatus(false);

    super.onClose();
  }

  /// Mentionable members function
  ///
  /// This function will find mentionable members from the members list.
  ///
  /// [members] is a list of members in the chat room.
  ///
  /// This function will filter out the mentionable members and store it in the [_mentionableMembers] list.
  Future<void> findMentionableMembers({
    required List<RoomMemberCollection> members,
    required RoomCapabilityEntity roomCapability,
  }) async {
    if (members.isEmpty) return;

    final futureContacts = <Future<MentionInfoModel?>>[];
    for (final member in members) {
      if (member.isMe) continue;

      if (member.account == null) continue;

      final accountId = member.account!.id;
      if (accountId == null) continue;

      futureContacts.add(getContactOfMember(member));
    }

    final contacts = await Future.wait(futureContacts);
    final sortedContacts = contacts.whereType<MentionInfoModel>().sorted(
      (a, b) {
        final nameA = (a.display).trim().toLowerCase();
        final nameB = (b.display).trim().toLowerCase();

        return nameA.compareTo(nameB);
      },
    );

    _mentionableMembers.clear();

    if (chatRoomCtl?.room.value?.isGroup == true && roomCapability.disableMentionAll == false) {
      final allDisplayStr = 'All@mention'.trParams({'mention': ''});
      _mentionableMembers.insert(
        0,
        MentionInfoModel(
          id: UChatConstant.mentionAllId,
          display: allDisplayStr,
          nameValue: allDisplayStr,
          userName: allDisplayStr,
        ),
      );
    }

    _mentionableMembers.addAll(sortedContacts);
    mentionMarkModel.value = mentionMarkModel.value.copyWith(
      data: _mentionableMembers,
    );
  }

  /// Get contact of member
  ///
  /// This function will get contact of member from the database.
  Future<MentionInfoModel?> getContactOfMember(RoomMemberCollection member) async {
    final account = member.account;
    if (account == null) {
      return null;
    }

    final accountId = account.id;
    if (accountId == null) {
      return null;
    }

    final contact = await GetIt.I<GetContactUseCase>().call(ContactParams(accountId: accountId));

    if (contact != null) {
      if (contact.isDeleted == true) {
        return null;
      }

      return MentionInfoModel(
        id: contact.id ?? '',
        display: contact.shortName ?? '',
        nameValue: contact.displayName ?? '',
        userName: contact.username ?? '',
        fullName: contact.shortName ?? '',
        photoUrl: contact.avatarUrl,
      );
    }

    if (account.isDeleted == true) {
      return null;
    }

    return MentionInfoModel(
      id: account.id ?? '',
      display: account.shortName ?? '',
      nameValue: account.displayName ?? '',
      userName: account.username ?? '',
      fullName: account.shortName ?? '',
      photoUrl: account.avatarUrl,
    );
  }

  /// Keyboard / text field function
  Future<void> onBodyTap() async {
    prevInputModeState = inputModeState.value;
    inputModeState.value = InputModeState.close;
    keyboardType.value = ChatRoomKeyboardType.expanded;
    // TODO: CHECK @punkaze
    // showSendButton.value = false;
    textFieldGlobalKey.currentState?.showSuggestions.value = false;
    textFieldFocusNode.unfocus();
  }

  void onCustomInputTrigger() {
    textFieldFocusNode.unfocus();
    prevInputModeState = inputModeState.value;
    inputModeState.value = InputModeState.customInput;
  }

  Future<void> onKeyboardTap() async {
    if (chatRoomCtl?.isShowOAActionBarMode.value == true) {
      chatRoomCtl?.isShowOAActionBarMode(false);
    }
    if (Platform.isIOS) {
      // Default as 'true' to prevent adding a paste image button
      hasCopiedImages.value =
          await GetIt.I<NativeMethodChannelService>().invokeMethod<bool>('getHasImageWasCopied') ?? true;

      hasCopiedText.value =
          await GetIt.I<NativeMethodChannelService>().invokeMethod<bool>('getHasTextWasCopied') ?? false;
    }
    if (Platform.isAndroid) {
      hasCopiedText.value = await GetIt.I<GetTextFromClipboardUseCase>().call(NoParams());
    }
    // TODO: CHECK @punkaze
    if (textFieldController?.text.isNotEmpty == true) {
      showSendButton.value = true;
    }

    if (UChatScreenUtil.instance.isMobilePlatform) {
      prevInputModeState = InputModeState.customInput;
      inputModeState(InputModeState.keyboard);
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickSendboxChatroom);
      if (textFieldController?.text != '') {
        keyboardType(ChatRoomKeyboardType.collapsed);
      } else {
        keyboardType(ChatRoomKeyboardType.expanded);
      }
    }
    textFieldFocusNode.requestFocus();
  }

  void onKeyboardClose() {
    if (isInputModeCustomInput) return;

    if (inputModeState.value == InputModeState.keyboard) {
      /// Send typing status to server
      sendTypingStatus(false);
    }

    textFieldFocusNode.unfocus();
    prevInputModeState = inputModeState.value;
    inputModeState(InputModeState.close);
  }

  void toggleMoreMenu() {
    isOpenMoreMenu.toggle();
    onKeyboardClose();
  }

  List<ContextMenuButtonItem> getButtonItems(
    EditableTextState editableTextState, {
    required void Function({List<MessageLinkModel> links, required String message}) onSendText,
  }) {
    return buildPasteContextMenuItems(
      editableTextState: editableTextState,
      hasCopiedText: hasCopiedText.value,
      hasCopiedImages: hasCopiedImages.value,
      onPaste: () => pasteImage(onSendText, editableTextState),
    );
  }

  void pasteImage(
    void Function({List<MessageLinkModel> links, required String message}) onSendText,
    EditableTextState editableTextState,
  ) async {
    try {
      //NOTE. Action Paste here
      if (chatRoomCtl?.room.value?.isSystem == true) {
        editableTextState.hideToolbar();
        return;
      }

      onKeyboardClose();
      final images = await GetIt.I<GetImagesFromClipboardUseCase>().call(NoParams());

      if (images.isEmpty) return;

      await ModalBottomSheetNew.showBottomSheetFixHeight(
        context: Get.context!,
        height: PasteBoardImagePreviewBottomSheet.height +
            ModalBottomSheetNew.headerHeight +
            Get.mediaQuery.viewPadding.bottom,
        children: [
          GetBuilder<PasteBoardImagePreviewController>(
            tag: tag,
            init: PasteBoardImagePreviewController(
              tag: tag,
              roomId: roomId,
              clipboardImages: images,
              mentionMarkModel: mentionMarkModel.value,
              useCase: GetIt.I<GetStreamImagesUseCase>(),
              onSendMessage: (message) {
                onSendText(message: message);
              },
            ),
            builder: (ctl) {
              return Portal(
                child: PasteBoardImagePreviewBottomSheet(tagString: tag),
              );
            },
          )
        ],
      );
    } on UnsupportedFormatException {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unsupported Format'.tr,
        description: 'The pasted content\'s format is not supported'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
      );
    } catch (e) {
      _log.e('Error pasting image from clipboard', e);
    }
  }

  void onTextFieldChanged(String value) {
    // This if is used to check for empty line in desktop or something.
    // Recheck this again and remove

    // save draft message

    chatRoomCtl?.saveDraftMessage(value);

    if (!UChatScreenUtil.instance.isMobile && value == '\n') {
      textFieldController?.text = '';
      return;
    }

    if (value.length == 1 && chatRoomCtl?.room.value != null) {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.typingMessage,
        eventProperties: EventProperty.typingMessage(
          EventProperty.getChatTypeForEventParams(
            chatRoomCtl?.room.value!,
          ),
        ),
      );
    }

    // chatRoomCtl?.updateDraftMessage(value);

    if (value.isEmpty) {
      keyboardType.value = ChatRoomKeyboardType.expanded;
      showSendButton.value = false;
      currentUrl.value = '';
    } else {
      if (textFieldFocusNode.hasFocus) {
        keyboardType.value = ChatRoomKeyboardType.collapsed;
        showSendButton.value = true;

        /// Send typing status to server
        sendTypingStatus(true);

        if (mentionTextFieldState.hasUrl) {
          // If the text field has url, then get the url and map the metadata.
          // Set the current url to the url that user typed for showing link preview (only the first url).
          final url = mentionTextFieldState.urlMatches.first;
          currentUrl.value = url;

          // Map link metadata of all the urls in the text field.
          mapLinkMetadata();
        } else {
          // If the text field doesn't have url, then close the link preview.
          currentUrl.value = '';
        }
      }
    }

    // TODO (chat room refactor) Update draft message data here.
    // TODO (chat room refactor) Send is typing to server here.
    // TODO (chat room refactor) Move suggest sticker from emoji code to use case and call it here.
  }

  void setDraftMessage(String text) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      textFieldController?.text = text;
      showSendButton.value = textFieldController?.text.isNotEmpty ?? false;
      inputModeState.value = InputModeState.close;
      keyboardType.value = ChatRoomKeyboardType.expanded;
    });
  }

  /// Map link metadata function
  ///
  /// This function will get metadata of the url that user typed in text field.
  Future<void> mapLinkMetadata() async {
    final urls = mentionTextFieldState.urlMatches;
    if (urls.isEmpty) {
      return;
    }

    final futures = <Future<void>>[];
    for (final url in urls) {
      futures.add(_getLinkMetadata(url));
    }

    await Future.wait(futures);
    urlMetadataMap.refresh();
  }

  /// Get link metadata function
  ///
  /// This function will get metadata of the url.
  ///
  /// [url] is the url of the link that user typed in text field.
  Future<void> _getLinkMetadata(String url) async {
    if (urlMetadataMap.containsKey(url)) {
      // If the metadata is already fetched, then return.
      return;
    }

    /// Get metadata of the url using AnyLinkPreview.
    /// NOTE.if user text google.com or google.co it's will be https://google.com but user's text it's still same text
    /// need to do this because BE can detect it's a link so FE need to detect too
    /// Use this [UChatConstant.whatsAppAndroidUserAgent] user agent to get a link preview. It's an android WhatsApp agent,
    /// but it can be used for both IOS and android
    try {
      final metadata = await AnyLinkPreview.getMetadata(
        link: ensureUrlHasScheme(url.trim()),
        userAgent: UChatConstant.whatsAppAndroidUserAgent,
      );

      if (metadata != null) {
        // If the metadata is not null, then store it in the urlMetadataMap.
        urlMetadataMap[url] = LinkMetadataModel.fromAnyLinkPreview(metadata: metadata, url: url);
      }
    } catch (e, st) {
      _log.w('Error getting link metadata for url: $url', e, st);
      // If there is an error, we can choose to ignore it or log it.
      // For now, we will just log the error.
    }
  }

  /// Close link preview function
  ///
  /// This function will close the link preview.
  ///
  /// [url] is the url of the link that user typed in text field.
  void onCloseLinkPreview(String url) {
    currentUrl.value = '';
    final metadata = urlMetadataMap[url];
    if (metadata != null) {
      // If the metadata is not null, then set the show to false to prevent showing the link preview.
      urlMetadataMap[url] = metadata.copyWith(show: false);
      urlMetadataMap.refresh();
    }
  }

  void expandKeyboardIcons() {
    keyboardType.value = ChatRoomKeyboardType.expanded;
  }

  /// Audio recording function
  void startRecording() async {
    final isDuringCall = await UChatCallController.instance.isDuringCall;
    final context = Get.context;

    if (isDuringCall) {
      if (context != null && context.mounted) {
        UChatNewDialog.showPreventPlayAudioDuringCall(context: context);
      }

      return;
    }

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickAudioIcon);
    onKeyboardClose();
    final hasPermission = await PermissionController.instance.checkMicrophonePermission();

    if (hasPermission) {
      isRecordingAudio(true);
      isAudioRecordFinished(false);
      String path = (await getTemporaryDirectory()).path;
      await recorderController.record(
        path: '$path/record_audio.m4a',
        androidEncoder: AndroidEncoder.aac,
        androidOutputFormat: AndroidOutputFormat.mpeg4,
        iosEncoder: IosEncoder.kAudioFormatMPEG4AAC,
        // 16,000 Hz (or 16 kHz) is a common sample rate for voice recordings (like phone calls or voice memos)
        // For comparison, CD-quality music uses 44,100 Hz (44.1 kHz).
        sampleRate: 44100,
        // Higher bit rate = Better quality = Larger file size
        bitRate: 64000,
        // Big-Endian (true): The most significant byte is stored first.
        // Little-Endian (false): The least significant byte is stored first.
        // (This is more common on modern processors like Intel).
        linearPCMIsBigEndian: true,
        // 16-bit is the standard for most audio, including CDs.
        // It means each sample can be one of 65,536 (2¹⁶) possible values,
        // which is excellent for general-purpose recording.
        linearPCMBitDepth: 16,
        // false (Integer): The sample is stored as a whole number
        // (e.g., from -32,768 to +32,767 for 16-bit).

        // true (Float): The sample is stored as a decimal number (a "floating-point" number),
        // typically normalized between -1.0 and +1.0.
        linearPCMIsFloat: true,
      );
    }
  }

  void handleRecordingButtonPressed() {
    if (isAudioRecordFinished()) {
      playOrPauseAudioRecording();
    } else {
      stopRecording();
    }
  }

  void stopRecording() async {
    // stop audio record
    await setAudioRecordingPath();

    await audioPlayerController.preparePlayer(
      path: audioRecordingPath(),
      shouldExtractWaveform: true,
      noOfSamples: 73,
    );

    audioPlayerController.setFinishMode(finishMode: FinishMode.pause);

    playerStateSubscription = audioPlayerController.onPlayerStateChanged.listen(
      (PlayerState playerState) {
        if (playerState.isPlaying) {
          isPlayingAudioRecording(true);
        } else {
          isPlayingAudioRecording(false);
        }
      },
    );

    isAudioRecordFinished(true);
  }

  Future<void> setAudioRecordingPath() async {
    String path = (await recorderController.stop()) ?? '';

    if (path.isEmpty) return;

    audioRecordingPath(path.replaceFirst('//', ''));
  }

  void cancelRecording() async {
    isRecordingAudio(false);
    isAudioRecordFinished(false);
    audioRecordingPath('');
    audioPlayerController.stopPlayer();
    recorderController.stop();
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCancelAudio);
  }

  void playOrPauseAudioRecording() async {
    if (audioPlayerController.playerState.isPlaying) {
      await audioPlayerController.pausePlayer();
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickPauseAudio);
    } else {
      await audioPlayerController.startPlayer();
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinueAudio);
    }
  }

  Future<File> getAudioRecordingFile() async {
    isRecordingAudio(false);
    isAudioRecordFinished(false);
    if (audioRecordingPath().isEmpty) await setAudioRecordingPath();

    return File(audioRecordingPath());
  }

  void onSendAudio(Function(FileInfoModel) onSendAudioRecording) async {
    await audioPlayerController.pausePlayer();
    final fileData = await FileInfoModel.fromFile(await getAudioRecordingFile(), 0);
    onSendAudioRecording(fileData);
    audioRecordingPath.value = '';
    keyboardType.value = ChatRoomKeyboardType.expanded;
  }

  /// Sending message function.
  /// for share uchat contact
  Future<void> showMoreSendOptionUChatContact(Function(List<ContactCollection>) onShareUChatContact) async {
    selectUChatFriends(onShareUChatContact);
  }

  /// for share mobile contact
  Future<void> showMoreSendOptionMobileContact(Function(List<Contact>) onSharePhoneContact) async {
    selectMobileContacts(onSharePhoneContact);
  }

  /// for share location
  Future<void> showMoreSendOption(Function(MapInfoResponse) onShareLocation) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickAddLocation);
    selectLocation(onShareLocation);
  }

  Future<void> selectLocation(Function(MapInfoResponse) onShareLocation) async {
    shareLocation(onShareLocation);
  }

  void shareLocation(Function(MapInfoResponse) onShareLocation) async {
    final ctx = Get.context!;

    // ask permission
    final permissionGranted = await PermissionController.instance.requestLocationPermissionDirect(ctx);
    if (!permissionGranted) {
      // user denied => do nothing
      return;
    }

    final res = await GetIt.I<GetLocationUseCase>().call(NoParams());
    if (res != null) {
      onShareLocation(res);
    }
  }

  void sendFile(Function(FileInfoModel) onSendFile) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickAddShareafile);
    final res = await GetIt.I<PickFileUseCase>().call(NoParams());
    res.match((e) {}, (file) {
      onSendFile(file);
    });
  }

  void sendSampleFile(Function(FileInfoModel, {int loopCount}) onSendFile) async {
    if (debugSendMockMessageIsSending.value == true) {
      return;
    }

    final result = await GetIt.I<PickFileUseCase>().call(NoParams());
    final sampleFile = result.match((l) => null, (r) => r);

    if (sampleFile != null) {
      debugSendMockMessageIsSending.value = true;

      await Get.dialog(
        DebugSendSampleFileMessageConfigDialog(
          fileInfo: sampleFile,
          onSendFile: onSendFile,
          onCancel: () {
            Get.back();
          },
        ),
        barrierDismissible: false,
      );

      debugSendMockMessageIsSending.value = false;
    }
  }

  Future<void> selectUChatFriends(Function(List<ContactCollection>) onShareUChatContact) async {
    shareUChatContact(onShareUChatContact);
  }

  Future<void> selectMobileContacts(Function(List<Contact>) onSharePhoneContact) async {
    sharePhoneContact(onSharePhoneContact);
  }

  void shareUChatContact(Function(List<ContactCollection>) onShareUChatContact) async {
    List<ContactCollection>? contacts = [];
    if (UChatScreenUtil.instance.isMobile) {
      contacts = await Get.toNamed(
        Routes.contactSelection.replaceAll(':id', tag),
        arguments: SelectMemberArguments(
          fromSendContact: true,
        ),
      );
    } else {
      // TODO: implement share contact for desktop
      contacts = await UChatDialog.showCustomDialog<List<ContactCollection>, ContactSelectionController>(
        child: (_) => const ContactSelectionScreen(roomId: 'room id'),
        init: ContactSelectionController(tag: 'room id'),
        tag: 'room id',
        initState: (state) {
          if (state.mounted && state.controller?.initialized == true) {
            state.controller?.maxSelectedContact(10);
            state.controller?.ignoredContacts([]);
          }
        },
      );
    }
    if (contacts != null && contacts.isNotEmpty) {
      onShareUChatContact(contacts);
    }
  }

  void sharePhoneContact(Function(List<Contact>) onSharePhoneContact) async {
    final ctx = Get.context!;

    // ask permission
    final permissionGranted = await PermissionController.instance.requestContactPermissionDirect(ctx);
    if (!permissionGranted) {
      // user denied => do nothing
      return;
    }

    final contacts = await showCupertinoModalBottomSheet<List<Contact>?>(
      expand: true,
      context: ctx,
      topRadius: const Radius.circular(AppRadius.rounded2xl),
      builder: (context) {
        return GetBuilder(
          init: MobileContactListScreenController(
            tag: tag,
          ),
          builder: (_) {
            return const MobileContactListScreen();
          },
        );
      },
    );

    // Send contact to server
    if (contacts != null && contacts.isNotEmpty) {
      onSharePhoneContact(contacts);
    }
  }

  Future<void> openGalleryPicker(
    Function(MediaGalleryResult) onImageAndVideoPicked,
  ) async {
    final mediaGalleryService = GetIt.I<MediaGalleryService>();
    final isGranted = await mediaGalleryService.checkPermission();

    if (!isGranted) {
      final permissionGranted = await mediaGalleryService.requestPermission();
      if (!permissionGranted) {
        return;
      }
    }

    prevInputModeState = inputModeState.value;
    inputModeState.value = InputModeState.customInput;
    textFieldFocusNode.unfocus();
    customInputType(ChatRoomCustomInputType.imageAndVideo);

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickPictureIcon);
  }

  void openCamera(Function(FileInfoModel) onTakePicture) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCameraIcon);

    if (UChatCallController.instance.isSomeoneCameraOn) {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to access the camera while on a video call. Please try again after the call ends.'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
      return;
    }

    final response = await GetIt.I<TakePhotoAndVideoUseCase>().call(roomId);
    if (response != null) {
      onTakePicture(response);
    }
  }

  void openCustomInput() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickStickerIcon);
    prevInputModeState = inputModeState.value;
    inputModeState.value = InputModeState.customInput;
    customInputType(ChatRoomCustomInputType.sticker);
    textFieldFocusNode.unfocus();
    keyboardType.value = ChatRoomKeyboardType.switchMode;

    chatStickerInputCtl?.onOpenStickerSelection();
  }

  void closeCustomInput({bool isOpenKeyboard = true}) async {
    keyboardType.value = ChatRoomKeyboardType.expanded;
    prevInputModeState = inputModeState.value;
    if (isOpenKeyboard) {
      textFieldFocusNode.requestFocus();
      // await Future.delayed(const Duration(milliseconds: 100));
      inputModeState.value = InputModeState.keyboard;
    } else {
      inputModeState.value = InputModeState.close;
    }
    swipeKeyboardHeight.value = 0.0;
  }

  void onSendPressed({
    required void Function({required String message, List<MessageLinkModel> links}) onSendText,
    Function(StickerSendingEntity)? onSendSticker,
    Function(EditMessageRequest)? onEditText,
  }) async {
    final message = textFieldController?.markupText.$1.trim();

    if (textFieldController?.text.isNotEmpty != true && message?.isNotEmpty != true) {
      return;
    }

    final links = <MessageLinkModel>[];
    for (var url in mentionTextFieldState.urlMatches) {
      final urlMetadata = urlMetadataMap[url];
      if (urlMetadata != null) {
        links.add(urlMetadata.toMessageLinkModel());
      } else {
        links.add(MessageLinkModel(url: url));
      }
    }

    final isEmoji = message?.emojis.only ?? false;

    if (editingMessage() != null && onEditText != null) {
      /// Case edit message.
      onEditText(
        EditMessageRequest(
          messageId: editingMessage()?.id ?? '',
          newMessage: message!,
          // TODO: should handle isEncrypted in better way
          //   isEncrypted: editingMessage()!.isEncrypted,
          isEncrypted: false,
          meta: MessageMetaModel(
            isEmoji: isEmoji,
            isRegEx: isEmoji || checkMentionOrPhoneNumberOrEmailInText(textFieldController?.text ?? ''),
          ),
          links: links,
        ),
      );
      clearEditingMessage();
    } else {
      // Case send normal message

      onSendText(message: message ?? '', links: links);
      clearReplyingMessage();
    }
    textFieldController?.clear();

    if (previewSticker() != null && onSendSticker != null) {
      /// Case send sticker
      onSendSticker(previewSticker()!);
      // Reset previewSticker value back to null after sending.
      clearPreviewSticker();
    }
  }

  bool checkMentionOrPhoneNumberOrEmailInText(String text) {
    // Find all mention using regex
    RegExp mentionRegExp = RegExp(UChatConstant.mentionRegexPattern);
    final mentionMatches = mentionRegExp.allMatches(text);

    // Find all phone numbers using regex
    RegExp phoneRegExp = RegExp(UChatConstant.regExPhoneNumberPattern);
    final phoneMatches = phoneRegExp.allMatches(text);

    // Find all email addresses using regex
    RegExp emailRegExp = RegExp(UChatConstant.regExEmailPattern);
    final emailMatches = emailRegExp.allMatches(text);

    // This will return true if one of these is true
    return mentionMatches.isNotEmpty || phoneMatches.isNotEmpty || emailMatches.isNotEmpty;
  }

  /// Call this function when reply button is pressed.
  void setReplyingMessage(MessageEntity message) {
    replyingMessage(message);
    clearEditingMessage();
  }

  /// Call this function to cancel reply message.
  void clearReplyingMessage({bool callChatRoomCtl = true}) {
    replyingMessage.value = null;
    if (callChatRoomCtl) {
      chatRoomCtl?.setRepliedMessage(null);
    }
  }

  /// Call this function when edit message button is pressed.
  void setEditingMessage(MessageEntity message) {
    editingMessage(message);
    textFieldController?.value = TextEditingValue(text: message.message?.displayMention(getDisplay: true) ?? '');
    onKeyboardTap();
    // Reply message and edit message can't be done at the same time
    clearReplyingMessage();
  }

  /// Call this function to cancel edit message.
  void clearEditingMessage() {
    if (editingMessage.value != null) {
      textFieldController?.clear();
    }

    editingMessage.value = null;
    update([ChatRoomIds.replyingOrEditingBox]);
  }

  void selectSticker(
    StickerSendingEntity sticker,
    Function(StickerSendingEntity) onSendSticker,
  ) async {
    if (enableWarMode.value) {
      onSendSticker(sticker);
    } else if (previewSticker() == sticker) {
      onSendSticker(previewSticker()!);
      // Reset previewSticker value back to null after sending.
      clearPreviewSticker();
    } else {
      if (swipeKeyboardHeight.value != 0) {
        swipeKeyboardHeight.value = 0.0;
        await Future.delayed(const Duration(milliseconds: 100));
      }
      previewSticker(sticker);
      update();
    }
  }

  void clearPreviewSticker() {
    previewSticker.value = null;
    update();
  }

  void sendGif(GifSendingEntity entity, Function(GifSendingEntity) onSendGif) {
    onSendGif(entity);
  }

  void onTapToMention(String mentionText) async {
    if (chatRoomCtl?.roomCapability.value.disableSendMessage == true) return;
    try {
      // If the keyboard is closed, open the keyboard first
      if (inputModeState.value == InputModeState.close) {
        await onKeyboardTap();
      }

      final result = GetIt.I<TapToMentionUseCase>().call(TapToMentionParams(
        mentionText: mentionText,
        inputText: textFieldController?.text ?? '',
        cursorPos: textFieldController?.selection.baseOffset ?? 0,
      ));

      textFieldController?.text = result.text;

      if (result.cursorPos != null) {
        textFieldController?.selection = result.cursorPos!;
      }
    } catch (e, stackTrace) {
      _log.e('onTapToMention error.', e, stackTrace);
    }
  }

  void onUpdateMentionInChatInput(ContactCollection contact) {
    try {
      final isChatInputEmpty = textFieldController?.text.isNotEmpty != true;
      final markupText = textFieldController?.markupText;

      // If there is no mention in inputField
      if (isChatInputEmpty ||
          markupText == null ||
          !markupText.$1.contains(RegExp(UChatConstant.mentionRegexPattern)) ||
          textFieldController?.mapping == null) {
        _log.w('onUpdateMentionInChatInput: No mention found in input field.');
        return;
      }

      final result = GetIt.I<UpdateMentionInChatInputUseCase>().call(UpdateMentionInChatInputParams(
        contact: contact,
        markupText: markupText,
        mapping: textFieldController?.mapping ?? {},
      ));

      if (result.newMapping != null) {
        textFieldController?.mapping = result.newMapping!;
      }

      if (result.updatedName != null) {
        textFieldController?.text = result.updatedName!;
      }
    } catch (e, stackTrace) {
      _log.e('updateChatInputMention error.', e, stackTrace);
    }
  }

  /// Send typing status to server
  ///
  /// This function will send typing status to server with throttle time
  /// to prevent spamming the server.
  ///
  /// [isTyping] is a boolean value to determine if user is typing or not.
  Future<void> sendTypingStatus(bool isTyping) async {
    /// This throttle function is used to prevent spamming the server.
    /// It will send typing status to server immediately after user start typing
    /// and wait for a certain time before sending another typing status.
    EasyThrottle.throttle(
      typingThrottleTag,
      const Duration(seconds: UChatConstant.typingDebounceTimeInSeconds),
      () async {
        try {
          await GetIt.I<UpdateLastTypedAtUseCase>().call(
            UpdateLastTypedAtRequest(
              roomId: roomId,
              isTyping: isTyping,
              displayName: currentUserDisplayName,
            ),
          );
        } catch (e, stacktrace) {
          _log.w('updateLastTypedAt failed', e, stacktrace);
        }
      },
    );
  }

  // Reset text field text selection and cursor position.
  void resetTextFieldSelection() {
    textFieldGlobalKey.currentState?.textEditingController.selection = const TextSelection.collapsed(
      offset: -1,
    );
  }

  ///
  /// Special debug function
  /// For easy debug sequence message
  ///
  /// Below line is start of debug function
  /// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

  ///
  /// [Part of debug function]
  /// Debug send sequence message dialog
  /// For showing loading indicator and check dialog state.
  ///
  final debugSendSequenceMessageIsSending = false.obs;
  final debugSendSequenceMessageIsDialogShowing = false.obs;

  ///
  /// For controlling the number of messages and delay
  ///
  final TextEditingController debugSendSequenceMessageDelayController = TextEditingController();
  final TextEditingController debugSendSequenceMessageAmountController = TextEditingController();
  final _debugSendSequenceMessageFormKey = GlobalKey<FormState>();

  ///
  /// Handle to show debug send sequence message dialog
  ///
  void showDebugSendSequenceMessageSliderDialog({
    required FutureOr<void> Function({required String message, List<MessageLinkModel> links}) onSendText,
  }) {
    debugSendSequenceMessageIsDialogShowing.value = true;
    debugSendSequenceMessageDelayController.text = '300';
    debugSendSequenceMessageAmountController.text = '20';

    Get.dialog(
      Obx(() {
        return DebugSendSequenceMessageInput(
          formKey: _debugSendSequenceMessageFormKey,
          delayController: debugSendSequenceMessageDelayController,
          amountController: debugSendSequenceMessageAmountController,
          onSend: () => debugSendSequenceMessage(onSendText: onSendText),
          onCancel: () {
            debugSendSequenceMessageIsDialogShowing.value = false;
            Get.back();
          },
          isSending: debugSendSequenceMessageIsSending.value,
        );
      }),
      barrierDismissible: false,
    );
  }

  ///
  /// For sending sequence message
  ///
  Future<void> debugSendSequenceMessage({
    required FutureOr<void> Function({required String message, List<MessageLinkModel> links}) onSendText,
  }) async {
    if (debugSendSequenceMessageIsSending.value) {
      return;
    }

    if (!_debugSendSequenceMessageFormKey.currentState!.validate()) {
      return;
    }

    final randomChar1 = getRandomUppercaseLetter();
    final randomChar2 = getRandomUppercaseLetter();
    final randomChar3 = getRandomUppercaseLetter();

    final delay = int.parse(debugSendSequenceMessageDelayController.text);
    final amount = int.parse(debugSendSequenceMessageAmountController.text);

    debugSendSequenceMessageIsSending.value = true;
    try {
      for (var i = 1; i <= amount; i++) {
        await onSendText(message: '$randomChar1$randomChar2$randomChar3 - $i', links: []);
        await Future.delayed(Duration(milliseconds: delay));
      }
    } catch (_) {}
    debugSendSequenceMessageIsSending.value = false;

    if (debugSendSequenceMessageIsDialogShowing.value) {
      Get.back();
    }

    debugSendSequenceMessageIsDialogShowing.value = false;
  }

  ///
  /// [Part of debug function]
  /// Debug send mock message dialog
  /// For showing loading indicator and check dialog state.
  ///
  final debugSendMockMessageIsSending = false.obs;
  final debugSendMockMessageIsDialogShowing = false.obs;

  ///
  /// For controlling the number of messages and delay
  ///
  final TextEditingController debugSendMockMessageDelayController = TextEditingController();
  final TextEditingController debugSendMockMessageAmountController = TextEditingController();
  final _debugSendMockMessageFormKey = GlobalKey<FormState>();

  ///
  /// Handle to show debug send mock message dialog
  ///
  void showDebugSendMockMessageSliderDialog() {
    debugSendMockMessageIsDialogShowing.value = true;
    debugSendMockMessageDelayController.text = '100';
    debugSendMockMessageAmountController.text = '200';

    Get.dialog(
      Obx(() {
        return DebugSendMockMessageInput(
          formKey: _debugSendMockMessageFormKey,
          delayController: debugSendMockMessageDelayController,
          amountController: debugSendMockMessageAmountController,
          onSend: () => debugSendMockMessage(),
          onCancel: () {
            debugSendMockMessageIsDialogShowing.value = false;
            Get.back();
          },
          isSending: debugSendMockMessageIsSending.value,
        );
      }),
      barrierDismissible: false,
    );
  }

  ///
  /// For sending mock message
  ///
  Future<void> debugSendMockMessage() async {
    if (debugSendMockMessageIsSending.value) {
      return;
    }

    if (!_debugSendMockMessageFormKey.currentState!.validate()) {
      return;
    }

    final delay = int.parse(debugSendMockMessageDelayController.text);
    final amount = int.parse(debugSendMockMessageAmountController.text);

    debugSendMockMessageIsSending.value = true;
    try {
      await GetIt.I<DebugSendMockMessageUseCase>().call(
        DebugSendMockMessageParams(
          roomId: roomId,
          delay: delay,
          amount: amount,
        ),
      );
    } catch (_) {}
    debugSendMockMessageIsSending.value = false;

    if (debugSendMockMessageIsDialogShowing.value) {
      Get.back();
    }

    debugSendMockMessageIsDialogShowing.value = false;
  }

  void showMessageStateDetailsDialog() {
    final notificationLogger = GetIt.I<NotificationLogger>();
    final messageStateLogs = notificationLogger.getMessageStateLogs(roomId: roomId);

    if (!notificationLogger.isEnabled) {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Notification Logging Disabled'.tr,
        description:
            'Notification logging needs to be enabled to view message state logs. Please enable it in the notification debug settings.'
                .tr,
        confirmText: 'OK'.tr,
      );
      return;
    }

    if (messageStateLogs.isEmpty) {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'No Message State Logs'.tr,
        description: 'No message state logs found for this room'.tr,
        confirmText: 'OK'.tr,
      );
      return;
    }

    Get.toNamed(
      '/notification_debug/message_state_details',
      arguments: {'log': messageStateLogs.first},
    );
  }

  ///
  /// [Part of debug function]
  /// For showing debug send sequence message dialog
  ///
  bool get isTroubleshootEnabled {
    return UserController.instance.enableTroubleshoot;
  }

  ///
  /// [Part of debug function]
  /// For specific testing
  ///
  String getRandomUppercaseLetter() {
    final random = Random();
    final randomNumber = random.nextInt(26);
    final charCode = 65 + randomNumber;
    return String.fromCharCode(charCode);
  }

  ///
  /// [Part of debug function]
  /// Show Queue Monitor Dashboard
  ///
  void showQueueMonitorDashboard() {
    final messageListController = Get.find<MessageListController>(tag: tag);

    if (messageListController.queueMonitor == null) {
      Get.snackbar(
        'Monitor Not Available',
        'Queue monitor is not initialized for this room',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed(
      Routes.queueMonitorDashboard,
      arguments: QueueMonitorArguments(
        roomId: roomId,
        roomName: messageListController.chatRoomCtl.room.value?.roomName ?? 'Unknown Room',
        controllerTag: tag,
      ),
    );
  }

  Future<void> debugSendSampleMessage({
    required FutureOr<void> Function({required String message, List<MessageLinkModel> links, int loopCount}) onSendText,
  }) async {
    if (debugSendMockMessageIsSending.value) {
      return;
    }

    debugSendMockMessageIsSending.value = true;

    await Get.dialog(
      DebugSendSampleMessageConfigDialog(
        onSendText: onSendText,
        onCancel: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );

    debugSendMockMessageIsSending.value = false;
  }

  void onSendSampleSticker({
    required String packId,
    required String fileId,
    required Function(StickerSendingEntity, {int loopCount}) onSendSticker,
  }) async {
    await Get.dialog(
      DebugSendSampleStickerConfigDialog(
        sticker: StickerSendingEntity(
          stickerPackId: packId,
          stickerId: fileId,
        ),
        onSendSticker: onSendSticker,
        onCancel: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
    clearPreviewSticker();
  }

  /// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /// End of debug function
  /// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
