part of '../taxonomy_service.dart';

class EventProperty {
  EventProperty._();

  static Map<String, String> openApp({required String accountType}) {
    return {'account_type': accountType};
  }

  static Map<String, String> pageViewed({required Route route}) {
    final routeName = route.settings.name;
    String pageName = '/unknown';

    if (routeName != null) {
      pageName = routeName;
    } else {
      if (route is MaterialPageRoute) {
        final widget = route.settings.arguments as Widget?;
        if (widget != null) {
          pageName = widget.runtimeType.toString();
        }
      } else if (route is CupertinoPageRoute) {
        final widget = route.settings.arguments as Widget?;
        if (widget != null) {
          pageName = widget.runtimeType.toString();
        }
      }
    }

    return {'page_name': Uri.decodeComponent(pageName), 'route_type': route.runtimeType.toString()};
  }

  static String getChatTypeForEventParams(RoomCollection? room) {
    if (room == null) {
      return 'friends';
    }
    String chatType = 'friends';
    final otherRoomMember = room.firstOtherInRoom;
    if (otherRoomMember != null && otherRoomMember.account != null && otherRoomMember.account?.isOfficial == true) {
      chatType = 'official account';
    } else if (room.isDirect != true) {
      chatType = 'groups';
    }

    return chatType;
  }

  static Future<String> getNetworkTypeForEventParams() async {
    NetworkStatus networkStatus = await ConnectionNetworkType().currentNetworkStatus();

    switch (networkStatus) {
      case NetworkStatus.wifi:
        return 'WIFI';
      case NetworkStatus.mobile2G:
        return '2G';
      case NetworkStatus.mobile3G:
        return '3G';
      case NetworkStatus.mobile4G:
        return '4G';
      case NetworkStatus.mobile5G:
        return '5G';
      default:
        return 'UNKNOWN';
    }
  }

  static String getMessageTypeForEventParams(MessageType type) {
    if (type == MessageType.sticker) {
      return 'sticker';
    } else if (type == MessageType.gif) {
      return 'gif';
    } else if (type == MessageType.location) {
      return 'location';
    } else if (type == MessageType.contact || type == MessageType.mobileContact) {
      return 'contact';
    } else if (type == MessageType.audio) {
      return 'audio';
    } else if (type == MessageType.mobileContact) {
      return 'contact';
    } else if (type == MessageType.image) {
      return 'image';
    } else if (type == MessageType.video) {
      return 'VDO';
    } else if (type == MessageType.file) {
      return 'file';
    } else if (type == MessageType.album) {
      return 'album';
    } else if (type == MessageType.stickerGift) {
      return 'sticker_gift';
    } else if (type == MessageType.stickerSharing) {
      return 'sticker_sharing';
    } else {
      return 'text';
    }
  }

  static Map<String, String> pageViewedBottomNavBar({required int paneIndex}) {
    String pageName;

    switch (paneIndex) {
      case 0:
        pageName = 'contact_list_tab';
        break;
      case 1:
        pageName = 'chat_list_tab';
        break;
      case 2:
        pageName = 'call_log_tab';
        break;
      case 3:
        pageName = 'central_notification_tab';
        break;
      case 4:
        pageName = 'my_profile_tab';
        break;
      case 5:
        pageName = 'back_tab';
        break;
      case 6:
        pageName = 'setting_account_tab';
        break;
      default:
        pageName = 'unknown_tab';
        break;
    }

    return {'page_name': pageName};
  }

  static Map<String, Object?> appErrorOccurred({
    required dynamic errorType,
    String? errorMessage,
    String? errorAdditionalMessage,
    Map<String, dynamic>? errorAdditionalData,
  }) {
    return {
      'error_type': errorType.toString(),
      'error_message': errorMessage,
      'error_additional_message': errorAdditionalMessage,
      'error_additional_data': errorAdditionalData,
      'current_route': Get.currentRoute,
      'prev_route': Get.previousRoute,
    };
  }

  static Map<String, bool> qrCodeScanned({
    required bool isUChat,
  }) {
    return {
      'is_UChat': isUChat,
    };
  }

  static Map<String, String> clickAcceptAddFriendPage({
    required String requestType,
  }) {
    return {
      'request_type': requestType,
    };
  }

  static Map<String, String> clickAddFriendSearchPage({
    required String friendType,
  }) {
    return {
      'friend_type': friendType,
    };
  }

  static Map<String, String> inputPhoneNumberAddFriendPage({
    required String countryName,
  }) {
    return {
      'country_name': countryName,
    };
  }

  static Map<String, String> clickTabRequestAddFriendPage({
    required String tapRequestCategory,
  }) {
    return {
      'tap_request_category': tapRequestCategory,
    };
  }

  static Map<String, String> searchingUChatIdAddFriendPage({
    required String searchInput,
  }) {
    return {
      'search_input': searchInput,
    };
  }

  static Map<String, String> clickContact({
    required String contactType,
  }) {
    return {
      'contact_type': contactType,
    };
  }

  static Map<String, String> swipeActionContactPage({
    required String swipeAction,
    required String contactType,
  }) {
    return {
      'swipe_action': swipeAction,
      'contact_type': contactType,
    };
  }

  static Map<String, String> clickLongPressAction({
    required String longPressQuickAction,
    required String contactType,
  }) {
    return {
      'long_press_quick_action': longPressQuickAction,
      'contact_type': contactType,
    };
  }

  static Map<String, String> clickTabContactHomepage({
    required String tapCategory,
  }) {
    return {
      'tap_category': tapCategory,
    };
  }

  static Map<String, String> selectCountryCodePhoneNumber(String countryName, String countryCode) {
    return {
      'country_name': '$countryName(+$countryCode)',
    };
  }

  static Map<String, String> clickContinueSignUp(String method) {
    return {
      'signup_method': method,
    };
  }

  static Map<String, String> chatOpened(String chatType, String entrypoint) {
    return {
      'chat_type': chatType,
      'entrypoint': entrypoint,
    };
  }

  static Map<String, String> typingMessage(String chatType) {
    return {
      'chat_type': chatType,
    };
  }

  static Map<String, String> messageSent(String chatType, String mediaType) {
    return {
      'chat_type': chatType,
      'media_type': mediaType,
    };
  }

  static Map<String, String> resentMessage(String chatType, String mediaType) {
    return {
      'chat_type': chatType,
      'media_type': mediaType,
    };
  }

  static Map<String, String> messageReceived(String chatType, String mediaType) {
    return {
      'chat_type': chatType,
      'media_type': mediaType,
    };
  }

  static Map<String, String> chatListSorted(String sorting) {
    return {
      'sorting': sorting,
    };
  }

  static Map<String, String> chatListCategory(String chatCategory) {
    return {
      'category': chatCategory,
    };
  }

  static Map<String, String> clickClearSearchResult(String location) {
    return {
      'location': location,
    };
  }

  static Map<String, String> clickMoreSwipeAction(String moreAction, String chatType) {
    return {
      'more_action': moreAction,
      'chat_type': chatType,
    };
  }

  static Map<String, String> longPressChatRoom(String mediaType) {
    return {
      'media_type': mediaType,
    };
  }

  static Map<String, String> longPressActionChatRoom(String longPressAction, String mediaType) {
    return {'long_press_action': longPressAction, 'media_type': mediaType};
  }

  static Map<String, String> clickShareMessage(String mediaType) {
    return {'media_type': mediaType};
  }

  static Map<String, String> messageShared(String platform) {
    return {'platform': platform};
  }

  static Map<String, String> messageReported(String typeReport, String howReport) {
    return {'type_report': typeReport, 'how_report': howReport};
  }

  static Map<String, String> messageUnsend(String mediaType) {
    return {'media_type': mediaType};
  }

  static Map<String, String> messageDeleted(String mediaType) {
    return {'media_type': mediaType};
  }

  static Map<String, String> stickerSent(String stickerName, String stickerOwner) {
    return {'sticker_name': stickerName, 'sticker_owner': stickerOwner};
  }

  static Map<String, String> contactShared(String contactType) {
    return {'contact_type': contactType};
  }

  static Map<String, String> clickEditNameRoomDetails(String chatType) {
    return {'chat_type': chatType};
  }

  static Map<String, String> editNameSuccessfully(String chatType) {
    return {'chat_type': chatType};
  }

  static Map<String, String> changeThemeSuccessfully(String themeType) {
    return {'theme_type': themeType};
  }

  static Map<String, String> clickReportRoomDetails(String chatType) {
    return {'chat_type': chatType};
  }

  static Map<String, String> contactReported(String typeReport, String howReport, String chatType) {
    return {
      'type_report': typeReport,
      'how_report': howReport,
      'chat_type': chatType,
    };
  }

  static Map<String, String> chatListEdited(String editing) {
    return {'editing': editing};
  }

  static Map<String, String> longPressActionChatList(String longPressAction) {
    return {'longpress_chatlist_action': longPressAction};
  }

  static Map<String, String> clickVoiceCall(String entryPoint) {
    return {'entry_point': entryPoint};
  }

  static Map<String, String> clickVideoCall(String entryPoint) {
    return {'entry_point': entryPoint};
  }

  static Map<String, String> callStarted(String callType, String networkType) {
    return {'call_type': callType, 'network_type': networkType};
  }

  static Map<String, String> callConnected(String callType, String networkType, String connectionQuality) {
    return {'call_type': callType, 'network_type': networkType, 'connection_quality': connectionQuality};
  }

  static Map<String, String> callFailed(String callType, String networkType, String reason) {
    return {'call_type': callType, 'network_type': networkType, 'failure_reason': reason};
  }

  static Map<String, String> callEnded(String callType, String endReason) {
    return {'call_type': callType, 'call_end_reason': endReason};
  }

  static Map<String, String> callAccepted(String acceptSource, String callType) {
    return {'accept_source': acceptSource, 'call_type': callType};
  }

  static Map<String, String> notificationOpened(NotificationOnesignalEntity notificationEntity) {
    return {
      'notification_id': notificationEntity.id,
      'notification_title': notificationEntity.title,
      'notification_body': notificationEntity.body,
      'notification_type': notificationEntity.type.taxonomyType,
      'notification_additional_data': notificationEntity.additionalData.toString(),
    };
  }

  static Map<String, String> clickAcceptNotificationPage(String requestType) {
    return {'request_type': requestType};
  }

  static Map<String, String> notificationUpdate(String status) {
    return {'status': status};
  }

  static Map<String, String> clickStickerSearchResult(String stickerTitle, String creatorName) {
    return {'sticker_title': stickerTitle, 'creator_name': creatorName};
  }

  static Map<String, String> stickerTabClicked(String tabName) {
    return {'tab_name': tabName};
  }

  static Map<String, dynamic> stickerDetailViewed(
    String stickerTitle,
    String creatorName,
    double price,
    bool isFree,
    String entryPoint,
  ) {
    return {
      'sticker_title': stickerTitle,
      'creator_name': creatorName,
      'price': price.toString(),
      'is_free': isFree ? 'yes' : 'no',
      'entry_point': entryPoint,
    };
  }

  static Map<String, dynamic> stickerDownloaded(String stickerTitle, String creatorName, double price, bool isFree) {
    return {
      'sticker_title': stickerTitle,
      'creator_name': creatorName,
      'price': price.toString(),
      'is_free': isFree ? 'yes' : 'no',
    };
  }

  static Map<String, String> stickerPurchased(String stickerTitle, String creatorName, double price) {
    return {
      'sticker_title': stickerTitle,
      'creator_name': creatorName,
      'price': price.toString(),
    };
  }

  static Map<String, dynamic> stickerSentAsGift(String stickerTitle, String creatorName) {
    return {'sticker_title': stickerTitle, 'creator_name': creatorName};
  }

  static Map<String, String> coinStoreViewed(String entryPoint) {
    return {'entry_point': entryPoint};
  }

  static Map<String, String> coinPackageSelected(int packageAmount) {
    return {'package_amount': '$packageAmount coins'};
  }

  static Map<String, String> coinPurchaseInitiated(int packageAmount) {
    return {'package_amount': '$packageAmount coins'};
  }

  static Map<String, String> coinPurchaseCompleted(String transactionId, int packageAmount) {
    return {'transaction_id': transactionId, 'package_amount': '$packageAmount coins'};
  }

  static Map<String, String> coinPurchaseFailed(
    String errorCode,
    int packageAmount,
    String errorType,
    String errorMessage,
  ) {
    return {
      'error_code': errorCode,
      'package_amount': '$packageAmount coins',
      'error_type': errorType,
      'error_message': errorMessage,
    };
  }

  static Map<String, String> profileUpdate(String fieldUpdated) {
    return {'field_changed': fieldUpdated};
  }

  static Map<String, String> clickShowStatus(String status) {
    return {'status': status};
  }

  static Map<String, String> clickHidePhoneNumber(String status) {
    return {'status': status};
  }

  static Map<String, String> clickPasscode(String status) {
    return {'status': status};
  }

  static Map<String, String> clickUseTouchAndFaceId(String status) {
    return {'status': status};
  }

  static Map<String, String> clickAllowToAddFriend(String status) {
    return {'status': status};
  }

  static Map<String, String> clickAllowCall(String status) {
    return {'status': status};
  }

  static Map<String, String> twoFactorEnable(String status) {
    return {'status': status};
  }

  static Map<String, dynamic> coinPurchaseValidated(
    String purchaseId,
    String purchaseStatus,
    bool pendingCompletePurchase,
  ) {
    return {
      'purchase_id': purchaseId,
      'purchase_status': purchaseStatus,
      'pending_complete_purchase': pendingCompletePurchase,
    };
  }

  static Map<String, dynamic> stateReceived(UpdateStateModel state) {
    final now = DateTime.now();
    return {
      'state_type': state.type.name,
      'state_group': state.group.name,
      'state_seq': state.seq,
      'state_created_at': state.createdAt?.toIso8601String(),
      'state_received_at': now.toIso8601String(),
      'state_delivery_time_ms': state.createdAt != null ? now.difference(state.createdAt!).inMilliseconds : null,
    };
  }

  static Map<String, dynamic> processStateCompleted({
    required UpdateStateModel state,
    required DateTime addToAddStateQueueAt,
    required DateTime startAddStateAt,
    required DateTime addToSyncQueueAt,
    required DateTime startProcessAt,
    required DateTime processCompletedAt,
    required int missingStateCount,
    required List<String> missingStateList,
  }) {
    final data = <String, dynamic>{
      'state_type': state.type.name,
      'state_group': state.group.name,
      'state_seq': state.seq,
      'state_created_at': state.createdAt?.toIso8601String(),
      'add_to_add_state_queue_at': addToAddStateQueueAt.toIso8601String(),
      'start_add_state_at': startAddStateAt.toIso8601String(),
      'add_to_sync_queue_at': addToSyncQueueAt.toIso8601String(),
      'start_process_at': startProcessAt.toIso8601String(),
      'process_completed_at': processCompletedAt.toIso8601String(),
      'add_state_queue_time_ms': startAddStateAt.difference(addToAddStateQueueAt).inMilliseconds,
      'add_state_process_time_ms': addToSyncQueueAt.difference(startAddStateAt).inMilliseconds,
      'sync_state_queue_time_ms': startProcessAt.difference(addToSyncQueueAt).inMilliseconds,
      'state_process_time_ms': processCompletedAt.difference(startProcessAt).inMilliseconds,
    };
    if (state.createdAt != null) {
      data['total_time_ms'] = processCompletedAt.difference(state.createdAt!).inMilliseconds;
    }
    if (missingStateCount > 0) {
      data['missing_state_count'] = missingStateCount;
      data['missing_state_list'] = missingStateList;
    }
    return data;
  }
}
