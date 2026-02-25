import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:emoji_extension/emoji_extension.dart' as emoji;
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/api/payloads/message/edit_message.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/services/official_account_service.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/domain/entities/share_message_selection_entity.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/core/event_bus/events/connectivity_changed_event.dart';
import 'package:uchat/core/event_bus/events/ownership_transferred_event.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/core/event_bus/events/update_admin_permission_event.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/api_friend_limit_exceed_exception.dart';
import 'package:uchat/core/exceptions/api_official_account_limit_exceed_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/call_status_type.dart';
import 'package:uchat/entities/enum/message_file_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/presentation/arguments/add_to_album_arguments.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_subscription_mapper_extension.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_to_server_params.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/save_draft_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/params/delete_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/delete_other_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/edit_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/params/oa_rich_menu_params.dart';
import 'package:uchat/features/chat_room/domain/params/unsent_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_other_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/edit_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_member_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_oa_rich_menu_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_subscription_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/pin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/save_draft_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/send_file_message_to_server_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/send_message_to_server_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/send_read_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_message_image_selection_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_message_selection_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unsent_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_draft_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_member_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_room_sub_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/calculate_member_last_read_at.dart';
import 'package:uchat/features/chat_room/presentation/widgets/dialogs/room_changes_dialog.dart';
import 'package:uchat/features/chat_room/presentation/widgets/dialogs/room_update_events_dialog.dart';
import 'package:uchat/features/chat_room/utils/typing_handler.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/check_if_requesting_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/check_if_requesting_friend_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/decline_friend_use_case.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_controller.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/room_messages/enum/input_mode_state.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';
import 'package:webcrypto/webcrypto.dart';

typedef MessageSelectionCallback = void Function(MessageCollection);

class ChatRoomIds {
  ChatRoomIds._();

  static const String callButtonRow = 'callButtonRow';
  static const String goBackToReplyButton = 'goBackToReplyButton';
  static const String replyingOrEditingBox = 'replyingOrEditingBox';
}

class ChatRoomController extends GetxController {
  final _log = useLogger();

  final String tag;
  final MessageLocalRepository messageLocalRepository;

  /// Tag used in GetX controller's tag. Its value is roomId.
  ChatRoomController({
    required this.tag,
    required this.messageLocalRepository,
  }) {
    roomId = tag;
  }

  late String roomId;

  ///use case for block and add friend btn
  // final BlockContactUseCase blockContactUseCase;

  final unreadCount = 0.obs;

  final room = Rxn<RoomCollection>();
  final roomCryptoKey = Rxn<AesGcmSecretKey>();

  // Track room changes history (max 5 entries)
  final List<Map<String, dynamic>> roomChangeHistory = [];
  static const int maxHistorySize = 20;

  // Track room update events history for debugging
  final List<Map<String, dynamic>> roomUpdateEventHistory = [];
  static const int maxUpdateEventHistorySize = 20;

  // final RoomSubscriptionCollection? roomSub ;
  final roomSub = Rxn<RoomSubscriptionCollection>();

  final isRoomLoading = true.obs;

  final roomTheme = 1.obs;
  final showOnlyAddBtn = true.obs;
  final contact = Rxn<ContactCollection>();
  final requestList = <ContactCollection>[].obs;

  /// `selectedMessages` state
  /// Null is disable/cancel selection,
  /// Empty/NotEmpty selection message is active.
  final selectedMessages = Rx<List<MessageCollection>?>(null);
  final selectMessageType = Rx<SelectType?>(null);
  final repliedMessage = Rx<MessageCollection?>(null);
  final callStatus = Rxn<CallStatusType>();

  //! Check always null, if deprecated remove!
  final callType = Rxn<CallType>();

  /// List of room members in the room.
  ///
  /// This list is used to display the room members in the room detail.
  ///
  /// The list is fetched from the local database.
  final members = <RoomMemberCollection>[].obs;

  /// Last read message timestamp of the current user.
  final myLastReadAt = 0.obs;

  /// Last read message timestamp of the members in the room.
  ///
  /// The key is the accountId of the member.
  ///
  /// The value is the last read message timestamp of the member.
  ///
  /// This map is not include the current user and user who never read the message.
  ///
  /// This map should sort by the value in descending order.
  final memberLastReadAtMap = <String, int>{}.obs;

  /// Date time that each member has joined the group
  final memberJoinedMap = <String, DateTime?>{}.obs;

  /// Last read message timestamp of the room.
  ///
  /// This value is the last read message timestamp of the room.
  final roomLastReadAt = 0.obs;

  bool isCallButtonRowOpen = false;

  bool? showGoBackToReplyButton;

  final currentUserMemberData = Rx<RoomMemberEntity?>(null);

  /// List of pinned messages in the room.
  ///
  /// This contains all pinned messages in the current room with pagination support.
  final pinMessages = Rx<PaginationPayload<PinMessageEntity>?>(null);

  /// Used to say whether this person has sent us a friend request or not.
  final isFriendRequesting = false.obs;

  /// Use to show OA panel in direct chat with OA
  final isOfficialAccount = false.obs;
  final isShowOAActionBarMode = false.obs;
  final isLoadingOARichMenu = false.obs;
  final isShowOARichMenu = false.obs;
  final isShowHamburgerMenu = false.obs;
  final oaRichMenu = Rxn<RichMenuModel>();

  bool get isOaRichMenuAvailable {
    if (isOfficialAccount.value != true) return false;
    if (oaRichMenu.value?.hasPublishedMenu != true) return false;
    return true;
  }

  /// Get the last read message timestamp of the other members in the room.
  ///
  /// This value is the last read message timestamp of the other members in the room.
  /// - If the room has no other members, it will return 0.
  /// - If the room has other members, it will return the last read message timestamp of the first other member in the room.
  int get otherLastReadAt {
    if (room.value?.hasFirstOtherInRoom == false) {
      return 0;
    }

    final firsOtherInRoomAccountId = room.value?.firstOtherInRoom?.accountId;
    if (firsOtherInRoomAccountId == null) {
      return 0;
    }

    return memberLastReadAtMap[firsOtherInRoomAccountId] ?? 0;
  }

  UserEntity? get currentUser {
    return UserController.instance.currentUser();
  }

  int get allUnreadCount {
    return ChatListController.instance.allUnreadCount - unreadCount.value;
  }

  /// Get the [MessageListController] with the tag 'chat-room-$tag'.
  ///
  /// This is used to access the [MessageListController] from the [Get] instance.
  MessageListController get messageListCtl {
    final chatRoomTag = 'chat-room-$tag';

    if (!Get.isRegistered<MessageListController>(tag: chatRoomTag)) {
      return Get.put<MessageListController>(
        MessageListController(tag: chatRoomTag),
        tag: chatRoomTag,
      );
    }

    return Get.find<MessageListController>(tag: chatRoomTag);
  }

  ChatRoomInputController get chatRoomInputCtl {
    return Get.find<ChatRoomInputController>(tag: 'chat-room-$tag');
  }

  UChatCallController get callCtl {
    return Get.find<UChatCallController>();
  }

  bool get isGroup => roomType == RoomType.group;

  List<CallStatusType> get isGroupCalling {
    if (isGroup) {
      return [CallStatusType.created, CallStatusType.inProgress];
    }
    return [CallStatusType.inProgress];
  }

  bool get isCallConnect {
    return callCtl.roomIsCalling(roomId);
  }

  ContactsController get contactCtl {
    return Get.find<ContactsController>();
  }

  bool get roomNotAvailable {
    return (room.value?.originalFirstOtherInRoom?.account?.isDeleted == true) ||
        (room.value?.originalFirstOtherInRoom == null && room.value?.isDirect == true);
  }

  bool get isDirectCallAvailable {
    return (contact()?.isBlocked != true) && !showNotFriend && !roomNotAvailable;
  }

  bool get isGroupCallAvailable {
    // TODO: Check req
    return true;
  }

  /// returns the correct capability for the room
  final roomCapability = Rx<RoomCapabilityEntity>(RoomCapabilityEntity.direct);

  StreamSubscription? _userTypingSubscription;
  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _updateRoomMemberSubscription;
  StreamSubscription? _addRoomMemberSubscription;
  StreamSubscription? _removeRoomMemberSubscription;
  StreamSubscription? _updateRoomInfoSubscription;
  StreamSubscription? _roomDeleteSubscription;
  StreamSubscription? _roomThemeUpdatedSubscription;
  StreamSubscription? _contactUpdateSubscription;
  StreamSubscription? _groupPermissionSubscription;
  StreamSubscription? _addAdminSub;
  StreamSubscription? _removeAdminSub;
  StreamSubscription? _updateAdminSub;
  StreamSubscription? _ownershipTransferredSubscription;
  StreamSubscription? _pinMessagesSubscription;
  StreamSubscription? _connectivityChangedSubscription;
  StreamSubscription? _richMenuUpdateSubscription;

  @override
  void onInit() async {
    // Load the room subscription from the DB (with account filtering)
    loadRoomThemeFromDb();

    // Save date time that user has joined the group
    ever(members, (list) async {
      for (final member in list) {
        final accountId = member.accountId;
        if (accountId != null) {
          memberJoinedMap[accountId] = member.joinedAt;
        }
      }
    });

    trackRoomUpdate();

    if (Get.arguments is ChatRoomArguments) {
      final args = Get.arguments as ChatRoomArguments;
      room.value = args.room;
      initRoomData();
    } else {
      initRoomData(hasRoom: false);
    }

    _userTypingSubscription = eventBus.on<UserInRoomTypingEvent>().listen(userInRoomTyping);
    _roomUpdateSubscription = eventBus.on<RoomUpdateSubscriptionEvent>().listen(onRoomUpdateSubscriptionEvent);
    _updateRoomInfoSubscription = eventBus.on<RoomUpdateEvent>().listen(onUpdateRoomInfo);
    _updateRoomMemberSubscription = eventBus.on<UpdateRoomMemberEvent>().listen(onUpdateRoomMember);
    _addRoomMemberSubscription = eventBus.on<AddRoomMemberEvent>().listen(onAddRoomMember);
    _removeRoomMemberSubscription = eventBus.on<RemoveRoomMemberEvent>().listen(onRemoveRoomMember);
    _roomDeleteSubscription = eventBus.on<RoomDeleteEvent>().listen(onRoomDeleted);
    _roomThemeUpdatedSubscription = eventBus.on<RoomThemeUpdatedEvent>().listen(onRoomThemeUpdated);
    _connectivityChangedSubscription = eventBus.on<ConnectivityChangedEvent>().listen(onConnectivityChanged);
    if (room()?.isDirect == true) {
      _contactUpdateSubscription = eventBus.on<ContactUpdateEvent>().listen((event) {
        if (event.contact.id == contact()?.id) {
          contact.update((data) {
            data?.update(event.contact);
          });
        }
      });
    }
    _addAdminSub = eventBus.on<AssignAdminEvent>().listen((event) {
      onUpdateCurrentRoomAdmin(event.roomId, event.member);
    });
    _removeAdminSub = eventBus.on<RevokeAdminEvent>().listen((event) {
      onUpdateCurrentRoomAdmin(event.roomId, event.member);
    });
    _updateAdminSub = eventBus.on<UpdateAdminPermissionEvent>().listen((event) {
      onUpdateCurrentRoomAdmin(event.roomId, event.member);
    });
    _ownershipTransferredSubscription = eventBus.on<OwnershipTransferredEvent>().listen((_) async {
      final currentUserId = currentUser?.id;
      if (currentUserId == null) return;
      currentUserMemberData.forceUpdate(await GetIt.I<GetOneMemberUseCase>().call(GetOneMemberParams(
        roomId: roomId,
        accountId: currentUserId,
      )));
      final memberData = currentUserMemberData.value;
      if (memberData == null) return;
      updateRoomCapability(memberData);
    });

    // Load initial pinned messages
    getPinMessagesInRoom();

    // Subscribe to pin messages changes
    _startWatchingPinMessages();

    taxonomyChatOpened();
    super.onInit();
  }

  void _checkTyping() {
    final typingList = ChatListController.instance.typingModelList;
    final typingModel = typingList.firstWhereOrNull((element) => element.roomId == roomId);
    final accountId = typingModel?.accountId;
    if (typingModel != null && accountId != null) {
      // map to UserInRoomTypingEvent and call userInRoomTyping
      userInRoomTyping(
        UserInRoomTypingEvent(
          accountId: accountId,
          roomId: roomId,
          lastTypedAt: typingModel.lastTypeAt,
          isTyping: true,
        ),
      );
    }
  }

  void taxonomyChatOpened() {
    final otherRoomMember = room.value?.firstOtherInRoom;
    String chatType = 'friends';
    if (otherRoomMember != null && otherRoomMember.account != null && otherRoomMember.account?.isOfficial == true) {
      chatType = 'official account';
    } else if (room.value?.isSystem == true) {
      chatType = 'system';
    } else if (room.value?.isDirect != true) {
      chatType = 'groups';
    }

    String entryPoint = 'profile page';
    String previousRoute = Get.previousRoute;

    // addContract
    // notificationCenter
    // contract
    // media
    // recentSearch
    // search
    // createGroup
    if (previousRoute.contains('search')) {
      entryPoint = 'search result';
    } else {
      if (Get.arguments is ChatRoomArguments) {
        final args = Get.arguments as ChatRoomArguments;
        previousRoute = args.fromPage;
        if (previousRoute == 'chatList' || previousRoute == 'createGroup') {
          entryPoint = 'chat list';
        }
        if (previousRoute == 'media') {
          entryPoint = 'media';
        }
      }
    }

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.chatOpened,
      eventProperties: EventProperty.chatOpened(chatType, entryPoint),
    );
  }

  void trackRoomUpdate() {
    // Track room changes with source tracking
    ever(room, (RoomCollection? roomData) {
      if (roomData != null) {
        // Get detailed caller information from stack trace
        final stackTrace = StackTrace.current;
        final frames = stackTrace.toString().split('\n');

        List<String> callerSources = [];
        String primaryCaller = 'unknown';
        String triggerContext = '';
        const int maxCallStack = 15;

        // Parse stack frames with more detail
        for (int i = 0; i < frames.length && callerSources.length < maxCallStack; i++) {
          final frame = frames[i].trim();
          if (frame.isEmpty) continue;

          // Enhanced pattern matching for different frame formats
          final patterns = [
            RegExp(r'#\d+\s+(\S+\.\S+)\s*\(.*\)'), // Standard format: Class.method()
            RegExp(r'#\d+\s+(\S+)\s*\(.*\)'), // Simple format: method()
            RegExp(r'#\d+\s+(.+?)\s+\('), // General format
          ];

          String fullMethod = '';
          for (final pattern in patterns) {
            final match = pattern.firstMatch(frame);
            if (match != null) {
              fullMethod = match.group(1) ?? '';
              break;
            }
          }

          if (fullMethod.isNotEmpty) {
            String className = '';
            String methodName = '';

            // Parse class and method names
            if (fullMethod.contains('.')) {
              final parts = fullMethod.split('.');
              className = parts.first;
              methodName = parts.last;
            } else {
              methodName = fullMethod;
            }

            // Determine if this is a relevant frame
            bool isRelevant = false;
            String contextualName = methodName;

            // ChatRoomController methods
            if (className.contains('ChatRoomController')) {
              isRelevant = true;
              if (methodName == 'onInit') {
                contextualName = 'init_controller';
                triggerContext = 'Controller initialization';
              } else if (methodName == 'getRoomToState') {
                contextualName = 'load_room_data';
                triggerContext = 'Loading room from database';
              } else if (methodName == 'onUpdateRoomInfo') {
                contextualName = 'room_update_event';
                triggerContext = 'Room info updated via event';
              } else if (methodName.startsWith('onRoom')) {
                contextualName = '${methodName}_handler';
                triggerContext = 'Room event handler: $methodName';
              } else if (methodName == 'initRoomData') {
                contextualName = 'init_room_data';
                triggerContext = 'Initializing room data';
              }
            }
            // Event handlers
            else if (className.contains('Event') || methodName.contains('Event')) {
              isRelevant = true;
              contextualName = 'event_${methodName.toLowerCase()}';
              triggerContext = 'Event system: $className.$methodName';
            }
            // Use case classes
            else if (className.contains('UseCase') || fullMethod.contains('UseCase')) {
              isRelevant = true;
              contextualName = 'usecase_${className.toLowerCase()}';
              triggerContext = 'Use case execution: $className';
            }
            // Widget/UI related
            else if (className.contains('Widget') || className.contains('Screen')) {
              isRelevant = true;
              contextualName = 'ui_${methodName.toLowerCase()}';
              triggerContext = 'UI interaction: $className.$methodName';
            }
            // Other application methods (not internal Flutter/Dart)
            else if (!frame.contains('dart:') &&
                !frame.contains('package:flutter/') &&
                !frame.contains('package:get/src/') &&
                !methodName.startsWith('_') &&
                !methodName.contains('Worker') &&
                !methodName.contains('ever') &&
                className.isNotEmpty) {
              isRelevant = true;
              contextualName = '${className.toLowerCase()}_$methodName';
              triggerContext = 'External call: $className.$methodName';
            }

            if (isRelevant) {
              callerSources.add(contextualName);

              // Set primary caller (first relevant one found)
              if (primaryCaller == 'unknown') {
                primaryCaller = contextualName;
              }
            }
          }
        }

        // Enhanced fallback detection
        if (callerSources.isEmpty) {
          // Try to infer from current state or context
          if (room.value?.id != null) {
            callerSources.add('room_state_change');
            primaryCaller = 'room_state_change';
            triggerContext = 'Room state changed but source undetected';
          } else {
            callerSources.add('unknown_trigger');
            primaryCaller = 'unknown_trigger';
            triggerContext = 'Unable to detect change source';
          }
        }

        // Create current room data snapshot
        final currentSnapshot = roomData.toMap();

        // Get previous snapshot for comparison
        Map<String, dynamic>? previousSnapshot;
        if (roomChangeHistory.isNotEmpty) {
          final lastEntry = roomChangeHistory.last;
          previousSnapshot = lastEntry;
        }

        // Calculate changes (diff)
        Map<String, dynamic> changes = {};
        if (previousSnapshot != null) {
          currentSnapshot.forEach((key, value) {
            if (previousSnapshot![key] != value) {
              changes[key] = {
                'from': previousSnapshot[key],
                'to': value,
              };
            }
          });
        } else {
          // First time, record all as new
          changes = currentSnapshot.map((key, value) => MapEntry(key, {'from': null, 'to': value}));
        }

        // Only record if there are actual changes
        if (changes.isNotEmpty) {
          roomChangeHistory.add({
            'timestamp': DateTime.now().toIso8601String(),
            'source': primaryCaller,
            'context': triggerContext,
            'callStack': callerSources,
            'changes': changes,
            // Keep current snapshot for next comparison
            ...currentSnapshot,
          });

          // Keep only the last 5 changes
          if (roomChangeHistory.length > maxHistorySize) {
            roomChangeHistory.removeAt(0);
          }

          final changedFields = changes.keys.join(', ');
          _log.d(
              'Room changed from $primaryCaller ($triggerContext) - Stack: ${callerSources.join(" -> ")} - Fields: $changedFields - History size: ${roomChangeHistory.length}');
        } else {
          _log.d('Room update from $primaryCaller ($triggerContext) but no actual changes detected');
        }
      }
    });
  }

  @override
  onClose() {
    _userTypingSubscription?.cancel();
    _roomUpdateSubscription?.cancel();
    _updateRoomMemberSubscription?.cancel();
    _addRoomMemberSubscription?.cancel();
    _removeRoomMemberSubscription?.cancel();
    _updateRoomInfoSubscription?.cancel();
    _roomDeleteSubscription?.cancel();
    _roomThemeUpdatedSubscription?.cancel();
    _contactUpdateSubscription?.cancel();
    _groupPermissionSubscription?.cancel();
    _addAdminSub?.cancel();
    _removeAdminSub?.cancel();
    _updateAdminSub?.cancel();
    _ownershipTransferredSubscription?.cancel();
    _pinMessagesSubscription?.cancel();
    _connectivityChangedSubscription?.cancel();
    _richMenuUpdateSubscription?.cancel();
    unSubscribeToOARichMenuUpdates();
    super.onClose();
  }

  /// Get the room type.
  RoomType get roomType {
    return room.value?.roomType ?? RoomType.direct;
  }

  bool get isDirectRoom {
    return room.value?.isDirect == true;
  }

  bool get isSystemRoom {
    return room.value?.isSystem == true;
  }

  bool get isFriend {
    return contact()?.isFriend == true;
  }

  bool get isBlocked {
    return contact()?.isBlocked == true;
  }

  String get appBarTitle {
    return room.value?.title ?? '';
  }

  bool get showNotFriend {
    if (!isDirectRoom || isFriend || (isBlocked)) {
      return false;
    }

    return (!isFriend && room.value?.firstOtherInRoom != null && isDirectRoom);
  }

  bool get isAbleToDeleteOtherMessages => currentUserMemberData.value?.ableDeleteOtherMessages == true;

  bool get isAbleToPinMessages => currentUserMemberData.value?.ablePinMessages == true;

  void onBodyTap() {
    Get.find<ChatRoomInputController>(tag: 'chat-room-$tag').onBodyTap();
    onCloseCallButtonRow();
  }

  void onAppBarCallButtonTap() {
    isCallButtonRowOpen = !isCallButtonRowOpen;
    update([ChatRoomIds.callButtonRow]);
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCallIcon);
  }

  void onCloseCallButtonRow() {
    isCallButtonRowOpen = false;
    update([ChatRoomIds.callButtonRow]);
  }

  /// Initialize the room data.
  ///
  /// If [hasRoom] is `false`, it will get the room data from the local database. And then it will get the room subscription data from the local database.
  ///
  /// This method will set [isRoomLoading] to `true` before fetching the room data and set it to `false` after the room data is fetched.
  Future<void> initRoomData({bool hasRoom = true}) async {
    try {
      if (!hasRoom) {
        await getRoomToState();
      } else {
        roomCryptoKey.value = await room.value?.getRoomCryptoKeyObj();
        callStatus.value = room.value?.callStatus;
        callType.value = CallType.fromString(room.value?.callType);
      }

      await Future.wait([
        getRoomMemberToState(),
        getRoomSubscriptionToState(),
        getRoomContact(),
        updateDraftMessage(),
      ]);

      // wait for members to load before calculate last read at and init room capability, because those features depend on members data
      if (members.isNotEmpty) {
        calculateMemberLastReadAt();
        initCurrentMemberEntity();
        // Check typing status upon initialization
        _checkTyping();
      }

      initRoomCapability();

      setDraftReplyMessage();
    } catch (e, st) {
      // log error
      _log.e('Error initializing room data:', e, st);
    } finally {
      isRoomLoading.value = false;
    }
  }

  void setDraftReplyMessage() {
    if (room.value?.draftReplyMessage case final draftReply?) {
      repliedMessage(draftReply.toCollection());
    }
  }

  void setRepliedMessage(MessageCollection? messageCollection) {
    repliedMessage.value = messageCollection;
    saveDraftMessage(chatRoomInputCtl.textFieldController?.text ?? '');
    if (messageCollection != null) {
      chatRoomInputCtl.setReplyingMessage(messageCollection.toEntity());
    } else {
      chatRoomInputCtl.clearReplyingMessage(callChatRoomCtl: false);
    }

    if (repliedMessage.value != null) {
      chatRoomInputCtl.onKeyboardTap();
    }
  }

  Future<void> saveDraftMessage(String value) async {
    // Debounce to fix some duplicate function calls when deleting message in text field too fast.
    EasyDebounce.debounce('updateDraftMessage', const Duration(milliseconds: 100), () async {
      await GetIt.I<SaveDraftMessageUseCase>().call(
        SaveDraftMessageEntity(
          roomId: roomId,
          message: value,
          replyMessageId: repliedMessage.value?.id,
        ),
      );

      // Update room draft message updating
      updateDraftMessage();
    });
  }

  Future<void> updateDraftMessage() async {
    final roomEntity = await GetIt.I<UpdateDraftMessageUseCase>().call(NoParams());

    if (roomEntity?.id != roomId) {
      return;
    }

    final roomUpdated = roomEntity?.toCollection();

    if (roomUpdated == null) {
      return;
    }

    room.value?.update(roomUpdated);
  }

  Future<void> loadRoomThemeFromDb() async {
    final currentAccountId = UserController.instance.currentUser.value?.id;
    if (currentAccountId == null) {
      _log.e('Current account ID is null. Cannot proceed with theme change.');
      return;
    }
    final roomSub = await GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionByRoomAndAccount(roomId, currentAccountId);
    if (roomSub != null && roomSub.theme != null) {
      roomTheme.value = roomSub.theme!;
    }
  }

  Future<void> getRoomContact() async {
    if (isDirectRoom || isSystemRoom) {
      final otherInRoomAccountId = room.value?.firstOtherInRoom?.accountId;
      if (otherInRoomAccountId != null) {
        final entity = await GetIt.I<ContactLocalRepository>().getContact(otherInRoomAccountId);
        contact.value = entity?.toCollection();

        await checkFriendRequesting(contact()?.id ?? '');
      }
    }
  }

  Future<void> checkFriendRequesting(String friendId) async {
    bool isRequesting = false;

    try {
      final res = await GetIt.I<CheckIfRequestingFriendUseCase>().call(CheckIfRequestingFriendRequest(
        friendAccountId: friendId,
      ));

      isRequesting = res?.isRequesting == true;
    } catch (e, stackTrace) {
      _log.w('checkFriendRequesting error', e, stackTrace);
    } finally {
      isFriendRequesting.value = isRequesting;
    }
  }

  /// Get the room data from the local database and set it to the [room] variable.
  ///
  /// If the room data is fetched successfully, it will set the [appBarTitle] to the room title and [appBarAvatarUrl] to the room photoId.
  Future<void> getRoomToState() async {
    final roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
    final roomData = roomEntity?.toCollection();
    if (roomData != null) {
      room.value = roomData;
      roomCryptoKey.value = await room.value?.getRoomCryptoKeyObj();
      callStatus.value = roomData.callStatus;
      callType.value = CallType.fromString(roomData.callType);
    }
  }

  void initRoomCapability() {
    if (room.value?.isGroup == true) {
      _groupPermissionSubscription?.cancel();
      _groupPermissionSubscription =
          GetIt.I<WatchGroupPermissionUseCase>().call(WatchGroupPermissionParams(roomId: roomId)).listen((value) {
        if (currentUserMemberData.value?.isAdminOrAbove == true) {
          roomCapability.value = RoomCapabilityEntity.groupOwner;
        } else {
          roomCapability.value = RoomCapabilityEntity.fromGroupPermission(value);
        }

        roomCapability.refresh();
      });
    } else {
      final isOfficialAccount = contact()?.isOfficial == true;
      if (isOfficialAccount) {
        _officialAccountCapabilitySetup();
      } else {
        roomCapability.value = RoomCapabilityEntity.direct;
      }
    }
  }

  /// Setup the official account capability.
  /// This method will set the [roomCapability] to [RoomCapabilityEntity.official] and listen to the rich menu update event.
  /// It will also fetch the latest rich menu from the server and set it to the [oaRichMenu] variable.
  /// If the rich menu is available, it will set the [isShowOARichMenu] to `true` and set the OA action bar mode to `true`.
  Future<void> _officialAccountCapabilitySetup() async {
    final officialAccountId = contact()?.id;
    if (officialAccountId == null) return;

    OfficialAccountService.instance.subscribe(officialAccountId);
    roomCapability.value = RoomCapabilityEntity.official;
    isOfficialAccount(true);
    oaRichMenu.value = contact()?.richMenu;
    // Listen to rich menu changes
    _richMenuUpdateSubscription = eventBus.on<RichMenuUpdateEvent>().listen(onUpdateRichMenu);
    checkAndSetOaRichMenu();

    // Fetch the latest rich menu from server
    final richMenu = await GetIt.I<GetOaRichMenuUseCase>().call(OaRichMenuParams(
      officialAccountId: officialAccountId,
    ));
    oaRichMenu.value = richMenu;
    checkAndSetOaRichMenu();
  }

  void checkAndSetOaRichMenu() {
    if (isOaRichMenuAvailable) {
      isShowOARichMenu(true);
      setOAActionBarMode(true);
      isShowHamburgerMenu(true);
    } else {
      setOAActionBarMode(false);
      isShowHamburgerMenu(false);
    }
  }

  /// Set the OA action bar mode.
  ///
  /// If [value] is `true`, it will show the OA action bar mode.
  /// If [value] is `false`, it will hide the OA action bar mode and focus back to the input field.
  /// Also, it will clear the replying message and set the replied message to `null`.
  void setOAActionBarMode(bool value) {
    isShowOAActionBarMode.value = value;
    if (value == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onBodyTap();
        chatRoomInputCtl.clearReplyingMessage();
        setRepliedMessage(null);
      });
    } else if (value == false) {
      // focus back to input field
      chatRoomInputCtl.onKeyboardTap();
    }
  }

  void setShowOARichMenu(bool value) {
    isShowOARichMenu(value);
  }

  /// Handle the rich menu update event.
  ///
  /// If the rich menu is updated for the current official account, it will update the [oaRichMenu] variable and save it to the local database.
  void onUpdateRichMenu(RichMenuUpdateEvent richMenuEvent) {
    if (richMenuEvent.accountId != contact()?.id) return;
    oaRichMenu.value = richMenuEvent.richMenu;
    GetIt.I<ContactLocalRepository>().putContactRichMenu(richMenuEvent.accountId, richMenuEvent.richMenu);
    if (isOaRichMenuAvailable) {
      isShowOARichMenu(true);
      isShowHamburgerMenu(true);
    } else {
      isShowOARichMenu(false);
      isShowOAActionBarMode(false);
      isShowHamburgerMenu(false);
    }
  }

  /// Unsubscribe from the official account rich menu updates.
  void unSubscribeToOARichMenuUpdates() {
    if (!isOfficialAccount.value) return;

    final officialAccountId = contact()?.id;
    if (officialAccountId == null) return;

    OfficialAccountService.instance.unsubscribe(officialAccountId);
  }

  /// Get the room subscription data from the local database and set it to the [roomSub] variable.
  ///
  /// If the room subscription data is fetched successfully, it will set the [unreadCount] to the room subscription's unread count.
  Future<void> getRoomSubscriptionToState() async {
    final roomSubData = await GetIt.I<GetRoomSubscriptionUseCase>().call(ChatRoomParams(roomId: roomId));
    if (roomSubData != null) {
      roomSub.value = RoomSubscriptionCollection.fromEntity(roomSubData);
      unreadCount.value = roomSub()?.unreadCount ?? 0;
    }
  }

  /// Get the room members data from the local database and set it to the [members] variable.
  ///
  /// This method will get all the members in the room from the local database.
  Future<void> getRoomMemberToState() async {
    try {
      final memberCountInRoom = room.value?.memberCount ?? 1;

      /// No need to fetch members again if:
      /// - Direct room with 2 members (me and other)
      /// - Group room with all members already fetched

      if (room.value?.isDirect == true && members.length == 2) {
        return;
      }

      if (room.value?.isGroup == true && members.length == memberCountInRoom) {
        return;
      }

      List<RoomMemberEntity> tempMembers = await GetIt.I<GetAllMemberInRoomUseCase>().call(
        ChatRoomParams(roomId: roomId),
      );

      /// Fetch from server if local db members count is not equal to member count in room
      /// or no members found in local db
      if (tempMembers.length != memberCountInRoom || tempMembers.isEmpty) {
        try {
          final roomMemberUseCase = await GetIt.I<FetchRoomMemberUseCase>().call(
            FetchRoomMemberParams(roomId: roomId, useTransaction: true, saveToDb: true),
          );
          tempMembers = roomMemberUseCase.$1;
        } catch (e, stackTrace) {
          _log.e('Error fetching room members for roomId $roomId:', e, stackTrace);
        }
      }

      members.assignAll(tempMembers.map(RoomMemberCollection.fromEntity).toList());
    } catch (e, stackTrace) {
      _log.e('Error fetching room members for roomId $roomId:', e, stackTrace);
    }
  }

  /// Calculate the last read message timestamp of the members in the room.
  ///
  /// This method will calculate the last read message timestamp of the members in the room.
  ///
  void calculateMemberLastReadAt() {
    calculateMemberLastReadAtHelper(
      members: members,
      myLastReadAt: myLastReadAt,
      memberLastReadAtMap: memberLastReadAtMap,
      roomLastReadAt: roomLastReadAt,
      log: _log,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageListCtl.messages.refresh();
    });
  }

  void initCurrentMemberEntity() {
    final currentUser = UserController.instance.currentUser.value;
    final index = members.indexWhere((e) => e.accountId == currentUser?.id);

    if (index != -1) {
      currentUserMemberData.forceUpdate(members[index].toEntity());
    }
  }

  void onUpdateCurrentRoomAdmin(String eventRoomId, RoomMemberCollection eventMember) async {
    if (eventRoomId != roomId) return;

    final memberCollection = eventMember;
    final index = members.indexWhere((member) => member.accountId == memberCollection.accountId);

    if (index != -1) {
      members[index] = memberCollection;
      members.refresh();

      final currentUser = UserController.instance.currentUser.value;
      if (currentUser?.id == eventMember.accountId) {
        currentUserMemberData.forceUpdate(eventMember.toEntity());
        final memberData = currentUserMemberData.value;
        if (memberData == null) return;
        updateRoomCapability(memberData);
      }
    }
  }

  void updateRoomCapability(RoomMemberEntity memberData) async {
    if (memberData.isAdminOrAbove == true) {
      roomCapability.value = RoomCapabilityEntity.groupOwner;
    } else {
      final permission = await GetIt.I<GetGroupPermissionUseCase>().call(GetGroupPermissionParams(roomId: roomId));
      roomCapability.value = RoomCapabilityEntity.fromGroupPermission(permission);
    }
  }

  /// Update the last read message timestamp of the current user.
  ///
  /// This method will update the last read message timestamp of the current user to the [myLastReadAt] variable.
  Future<void> updateMyLastReadAt(DateTime seenMessageAt) async {
    myLastReadAt.value = seenMessageAt.millisecondsSinceEpoch;
    final meInMember = members.firstWhereOrNull((e) => e.isMe);
    if (meInMember != null) {
      final newMemberData = RoomMemberCollection(
        account: meInMember.account,
        roomId: meInMember.roomId,
        lastSeenMessageAt: seenMessageAt,
      );
      await GetIt.I<UpdateMemberInRoomUseCase>().call(UpdateMemberInRoomParams(member: newMemberData));
    }
  }

  /// Trigger the read message event.
  ///
  /// This method will trigger the read message event to the server.
  ///
  /// If the [messageCreatedAt] is not null, it will set the seen message timestamp to the [messageCreatedAt].
  /// Otherwise, it will set the seen message timestamp to the current time.
  Future<void> triggerReadMessage(DateTime? messageCreatedAt) async {
    if ((messageCreatedAt?.millisecondsSinceEpoch ?? 0) < myLastReadAt.value) {
      // If message created time is older than my last read time, do nothing
      // because user already read it.

      // This condition also check in use case
      return;
    }

    GetIt.I<SendReadMessageUseCase>().call(SendReadMessageParams(
      roomId: roomId,
      lastReadAt: myLastReadAt.value,
      seenMessageAt: messageCreatedAt,
      unreadCount: unreadCount.value,
      onCompleted: (seenMessageAt) async {
        await updateMyLastReadAt(seenMessageAt);
        calculateMemberLastReadAt();
      },
    ));
  }

  Future<void> onRoomUpdateSubscriptionEvent(RoomUpdateSubscriptionEvent event) async {
    if (roomId == event.roomSubscription.roomId) {
      _log.d('RoomUpdateSubscription: ${event.roomSubscription.roomId}: ${event.roomSubscription.unreadCount}');
      if (roomSub.value != null) {
        roomSub.value?.update(event.roomSubscription.toCollection());
      } else {
        roomSub.value = event.roomSubscription.toCollection();
      }

      roomSub.refresh();
      room.refresh();

      unreadCount.value = roomSub.value?.unreadCount ?? 0;
      calculateMemberLastReadAt();
    }
  }

  Future<void> onUpdateRoomInfo(RoomUpdateEvent event) async {
    _log.d('onUpdateRoomInfo: ${event.room.id} == $roomId -> ${event.room.latestLastSeenAt}');

    // Track room update event for debugging
    roomUpdateEventHistory.add({
      'timestamp': DateTime.now().toIso8601String(),
      'eventRoomId': event.room.id,
      'currentRoomId': roomId,
      'matched': roomId == event.room.id,
      'room': event.room.toMap(),
      'callStatus': event.room.callStatus,
      'callType': event.room.callType,
      'latestLastSeenAt': event.room.latestLastSeenAt?.toIso8601String(),
    });

    // Keep only the last 20 events
    if (roomUpdateEventHistory.length > maxUpdateEventHistorySize) {
      roomUpdateEventHistory.removeAt(0);
    }

    if (roomId == event.room.id) {
      room.value?.update(event.room);
      room.refresh();
      callStatus.value = event.room.callStatus;
      callType.value = CallType.fromString(event.room.callType);

      calculateMemberLastReadAt();
    }
  }

  Future<void> onUpdateRoomMember(UpdateRoomMemberEvent event) async {
    _log.d('onUpdateRoomMember: ${event.roomId} == $roomId');
    if (roomId == event.roomId) {
      for (final member in event.members) {
        members.firstWhereOrNull((element) => element.accountId == member.accountId)?.update(member);
      }
      members.refresh();
      calculateMemberLastReadAt();
    }
  }

  Future<void> onAddRoomMember(AddRoomMemberEvent event) async {
    _log.d('onAddRoomMember: ${event.roomId} == $roomId');
    if (roomId == event.roomId) {
      members.addAll(event.member);
      calculateMemberLastReadAt();
    }
  }

  Future<void> onRoomDeleted(RoomDeleteEvent event) async {
    if (roomId == event.roomId) {
      Get.until((route) => route.settings.name == Routes.home);
    }
  }

  void onRoomThemeUpdated(RoomThemeUpdatedEvent event) {
    roomTheme.value = int.tryParse(event.theme) ?? 1;
  }

  Future<void> onRemoveRoomMember(RemoveRoomMemberEvent event) async {
    _log.d('onRemoveRoomMember: ${event.roomId} == $roomId');
    if (roomId == event.roomId) {
      for (final accountId in event.memberIds) {
        members.removeWhere((element) => element.accountId == accountId);
      }
      room()?.originalFirstOtherInRoom = null;
      room.refresh();
      calculateMemberLastReadAt();
    }
  }

  /// Handle the [UserInRoomTypingEvent] event.
  ///
  /// This method will update the typing member in the message list.
  ///
  /// If the [UserInRoomTypingEvent] event's roomId is the same as the current room's roomId, it will update the typing member in the message list.
  Future<void> userInRoomTyping(UserInRoomTypingEvent event) async {
    await handleUserInRoomTyping(
      event: event,
      currentRoomId: roomId,
      currentUserId: currentUser?.id,
      members: members,
      messageListController: messageListCtl,
    );
  }

  Future<void> onCallStart(CallType callType) async {
    StartCallParam param;

    if (room.value?.isGroup == true) {
      param = StartCallParam(
        callData: RoomCallModel.generateStartGroupCall(
          room.value!,
          callType,
        ),
      );
    } else {
      param = StartCallParam(
        callData: RoomCallModel.generateDirectCall(
          room.value!,
          callType,
        ),
      );
    }
    GetIt.I<TaxonomyService>().sendEvent(
      callType == CallType.video ? EventName.clickVideoCall : EventName.clickVoiceCall,
      eventProperties: EventProperty.clickVoiceCall('chat room'),
    );
    onCloseCallButtonRow();
    await GetIt.I<StartCallUseCase>().call(param);
  }

  Future<void> onSendText({
    List<MessageLinkModel> links = const [],
    required String message,
    int loopCount = 1,
  }) async {
    if (message.trim().isEmpty) {
      return;
    }

    //NOTE. need this because UI will close replied message box immediately when replied message
    MessageModel? replyMessage;
    if (repliedMessage.value != null) {
      replyMessage = repliedMessage.value?.toModel();
      setRepliedMessage(null);
    }

    final isOnlyEmojis = message.emojis.only;

    String mediaText = 'text';

    if (links.isNotEmpty) {
      mediaText = 'link';
    }
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(EventProperty.getChatTypeForEventParams(room.value!), mediaText),
    );

    await GetIt.I<SendMessageToServerUseCase>().call(
      SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: roomType == RoomType.directSecret,
        isShare: false,
        message: MessageCollection(
          message: message,
          type: MessageType.text,
          meta: MessageMetaModel(
            isEmoji: isOnlyEmojis,
            isRegEx: isOnlyEmojis || checkMentionOrPhoneNumberOrEmailInText(message),
          ),
          links: links,
        ),
        roomCryptoKey: roomCryptoKey.value,
        accountId: currentUser!.id!,
        isSending: true,
        replyMessage: replyMessage,
        loopCount: loopCount,
      ),
    );
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

  // Send current room data to chat
  Future<void> sendRoomInfo({
    required void Function({List<MessageLinkModel> links, required String message}) onSendText,
  }) async {
    if (room.value == null) {
      return;
    }

    // Build room info as JSON string
    final roomInfo = {
      'id': room.value?.id,
      'name': room.value?.roomName,
      'originalName': room.value?.originalRoomName,
      'type': room.value?.roomType?.name,
      'isDirect': room.value?.isDirect,
      'isGroup': room.value?.isGroup,
      'isPrivateGroup': room.value?.isPrivateGroup,
      'isJoined': room.value?.isJoined,
      'isRequesting': room.value?.isRequesting,
      'memberCount': members.length,
      'members': members
          .map((m) => {
                'accountId': m.accountId,
                'displayName': m.account?.name,
                'username': m.account?.username,
                'role': m.groupRole?.role?.name,
                'joinedAt': m.joinedAt?.toIso8601String(),
                'lastSeenMessageAt': m.lastSeenMessageAt?.toIso8601String(),
              })
          .toList(),
      'ownerId': room.value?.ownerId,
      'photoId': room.value?.photoId,
      'createdAt': room.value?.createdAt?.toIso8601String(),
      'updatedAt': room.value?.updatedAt?.toIso8601String(),
      'deleted': room.value?.deleted,
      'accessType': room.value?.accessType?.name,
      'callStatus': room.value?.callStatus?.name,
      'callType': room.value?.callType,
      'isRoomEmpty': room.value?.isRoomEmpty,
      'meta': room.value?.meta?.toMap(),
    };

    // Convert to formatted JSON string
    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(roomInfo);

    // Send as message
    onSendText(message: '```json\n$jsonString\n```');
  }

  // Send room change history to chat
  Future<void> sendRoomChangeHistory({
    required void Function({List<MessageLinkModel> links, required String message}) onSendText,
  }) async {
    if (roomChangeHistory.isEmpty) {
      onSendText(message: 'No room changes recorded');
      return;
    }

    // Send each change as a separate message
    for (int i = 0; i < roomChangeHistory.length; i++) {
      final change = roomChangeHistory[i];
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert({
        'changeNumber': i + 1,
        'totalChanges': roomChangeHistory.length,
        ...change,
      });

      onSendText(message: '```json\n$jsonString\n```');

      // Delay between messages to avoid flooding
      if (i < roomChangeHistory.length - 1) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  // Show room change history in a dialog
  void showRoomChangeHistoryDialog() {
    Get.dialog(
      RoomChangesDialog(roomChangeHistory: roomChangeHistory),
      barrierDismissible: true,
    );
  }

  // Show room update event history in a dialog
  void showRoomUpdateEventHistoryDialog() {
    Get.dialog(
      RoomUpdateEventsDialog(roomUpdateEventHistory: roomUpdateEventHistory),
      barrierDismissible: true,
    );
  }

  void onEditText(EditMessageRequest request) async {
    try {
      final params = EditMessageParams(
        roomId: roomId,
        messageId: request.messageId,
        newContent: request.newMessage,
      );
      GetIt.I<TaxonomyService>().sendEvent(EventName.messageSent,
          eventProperties: EventProperty.messageSent(EventProperty.getChatTypeForEventParams(room.value!), 'text'));
      await GetIt.I<EditMessageUseCase>().call(params);
    } catch (e) {
      if (e is ApiException && e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  void onSendSticker(StickerSendingEntity sticker, {int loopCount = 1}) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(EventProperty.getChatTypeForEventParams(room.value!), 'sticker'),
    );
    if (Get.isRegistered<StickerController>()) {
      final stickerCtl = Get.find<StickerController>();
      final sendingSticker = stickerCtl.myStickerList.firstWhereOrNull((e) => e.id == sticker.stickerPackId);
      if (sendingSticker != null) {
        final name = sendingSticker.name;
        final owner = sendingSticker.publisher;
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.stickerSent,
          eventProperties: EventProperty.stickerSent(
            name,
            owner,
          ),
        );
      }
    }

    MessageModel? replyMessage;
    if (repliedMessage.value != null) {
      replyMessage = repliedMessage.value?.toModel();
      setRepliedMessage(null);
    }

    await GetIt.I<SendMessageToServerUseCase>().call(
      SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: roomType == RoomType.directSecret,
        isShare: false,
        message: MessageCollection(
          type: MessageType.sticker,
          meta: MessageMetaModel(
            stickerPack: sticker.stickerPackId,
            stickerValue: sticker.stickerId,
          ),
        ),
        roomCryptoKey: roomCryptoKey.value,
        accountId: currentUser!.id!,
        isSending: true,
        replyMessage: replyMessage,
        loopCount: loopCount,
      ),
    );
  }

  Future<void> onSendGif(GifSendingEntity gifData, {int loopCount = 1}) async {
    final mediaType = 'gif';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(EventProperty.getChatTypeForEventParams(room.value!), mediaType),
    );

    MessageModel? replyMessage;
    if (repliedMessage.value != null) {
      replyMessage = repliedMessage.value?.toModel();
      setRepliedMessage(null);
    }

    await GetIt.I<SendMessageToServerUseCase>().call(
      SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: roomType == RoomType.directSecret,
        isShare: false,
        message: MessageCollection(
          type: MessageType.gif,
          meta: MessageMetaModel(
            gifUrl: gifData.gifUrl,
            giphyId: gifData.giphyId,
            gifWebpUrl: gifData.webp,
            gifMp4Url: gifData.mp4,
            gifWidth: gifData.width,
            gifHeight: gifData.height,
          ),
        ),
        roomCryptoKey: roomCryptoKey.value,
        accountId: currentUser!.id!,
        isSending: true,
        replyMessage: replyMessage,
        loopCount: loopCount,
      ),
    );
  }

  Future<void> onSendAudioRecording(FileInfoModel audioFile) async {
    final mediaType = 'audio';
    GetIt.I<TaxonomyService>().sendEvent(EventName.messageSent,
        eventProperties: EventProperty.messageSent(EventProperty.getChatTypeForEventParams(room.value!), mediaType));
    await GetIt.I<SendFileMessageToServerUseCase>().call(
      SendFileMessageParams(
        chatRoomId: roomId,
        files: [audioFile],
        isSending: true,
        isLocked: false,
        isMyNote: false,
        enableUploadPro: UserController.instance.enableUploadPro,
      ),
    );
  }

  Future<void> onImageOrVideoSendCloseKeyboard() async {
    chatRoomInputCtl.inputModeState(InputModeState.close);
    chatRoomInputCtl.textFieldFocusNode.unfocus();
    chatRoomInputCtl.swipeKeyboardHeight(0);
    chatRoomInputCtl.prevInputModeState = chatRoomInputCtl.inputModeState.value;
  }

  Future<void> onEditImageComplete(Uint8List editedImage) async {
    Get.until((e) => e.settings.name?.contains('MediaViewer') != true);
    AppToast.showToast(
      context: Get.context!,
      message: 'Sending....'.tr,
      sbMargin: const EdgeInsets.only(bottom: 42),
    );
    await onImageOrVideoSendCloseKeyboard();
    final compressedFile = await FileService.instance.convertUint8ListToFile(
      editedImage,
      fileName: 'temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    final file = await FileInfoModel.fromFile(compressedFile, 0);
    AppToast.hideToast(Get.context!);
    await GetIt.I<SendFileMessageToServerUseCase>().call(
      SendFileMessageParams(
        chatRoomId: roomId,
        files: [file],
        isSending: true,
        isLocked: false,
        isMyNote: false,
        enableUploadPro: UserController.instance.enableUploadPro,
      ),
    );
  }

  Future<void> onImageAndVideoPicked(MediaGalleryResult medias, {int loopCount = 1}) async {
    if (medias.isEmpty) {
      return;
    }

    await onImageOrVideoSendCloseKeyboard();

    List<MediaAsset> supportedImages = [];
    List<MediaAsset> unSupportedImages = [];

    for (final image in medias.images) {
      final mime = await image.mimeType;
      if (mime != null && mime.isNotEmpty == true) {
        if (isImageTypeSupported(mime)) {
          supportedImages.add(image);
        } else {
          unSupportedImages.add(image);
        }
      } else {
        unSupportedImages.add(image);
      }
    }

    if (supportedImages.isNotEmpty) {
      final images = supportedImages.toFileInfoList();
      final groupImages = images.splitToGroup(UChatConstant.maxFilePerMessage);
      final mediaType = 'image';
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.messageSent,
        eventProperties: EventProperty.messageSent(
          EventProperty.getChatTypeForEventParams(room.value!),
          mediaType,
        ),
      );
      for (final group in groupImages) {
        await GetIt.I<SendFileMessageToServerUseCase>().call(
          SendFileMessageParams(
            chatRoomId: roomId,
            files: group,
            isSending: true,
            isLocked: false,
            isMyNote: false,
            enableUploadPro: UserController.instance.enableUploadPro,
            loopCount: loopCount,
          ),
        );
      }
    }

    if (medias.videos.isNotEmpty) {
      final videos = medias.videos.toFileInfoList();
      final mediaType = 'VDO';
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.messageSent,
        eventProperties: EventProperty.messageSent(
          EventProperty.getChatTypeForEventParams(room.value!),
          mediaType,
        ),
      );
      for (final video in videos) {
        await GetIt.I<SendFileMessageToServerUseCase>().call(
          SendFileMessageParams(
            chatRoomId: roomId,
            files: [video],
            isSending: true,
            isLocked: false,
            isMyNote: false,
            enableUploadPro: UserController.instance.enableUploadPro,
            loopCount: loopCount,
          ),
        );
      }
    }

    if (unSupportedImages.isNotEmpty) {
      final mediaType = 'file';
      final files = unSupportedImages.toFileInfoList(forceTypeFile: true);
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.messageSent,
        eventProperties: EventProperty.messageSent(
          EventProperty.getChatTypeForEventParams(room.value!),
          mediaType,
        ),
      );
      for (final file in files) {
        await GetIt.I<SendFileMessageToServerUseCase>().call(
          SendFileMessageParams(
            chatRoomId: roomId,
            files: [file],
            isSending: true,
            isLocked: false,
            isMyNote: false,
            enableUploadPro: UserController.instance.enableUploadPro,
            loopCount: loopCount,
          ),
        );
      }
    }

    AppToast.hideToast(Get.context!);
  }

  Future<void> onTakePicture(FileInfoModel file) async {
    final mediaType = file.type == MessageFileType.video ? 'VDO' : 'image';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(
        EventProperty.getChatTypeForEventParams(room.value!),
        mediaType,
      ),
    );
    await GetIt.I<SendFileMessageToServerUseCase>().call(
      SendFileMessageParams(
        chatRoomId: roomId,
        files: [file],
        isSending: true,
        isLocked: false,
        isMyNote: false,
        enableUploadPro: UserController.instance.enableUploadPro,
      ),
    );
  }

  Future<void> onSendFile(FileInfoModel file, {int loopCount = 1}) async {
    final mediaType = 'file';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(
        EventProperty.getChatTypeForEventParams(room.value!),
        mediaType,
      ),
    );

    FileInfoModel? image;
    // If selected file is image, decode to get width and height. Otherwise width and height value will be 0 and it
    // will cause divide by 0 error in message_type_image_v2.dart when calculating aspect ratio.
    if (file.type == MessageFileType.image && file.initFile != null) {
      final decodedImage = await decodeImageFromList(await file.initFile!.readAsBytes());
      image = FileInfoModel(
        type: file.type,
        width: decodedImage.width.toDouble(),
        height: decodedImage.height.toDouble(),
        initFile: file.initFile,
      );
    }

    await GetIt.I<SendFileMessageToServerUseCase>().call(
      SendFileMessageParams(
        chatRoomId: roomId,
        files: [image ?? file],
        isSending: true,
        isLocked: false,
        isMyNote: false,
        enableUploadPro: UserController.instance.enableUploadPro,
        loopCount: loopCount,
      ),
    );
  }

  Future<void> onShareLocation(MapInfoResponse location) async {
    final mediaType = 'location';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(
        EventProperty.getChatTypeForEventParams(room.value!),
        mediaType,
      ),
    );
    await GetIt.I<SendMessageToServerUseCase>().call(
      SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: roomType == RoomType.directSecret,
        isShare: false,
        message: MessageCollection(
          type: MessageType.location,
          meta: MessageMetaModel.fromMap(location.toMap()),
        ),
        roomCryptoKey: roomCryptoKey.value,
        accountId: currentUser!.id!,
        isSending: true,
      ),
    );
  }

  Future<void> onShareUChatContact(List<ContactCollection> contacts) async {
    final mediaType = 'contact';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(
        EventProperty.getChatTypeForEventParams(room.value!),
        mediaType,
      ),
    );
    List<Future<void>> futureSendMessages = [];
    for (final contact in contacts) {
      final ContactModel contactData = ContactModel(
        id: contact.id,
        avatarId: contact.avatarId,
        nickname: contact.nickname,
        displayName: contact.displayName,
        backgroundId: contact.backgroundId,
        backgroundBlurhash: contact.backgroundBlurhash,
        type: contact.type,
        originalStatusMessage: contact.statusMessage,
      );
      futureSendMessages.add(
        GetIt.I<SendMessageToServerUseCase>().call(
          SendMessageToServerParams(
            chatRoomId: roomId,
            isSecretRoom: roomType == RoomType.directSecret,
            isShare: false,
            message: MessageCollection(
              type: MessageType.contact,
              shareContactId: contact.id,
              contact: contactData,
            ),
            roomCryptoKey: roomCryptoKey.value,
            accountId: currentUser!.id!,
            isSending: true,
          ),
        ),
      );
    }
    await Future.wait(futureSendMessages);
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.contactShared, eventProperties: EventProperty.contactShared('UChat'));
  }

  Future<void> onSharePhoneContact(List<Contact> contacts) async {
    final mediaType = 'contact';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageSent,
      eventProperties: EventProperty.messageSent(
        EventProperty.getChatTypeForEventParams(room.value!),
        mediaType,
      ),
    );
    List<Future<void>> futureSendMessages = [];
    for (final contact in contacts) {
      final MobileContactModel mobileContactData = MobileContactModel(
        displayName: contact.displayName,
        phoneNumber: contact.phones.first.number,
      );
      futureSendMessages.add(
        GetIt.I<SendMessageToServerUseCase>().call(
          SendMessageToServerParams(
            chatRoomId: roomId,
            isSecretRoom: roomType == RoomType.directSecret,
            isShare: false,
            message: MessageCollection(
              type: MessageType.mobileContact,
              mobileContact: mobileContactData,
              isMyNote: false,
            ),
            roomCryptoKey: roomCryptoKey.value,
            accountId: currentUser!.id!,
            isSending: true,
          ),
        ),
      );
    }
    await Future.wait(futureSendMessages);
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.contactShared,
      eventProperties: EventProperty.contactShared('Device contacts'),
    );
  }

  /// Jump to the message in the message list.
  ///
  /// This method will call the [MessageListController.jumpToMessage] method.
  Future<void> jumpToMessage(MessageCollection message) async {
    try {
      await messageListCtl.jumpToMessage(message);
    } catch (e, stackTrace) {
      _log.e('Failed to jump to message', e, stackTrace);
    }
  }

  void updateShowGoBackToReplyButton(bool value) {
    showGoBackToReplyButton = value;
    update([ChatRoomIds.goBackToReplyButton]);
  }

  Future<void> goBackToReply() async {
    await messageListCtl.goBackToReply();
  }

  /// Pin a message in the room.
  ///
  /// This method will pin the given message in the current room.
  Future<void> pinMessage(MessageCollection message) async {
    try {
      if (!isAbleToPinMessages) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      final messageId = message.id;
      if (messageId == null) {
        return;
      }

      await GetIt.I<PinMessageUseCase>().call(
        PinMessageParams(
          messageId: messageId,
          roomId: roomId,
        ),
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else if (e.type == 'ERR_MESSAGE_PIN_LIMITED') {
        UChatNewDialog.showPinMessageLimitDialog(context: Get.context!);
      } else if (e.type == 'ERR_MESSAGE_NOT_FOUND') {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Message not found'.tr);
      } else if (e.type == 'ERR_MESSAGE_PIN_ALREADY_PINNED') {
        // Do nothing if message is already pinned
        _log.w('Message is already pined (API)', e, stackTrace);
      } else {
        _log.e('Failed to pin message', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      _log.e('Failed to pin message', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  /// Unpin a message in the room.
  ///
  /// This method will unpin the given pinned message in the current room.
  Future<void> unpinMessage(String ref) async {
    try {
      if (!isAbleToPinMessages) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await GetIt.I<UnpinMessageUseCase>().call(
        UnpinMessageParams(
          ref: ref,
          roomId: roomId,
        ),
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else if (e.type == 'ERR_MESSAGE_PIN_NOT_FOUND') {
        // Do nothing if message is already unpinned
        _log.w('No unpin message found (API)', e, stackTrace);
      } else {
        _log.e('Failed to unpin message', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } on NullResponseException catch (e, stackTrace) {
      _log.w('No unpin message found (Use case)', e, stackTrace);
    } catch (e, stackTrace) {
      _log.e('Failed to unpin message', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  /// Get all pinned messages in the room.
  ///
  /// This method will update the pinMessages variable with all pinned messages in the current room.
  Future<void> getPinMessagesInRoom() async {
    try {
      final params = GetPinMessagesRequest(
        roomId: roomId,
      );
      final paginationResult = await GetIt.I<GetPinMessagesInRoomUseCase>().call(params);
      pinMessages.value = paginationResult;
    } catch (e, stackTrace) {
      _log.e('Failed to get pin messages', e, stackTrace);
    }
  }

  /// Start watching pinned messages in the room.
  ///
  /// This method will subscribe to pinned messages changes and update the pinMessages list.
  void _startWatchingPinMessages() {
    final params = WatchPinMessagesInRoomParams(roomId: roomId);
    _pinMessagesSubscription = GetIt.I<WatchPinMessagesInRoomUseCase>().call(params).listen(
      (pinMessageEntities) {
        try {
          pinMessages.value = pinMessageEntities;
        } catch (e, stackTrace) {
          _log.e('Error updating pin messages', e, stackTrace);
        }
      },
      onError: (error, stackTrace) {
        _log.e('Error in pin messages stream', error, stackTrace);
      },
    );
  }

  void toggleSelectionInitial(
    SelectType type, {
    MessageCollection? initMsg,
  }) {
    if (type == SelectType.unsend && roomCapability.value.disableUnsendMessage == true) {
      UChatNewDialog.showPermissionDeniedDialog(
        context: Get.context!,
      );
      return;
    }
    selectedMessages([]);
    selectMessageType(type);
    toggleSelection(initMsg!);
  }

  void toggleSelection(MessageCollection msg) async {
    GetIt.I<VibrateUtil>().vibrateSelection();

    final newSelectedList = GetIt.I<ToggleMessageSelectionUseCase>().call(
      ToggleMessageSelectionParams(
        message: msg,
        selectedList: selectedMessages.value ?? [],
      ),
    );

    selectedMessages.value = newSelectedList;
  }

  void onImageItemSelected(MessageCollection msg, MessageFileModel image) {
    GetIt.I<VibrateUtil>().vibrateSelection();

    final newSelectedList = GetIt.I<ToggleMessageImageSelectionUseCase>().call(
      ToggleMessageImageSelectionParams(
        file: image,
        message: msg,
        selectedList: selectedMessages.value ?? [],
      ),
    );

    selectedMessages.value = newSelectedList;
  }

  void onCompleteSelection() async {
    bool? confirm = true;
    switch (selectMessageType.value) {
      case SelectType.delete:
        confirm = await UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Delete messages?'.tr,
          description:
              'Deleting these messages will only remove them from your view. Your friend will still be able to see them'
                  .tr,
          cancelText: 'Cancel'.tr,
          confirmText: 'Delete'.tr,
          confirmTextColor: Get.context!.theme.appColors.textError,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          onConfirm: _onCompleteDeleteMsg,
          onCancel: () async {
            Get.back(result: false);
          },
        );
      case SelectType.deleteOtherMessage:
        confirm = await UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Delete messages for all?'.tr,
          description: 'Deleting these messages will prevent them from being seen by you and other group members'.tr,
          cancelText: 'Cancel'.tr,
          confirmText: 'Delete'.tr,
          confirmTextColor: Get.context!.theme.appColors.textError,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          onConfirm: _onCompleteDeleteOtherMsg,
          onCancel: () async {
            Get.back(result: false);
          },
        );
      case SelectType.unsend:
        if (roomCapability.value.disableUnsendMessage == true) {
          UChatNewDialog.showPermissionDeniedDialog(
            context: Get.context!,
          );
          selectedMessages.value = null;
          selectMessageType(null);
          return;
        }
        confirm = await UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Unsend messages?'.tr,
          description: 'This message will be removed from both your chat and your friend\'s chat.'.tr,
          cancelText: 'Cancel'.tr,
          confirmText: 'Unsend'.tr,
          confirmTextColor: Get.context!.theme.appColors.textError,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          onConfirm: _onCompleteUnsendMsg,
          onCancel: () async {
            Get.back(result: false);
          },
        );
      case SelectType.share:
        onCompleteShareMsg();
        break;
      case SelectType.addToAlbum:
        if (roomCapability.value.disableAlbumMenu == true) {
          await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          break;
        } else {
          openAddToAlbumScreen();
          break;
        }
      default:
        break;
    }

    if (confirm != false) {
      selectedMessages.value = null;
      selectMessageType(null);
      selectedMessages.refresh();
    }
  }

  void _onCompleteDeleteMsg() async {
    final selectedList = combineImageMessageFiles();

    try {
      final params = DeleteMessageParams(
        roomId: roomId,
        messages: selectedList,
      );

      await GetIt.I<DeleteMessageUseCase>().call(params);
      GetIt.I<TaxonomyService>().sendEvent(EventName.messageDeleted);
    } catch (e) {
      _log.e('Failed to delete message', e);
    }
  }

  void _onCompleteDeleteOtherMsg() async {
    if (selectedMessages.value == null) return;

    final selectedList = combineImageMessageFiles();

    final params = DeleteOtherMessageParams(
      roomId: roomId,
      messages: selectedList,
    );

    try {
      await GetIt.I<DeleteOtherMessageUseCase>().call(params);
      GetIt.I<TaxonomyService>().sendEvent(EventName.messageDeleted);
    } on FailedHostLookupException catch (_) {
      _log.e('Failed to delete other message (Connection error)');
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e) {
      _log.e('Failed to delete other message (ApiException)', e);
      if (e.code == 403 || e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      }
    } catch (e) {
      _log.e('Failed to delete other message', e);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  List<MessageCollection> combineImageMessageFiles() {
    final selectedList = selectedMessages.value ?? [];

    if (selectedList.isEmpty == true) return [];

    bool hasDuplicated = selectedList.length != selectedList.toSet().length;

    /// Check if there are duplicated msgId in the list
    if (hasDuplicated) {
      Map<String, List<MessageFileModel>> groupedFiles = {};

      for (var msg in selectedList) {
        final msgId = msg.id;
        final msgFiles = msg.files;

        // Execute just message type image or video only
        if ((msg.type != MessageType.image && msg.type != MessageType.video) || msgId == null || msgFiles == null) {
          continue;
        }

        if (groupedFiles.containsKey(msgId)) {
          groupedFiles[msgId]!.addAll(msgFiles);
        } else {
          groupedFiles[msgId] = List.from(msgFiles);
        }
      }

      // Convert back to List<ModelA>
      final mergedList = groupedFiles.entries.map((entry) {
        MessageCollection msg = selectedList.firstWhere((e) => e.id == entry.key);
        msg.files = entry.value;

        return msg;
      }).toList();

      return mergedList;
    }

    return selectedList;
  }

  void _onCompleteUnsendMsg() async {
    try {
      final selectedList = combineImageMessageFiles();

      final params = UnsentMessageParams(
        roomId: roomId,
        messages: selectedList,
      );

      await GetIt.I<UnsentMessageUseCase>().call(params);
      GetIt.I<TaxonomyService>().sendEvent(EventName.messageUnsend);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(
          context: Get.context!,
        );
      } else {
        _log.e('Failed to unsend message', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      _log.e('Failed to unsend message', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<void> onCompleteShareMsg() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickShareMessage);
    await GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        messageList: selectedMessages.value
            ?.map((e) => ShareMessageSelectionEntity(message: e, fileIdList: e.files?.map((e) => e.id!).toList()))
            .toList(),
      ),
    );
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickShareMessage);
  }

  void openAddToAlbumScreen() {
    List<String> urlList = [];
    for (final message in selectedMessages.value!) {
      if (message.files != null) {
        urlList.addAll(message.files!.map((e) => e.apiFileUrl!));
      }
    }
    Get.toNamed(
      Routes.addToAlbum.replaceAll(':id', roomId),
      arguments: AddToAlbumArguments(
        roomId: roomId,
        selectedFilesUrl: urlList,
      ),
    );
  }

  void openRoomDetail() {
    onImageOrVideoSendCloseKeyboard();
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickContactinfo);
    if (roomNotAvailable) {
      return;
    }
    if (room.value?.isGroup == true) {
      Get.toNamed(
        Routes.roomDetailGroup.replaceAll(':id', roomId),
        arguments: ChatRoomDetailArgument(
          roomId: roomId,
        ),
      );
    } else {
      Get.toNamed(
        Routes.roomDetailDirect.replaceAll(':id', roomId),
        arguments: ChatRoomDetailArgument(
          roomId: roomId,
        ),
      );
    }
  }

  Future<void> updateUnreadCount(int count) async {
    if (unreadCount.value == 0) return;

    if (roomSub.value != null) {
      roomSub()?.unreadCount = count;
      await GetIt.I<UpdateRoomSubUseCase>().call(UpdateRoomSubParams(roomSub: roomSub()!));
      unreadCount.value = count;
    }
  }

  /// Scroll to the bottom of the message list
  void onScrollToBottom() async {
    try {
      messageListCtl.scrollToBottom();
      await updateUnreadCount(0);
      messageListCtl.clearGoBackToReplyData();
    } catch (e, stackTrace) {
      _log.e('onScrollToBottom error.', e, stackTrace);
    }
  }

  Future<void> handleBlock() async {
    try {
      await GetIt.I<BlockContactUseCase>().call(
        BlockContactParams(contactIds: [contact()!.id!]),
      );
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleBlockUser error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleAdd() async {
    final contactId = room()?.originalFirstOtherInRoom?.accountId;

    if (contactId == null) return;

    UChatLoading.show(status: 'Updating...'.tr);
    try {
      final response = await GetIt.I<AddContactUseCase>().call(AddContactRequest(friendAccountId: contactId));
      final updatedContact = response.contact;

      /// Set [isFriend] to true
      updatedContact.isFriend = true;

      // set new contact data to state
      // why we need to set it to null first?
      // because if we set it directly, the contact data will not be updated and the UI will not be updated
      // so we need to set it to null first and then set it to the new contact data
      // this is a workaround for the issue
      contact.value = null;
      contact.value = updatedContact;
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiFriendLimitExceedException catch (_) {
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } catch (e, stackTrace) {
      _log.e('handleAdd friend error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    } finally {
      await UChatLoading.hide();
    }
  }

  void handleDeclineFriendRequest() async {
    try {
      await UChatLoading.show(status: 'Loading...'.tr);

      final friendId = room()?.originalFirstOtherInRoom?.accountId;

      if (friendId == null) {
        await UChatLoading.hide();
        return;
      }

      await GetIt.I<DeclineFriendUseCase>().call(DeclineFriendRequest(
        friendAccountId: friendId,
      ));

      await UChatLoading.hide();
      isFriendRequesting.value = false;
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleDeclineFriendRequest error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  /// Handle connectivity changes
  ///
  /// If the previous status was offline and the current status is online,
  /// fetch the room members to update the state.
  void onConnectivityChanged(ConnectivityChangedEvent changedStatus) {
    if (changedStatus.previous == ConnectivityStatus.offline &&
        ConnectivityStatus.internetAvailableStatuses.contains(changedStatus.current)) {
      getRoomMemberToState();
    }
  }
}
