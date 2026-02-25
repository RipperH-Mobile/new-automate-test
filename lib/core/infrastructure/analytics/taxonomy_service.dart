import 'package:connection_network_type/connection_network_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/notification/common/notification_onesignal_entity.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';

part 'implementation/taxonomy_event_property.dart';

abstract class TaxonomyService {
  /// Send an event to the analytics service.
  Future<void> sendEvent(EventName eventName, {Map<String, dynamic>? eventProperties, bool sendImmediately = false});

  Future<void> onAuthenticated(
    UserEntity? user, {
    int? officialAccountNumber,
    int? friendNumber,
    int? groupNumber,
  });

  /// Initialize the user detail into the analytics service.
  Future<void> setUser(
    UserEntity user, {
    Map<String, dynamic>? userProperties,
    int? officialAccountNumber,
    int? friendNumber,
    int? groupNumber,
  });

  /// Unset the user detail in the analytics service.
  Future<void> onUnauthenticated();
}

class TaxonomyEvent {
  final EventName eventName;
  final Map<String, dynamic>? eventProperties;
  final EventCategory eventCategory;

  TaxonomyEvent({
    required this.eventName,
    this.eventProperties,
  }) : eventCategory = eventName.category;

  TaxonomyEvent copyWith({
    EventName? eventName,
    Map<String, dynamic>? eventProperties,
  }) {
    return TaxonomyEvent(
      eventName: eventName ?? this.eventName,
      eventProperties: eventProperties ?? this.eventProperties,
    );
  }
}

enum EventCategory {
  other,
  general,
  contact,
  addFriend,
  loginRegister,
  chatListChatRoom,
  call,
  notification,
  stickerAndCoin,
  setting,
  statePerformanceTracking;

  String get name {
    switch (this) {
      case EventCategory.general:
        return 'general';
      case EventCategory.contact:
        return 'contact';
      case EventCategory.addFriend:
        return 'add_friend';
      case EventCategory.other:
        return 'other';
      case EventCategory.loginRegister:
        return 'loginRegister';
      case EventCategory.chatListChatRoom:
        return 'chatListChatRoom';
      case EventCategory.call:
        return 'call';
      case EventCategory.notification:
        return 'notification';
      case EventCategory.stickerAndCoin:
        return 'stickerAndCoin';
      case EventCategory.setting:
        return 'setting';
      case EventCategory.statePerformanceTracking:
        return 'state_performance_tracking';
    }
  }
}

enum EventName {
  openApp,
  pageViewed,
  appErrorOccurred,
  clickTabContactHomepage,
  clickSearchContactHomepage,
  searchingContact,
  clickTabContactSearchPage,
  clickAddFriendSearchPage,
  clickInviteAddFriendPage,
  clickShareInvite,
  inviteShared,
  clickCopyInvite,
  inviteCopied,
  clickQRCodeAddFriendPage,
  clickMyQRCodePage,
  clickShareMyQR,
  myQRShared,
  clickSaveMyQR,
  myQRSaved,
  qrCodeScanned,
  clickAddFriendProfilePage,
  acceptAddFriendProfilePage,
  clickSendMessageProfilePage,
  clickVoiceCallProfilePage,
  clickVideoCallProfilePage,
  clickPhotoQRCodePage,
  clickSearchAddFriendPage,
  searchingUChatIdAddFriendPage,
  inputPhoneNumberAddFriendPage,
  clickTabRequestAddFriendPage,
  clickAcceptAddFriendPage,
  swipeContactPage,
  swipeActionContactPage,
  longPressContactPage,
  clickLongPressAction,
  clickContact,
  clickGetStarted,
  clickContinueSignUp,
  inputEmail,
  clickContinueEmail,
  inputOtp,
  clickResendOtp,
  inputCreatePassword,
  clickContinueCreatePassword,
  inputConfirmPassword,
  clickForgotPassword,
  clickCountryPhoneNumber,
  selectCountryPhoneNumber,
  inputPhoneNumber,
  clickContinuePhoneNumber,
  clickAgreeTermAndCon,
  inputCreateName,
  clickContinueCreateName,
  inputCreateUChatId,
  clickContinueCreateUChatId,
  uploadProfile,
  registerCompleted,
  loginSucceeded,
  clickNewmessageChatlist,
  chatOpened,
  clickSendboxChatroom,
  typingMessage,
  messageSent,
  resentMessage,
  messageReceived,
  messageRead,
  chatErrorOccurred,
  clickHamburgerChatlistpage,
  clickEditChatlist,
  chatlistEdited,
  chatlistSorted,
  chatlistCategory,
  clickSearchboxChatlistpage,
  clickClearSearchresult,
  searchingChatlistpage,
  clickSearchResultChatlist,
  clickCreateGroup,
  createGroupSuccessfully,
  swipeChatlistpage,
  clickMoreSwipeaction,
  clickDelete,
  longpressChatlist,
  longpressActionChatlist,
  longpressChatroom,
  longpressActionChatroom,
  messageCopied,
  clickPinMessage,
  clickUnpinMessage,
  clickShareMessage,
  messageShared,
  messageReported,
  messageUnsend,
  messageDeleted,
  clickStickerIcon,
  clickGifIcon,
  stickerSent,
  clickPictureIcon,
  clickAudioIcon,
  clickPauseAudio,
  clickContinueAudio,
  clickCancelAudio,
  clickAddIcon,
  clickAddShareafile,
  clickAddLocation,
  clickAddContact,
  contactShared,
  clickCameraIcon,
  clickContactinfo,
  clickSearchRoomdetails,
  searchingRoomdetails,
  clickSearchresultRoomdetails,
  clickMuteRoomdetails,
  clickUnmuteRoomdetails,
  clickEditNameRoomdetails,
  editNameSuccessfully,
  clickThemeRoomdetails,
  changeThemeSuccessfully,
  clickMediaRoomdetails,
  clickFilesRoomdetails,
  clickLinksRoomdetails,
  clickAlbumRoomdetails,
  clickSharecontactRoomdetails,
  clickPinchatRoomdetails,
  clickDeletechatRoomdetails,
  clickBlockcontactRoomdetails,
  clickUnblockcontactRoomdetails,
  clickReportRoomdetails,
  contactReported,
  clickCallIcon,
  clickVoiceCall,
  clickVideoCall,
  callStarted,
  callConnected,
  callFailed,
  callDropped,
  callEnded,
  callSwitchedMode,
  callAccepted,
  notificationOpened,
  clickAcceptNotificationPage,
  notificationUpdated,
  clickStickerSettingPage,
  clickCoinSettingPage,
  clickSearchBarStickerStore,
  searchingSticker,
  clickStickerSearchResult,
  stickerTabClicked,
  stickerDetailViewed,
  stickerDownloaded,
  stickerPurchased,
  stickerSentAsGift,
  coinStoreViewed,
  coinPackageSelected,
  coinPurchaseInitiated,
  coinPurchaseValidated,
  coinPurchaseCompleted,
  coinPurchaseFailed,
  twoFactorEnable,
  clickProfileSettingPage,
  profileUpdated,
  clickShowStatus,
  clickHidePhoneNumber,
  clickPasscode,
  clickUseTouchAndFaceId,
  logOutSuccessfully,
  clickStickersSettingPage,
  clickCoinsSettingPage,
  clickAccountsCenterPage,
  clickAccountSettingPage,
  accountDeactivationInitiated,
  accountDeleted,
  clickChatAndCallSettingPage,
  clickAllowToAddFriend,
  clickHiddenAccount,
  clickBlockedAccount,
  clickHiddenChats,
  clickAllowCall,
  clickSettingsSettingPage,
  clickHelpCenter,
  receiveStateFromSocket,
  receiveStateFromFirebase,
  processStateCompleted;

  String get name {
    switch (this) {
      case EventName.openApp:
        return 'open_app';
      case EventName.pageViewed:
        return 'page_viewed';
      case EventName.appErrorOccurred:
        return 'app_error_occurred';
      case EventName.clickTabContactHomepage:
        return 'click_tab_contact_homepage';
      case EventName.clickSearchContactHomepage:
        return 'click_search_contact_homepage';
      case EventName.searchingContact:
        return 'searching_contact';
      case EventName.clickTabContactSearchPage:
        return 'click_tab_contact_search_page';
      case EventName.clickAddFriendSearchPage:
        return 'click_add_friend_search_page';
      case EventName.clickInviteAddFriendPage:
        return 'click_invite_add_friend_page';
      case EventName.clickShareInvite:
        return 'click_share_invite';
      case EventName.inviteShared:
        return 'invite_shared';
      case EventName.clickCopyInvite:
        return 'click_copy_invite';
      case EventName.inviteCopied:
        return 'invite_copied';
      case EventName.clickQRCodeAddFriendPage:
        return 'click_qr_code_add_friend_page';
      case EventName.clickMyQRCodePage:
        return 'click_my_qr_code_page';
      case EventName.clickShareMyQR:
        return 'click_share_my_qr';
      case EventName.myQRShared:
        return 'my_qr_shared';
      case EventName.clickSaveMyQR:
        return 'click_save_my_qr';
      case EventName.myQRSaved:
        return 'my_qr_saved';
      case EventName.qrCodeScanned:
        return 'qr_code_scanned';
      case EventName.clickAddFriendProfilePage:
        return 'click_add_friend_profile_page';
      case EventName.acceptAddFriendProfilePage:
        return 'accept_add_friend_profile_page';
      case EventName.clickSendMessageProfilePage:
        return 'click_send_message_profile_page';
      case EventName.clickVoiceCallProfilePage:
        return 'click_voice_call_profile_page';
      case EventName.clickVideoCallProfilePage:
        return 'click_video_call_profile_page';
      case EventName.clickPhotoQRCodePage:
        return 'click_photo_qr_code_page';
      case EventName.clickSearchAddFriendPage:
        return 'click_search_add_friend_page';
      case EventName.searchingUChatIdAddFriendPage:
        return 'searching_uchat_id_add_friend_page';
      case EventName.inputPhoneNumberAddFriendPage:
        return 'input_phone_number_add_friend_page';
      case EventName.clickTabRequestAddFriendPage:
        return 'click_tab_request_add_friend_page';
      case EventName.clickAcceptAddFriendPage:
        return 'click_accept_add_friend_page';
      case EventName.swipeContactPage:
        return 'swipe_contact_page';
      case EventName.longPressContactPage:
        return 'long_press_contact_page';
      case EventName.clickLongPressAction:
        return 'click_long_press_action';
      case EventName.clickContact:
        return 'click_contact';
      case EventName.swipeActionContactPage:
        return 'swipe_action_contact_page';
      case EventName.clickGetStarted:
        return 'click_get_started';
      case EventName.clickContinueSignUp:
        return 'click_continue_signup';
      case EventName.inputEmail:
        return 'input_email';
      case EventName.clickContinueEmail:
        return 'click_continue_email';
      case EventName.inputOtp:
        return 'input_otp';
      case EventName.clickResendOtp:
        return 'click_resend_otp';
      case EventName.inputCreatePassword:
        return 'create_password';
      case EventName.clickContinueCreatePassword:
        return 'click_continue_create_password';
      case EventName.inputConfirmPassword:
        return 'input_confirm_password';
      case EventName.clickForgotPassword:
        return 'click_forgot_password';
      case EventName.clickCountryPhoneNumber:
        return 'click_country_phone_number';
      case EventName.selectCountryPhoneNumber:
        return 'select_country_phone_number';
      case EventName.inputPhoneNumber:
        return 'input_phone_number';
      case EventName.clickContinuePhoneNumber:
        return 'click_continue_phone_number';
      case EventName.clickAgreeTermAndCon:
        return 'click_agree_t&c';
      case EventName.inputCreateName:
        return 'input_create_name';
      case EventName.clickContinueCreateName:
        return 'click_continue_create_name';
      case EventName.inputCreateUChatId:
        return 'input_create_uchat_id';
      case EventName.clickContinueCreateUChatId:
        return 'click_continue_create_uchat_id';
      case EventName.uploadProfile:
        return 'upload_profile';
      case EventName.registerCompleted:
        return 'register_completed';
      case EventName.loginSucceeded:
        return 'login_succeeded';
      case EventName.clickNewmessageChatlist:
        return 'click_newmessage_chatlist';
      case EventName.chatOpened:
        return 'chat_opend';
      case EventName.clickSendboxChatroom:
        return 'click_sendbox_chatroom';
      case EventName.typingMessage:
        return 'typing_message';
      case EventName.messageSent:
        return 'message_sent';
      case EventName.resentMessage:
        return 'resent_message';
      case EventName.messageReceived:
        return 'message_received';
      case EventName.messageRead:
        return 'message_read';
      case EventName.chatErrorOccurred:
        return 'chat_error_occurred';
      case EventName.clickHamburgerChatlistpage:
        return 'click_hamburger_chatlistpage';
      case EventName.clickEditChatlist:
        return 'click_edit_chatlist';
      case EventName.chatlistEdited:
        return 'chatlist_edited';
      case EventName.chatlistSorted:
        return 'chatlist_sorted';
      case EventName.chatlistCategory:
        return 'chatlist_category';
      case EventName.clickSearchboxChatlistpage:
        return 'click_searchbox_chatlistpage';
      case EventName.clickClearSearchresult:
        return 'click_clear_searchresult';
      case EventName.searchingChatlistpage:
        return 'searching_chatlistpage';
      case EventName.clickSearchResultChatlist:
        return 'click_search_result_chatlist';
      case EventName.clickCreateGroup:
        return 'click_create_group';
      case EventName.createGroupSuccessfully:
        return 'create_group_successfully';
      case EventName.swipeChatlistpage:
        return 'swipe_chatlistpage';
      case EventName.clickMoreSwipeaction:
        return 'click_more_swipeaction';
      case EventName.clickDelete:
        return 'click_delete';
      case EventName.longpressChatroom:
        return 'longpress_chatroom';
      case EventName.longpressActionChatroom:
        return 'longpress_action_chatroom';
      case EventName.messageCopied:
        return 'message_copied';
      case EventName.clickPinMessage:
        return 'click_pin_message';
      case EventName.clickUnpinMessage:
        return 'click_unpin_message';
      case EventName.clickShareMessage:
        return 'click_share_message';
      case EventName.messageShared:
        return 'message_shared';
      case EventName.messageReported:
        return 'message_reported';
      case EventName.messageUnsend:
        return 'message_unsend';
      case EventName.messageDeleted:
        return 'message_deleted';
      case EventName.clickStickerIcon:
        return 'click_sticker_icon';
      case EventName.clickGifIcon:
        return 'click_gif_icon';
      case EventName.stickerSent:
        return 'sticker_sent';
      case EventName.clickPictureIcon:
        return 'click_picture_icon';
      case EventName.clickAudioIcon:
        return 'click_audio_icon';
      case EventName.clickPauseAudio:
        return 'click_pause_audio';
      case EventName.clickContinueAudio:
        return 'click_continue_audio';
      case EventName.clickCancelAudio:
        return 'click_cancel_audio';
      case EventName.clickAddIcon:
        return 'click_add_icon';
      case EventName.clickAddShareafile:
        return 'click_add_shareafile';
      case EventName.clickAddLocation:
        return 'click_add_location';
      case EventName.clickAddContact:
        return 'click_add_contact';
      case EventName.contactShared:
        return 'contact_shared';
      case EventName.clickCameraIcon:
        return 'click_camera_icon';
      case EventName.clickContactinfo:
        return 'click_contactinfo';
      case EventName.clickSearchRoomdetails:
        return 'click_search_roomdetails';
      case EventName.searchingRoomdetails:
        return 'searching_roomdetails';
      case EventName.clickSearchresultRoomdetails:
        return 'click_searchresult_roomdetails';
      case EventName.clickMuteRoomdetails:
        return 'click_mute_roomdetails';
      case EventName.clickUnmuteRoomdetails:
        return 'click_unmute_roomdetails';
      case EventName.clickEditNameRoomdetails:
        return 'click_edit_name_roomdetails';
      case EventName.editNameSuccessfully:
        return 'edit_name_successfully';
      case EventName.clickThemeRoomdetails:
        return 'click_theme_roomdetails';
      case EventName.changeThemeSuccessfully:
        return 'change_theme_successfully';
      case EventName.clickMediaRoomdetails:
        return 'click_media_roomdetails';
      case EventName.clickFilesRoomdetails:
        return 'click_files_roomdetails';
      case EventName.clickLinksRoomdetails:
        return 'click_links_roomdetails';
      case EventName.clickAlbumRoomdetails:
        return 'click_album_roomdetails';
      case EventName.clickSharecontactRoomdetails:
        return 'click_sharecontact_roomdetails';
      case EventName.clickPinchatRoomdetails:
        return 'click_pinchat_roomdetails';
      case EventName.clickDeletechatRoomdetails:
        return 'click_deletechat_roomdetails';
      case EventName.clickBlockcontactRoomdetails:
        return 'click_blockcontact_roomdetails';
      case EventName.clickReportRoomdetails:
        return 'click_report_roomdetails';
      case EventName.contactReported:
        return 'contact_reported';
      case EventName.longpressChatlist:
        return 'longpress_chatlist';
      case EventName.longpressActionChatlist:
        return 'longpress_action_chatlist';
      case EventName.clickUnblockcontactRoomdetails:
        return 'click_unblockcontact_roomdetails';
      case EventName.clickCallIcon:
        return 'click_call_icon';
      case EventName.clickVoiceCall:
        return 'click_voicecall';
      case EventName.clickVideoCall:
        return 'click_videocall';
      case EventName.callStarted:
        return 'call_started';
      case EventName.callConnected:
        return 'call_connected';
      case EventName.callFailed:
        return 'call_failed';
      case EventName.callDropped:
        return 'call_dropped';
      case EventName.callEnded:
        return 'call_ended';
      case EventName.callSwitchedMode:
        return 'call_switched_mode';
      case EventName.callAccepted:
        return 'call_accepted';
      case EventName.notificationOpened:
        return 'notification_opened';
      case EventName.clickAcceptNotificationPage:
        return 'click_accept_notification_page';
      case EventName.notificationUpdated:
        return 'notification_updated';
      case EventName.clickStickerSettingPage:
        return 'click_sticker_settingpage';
      case EventName.clickCoinSettingPage:
        return 'click_coin_settingpage';
      case EventName.clickSearchBarStickerStore:
        return 'click_searchbar_sticker_store';
      case EventName.searchingSticker:
        return 'searching_sticker';
      case EventName.clickStickerSearchResult:
        return 'click_sticker_search_result';
      case EventName.stickerTabClicked:
        return 'sticker_tab_clicked';
      case EventName.stickerDetailViewed:
        return 'sticker_detail_viewed';
      case EventName.stickerDownloaded:
        return 'sticker_downloaded';
      case EventName.stickerPurchased:
        return 'sticker_purchased';
      case EventName.stickerSentAsGift:
        return 'sticker_sent_as_gift';
      case EventName.coinStoreViewed:
        return 'coin_store_viewed';
      case EventName.coinPackageSelected:
        return 'coin_package_selected';
      case EventName.coinPurchaseInitiated:
        return 'coin_purchase_initiated';
      case EventName.coinPurchaseValidated:
        return 'coin_purchase_validated';
      case EventName.coinPurchaseCompleted:
        return 'coin_purchase_completed';
      case EventName.coinPurchaseFailed:
        return 'coin_purchase_failed';
      case EventName.twoFactorEnable:
        return 'two_factor_enable';
      case EventName.clickProfileSettingPage:
        return 'click_profile_settingpage';
      case EventName.profileUpdated:
        return 'profile_updated';
      case EventName.clickShowStatus:
        return 'click_show_status';
      case EventName.clickHidePhoneNumber:
        return 'click_hide_phone_number';
      case EventName.clickPasscode:
        return 'click_passcode';
      case EventName.clickUseTouchAndFaceId:
        return 'click_use_touch_and_face_id';
      case EventName.logOutSuccessfully:
        return 'log_out_successfully';
      case EventName.clickStickersSettingPage:
        return 'click_stickers_settingpage';
      case EventName.clickCoinsSettingPage:
        return 'click_coins_settingpage';
      case EventName.clickAccountsCenterPage:
        return 'click_accounts_centerpage';
      case EventName.clickAccountSettingPage:
        return 'click_account_settingpage';
      case EventName.accountDeactivationInitiated:
        return 'account_deactivation_initiated';
      case EventName.accountDeleted:
        return 'account_deleted';
      case EventName.clickChatAndCallSettingPage:
        return 'click_chat_and_call_settingpage';
      case EventName.clickAllowToAddFriend:
        return 'click_allow_to_add_friend';
      case EventName.clickHiddenAccount:
        return 'click_hidden_account';
      case EventName.clickBlockedAccount:
        return 'click_blocked_account';
      case EventName.clickHiddenChats:
        return 'click_hidden_chats';
      case EventName.clickAllowCall:
        return 'click_allow_call';
      case EventName.clickSettingsSettingPage:
        return 'click_settings_settingpage';
      case EventName.clickHelpCenter:
        return 'click_help_center';
      case EventName.receiveStateFromSocket:
        return 'receive_state_from_socket';
      case EventName.receiveStateFromFirebase:
        return 'receive_state_from_firebase';
      case EventName.processStateCompleted:
        return 'process_state_completed';
    }
  }

  EventCategory get category {
    switch (this) {
      case EventName.openApp:
      case EventName.pageViewed:
      case EventName.appErrorOccurred:
        return EventCategory.general;

      case EventName.clickAddFriendSearchPage:
      case EventName.clickInviteAddFriendPage:
      case EventName.clickShareInvite:
      case EventName.inviteShared:
      case EventName.clickCopyInvite:
      case EventName.inviteCopied:
      case EventName.clickQRCodeAddFriendPage:
      case EventName.clickMyQRCodePage:
      case EventName.clickShareMyQR:
      case EventName.myQRShared:
      case EventName.clickSaveMyQR:
      case EventName.myQRSaved:
      case EventName.qrCodeScanned:
      case EventName.clickAddFriendProfilePage:
      case EventName.acceptAddFriendProfilePage:
      case EventName.clickPhotoQRCodePage:
      case EventName.clickSearchAddFriendPage:
      case EventName.searchingUChatIdAddFriendPage:
      case EventName.inputPhoneNumberAddFriendPage:
      case EventName.clickTabRequestAddFriendPage:
      case EventName.clickAcceptAddFriendPage:
        return EventCategory.addFriend;

      case EventName.clickTabContactHomepage:
      case EventName.clickSearchContactHomepage:
      case EventName.searchingContact:
      case EventName.clickTabContactSearchPage:
      case EventName.clickSendMessageProfilePage:
      case EventName.clickVoiceCallProfilePage:
      case EventName.clickVideoCallProfilePage:
      case EventName.swipeContactPage:
      case EventName.swipeActionContactPage:
      case EventName.longPressContactPage:
      case EventName.clickLongPressAction:
      case EventName.clickContact:
        return EventCategory.contact;

      case EventName.clickGetStarted:
      case EventName.clickContinueSignUp:
      case EventName.inputEmail:
      case EventName.clickContinueEmail:
      case EventName.inputOtp:
      case EventName.clickResendOtp:
      case EventName.inputCreatePassword:
      case EventName.clickContinueCreatePassword:
      case EventName.inputConfirmPassword:
      case EventName.clickForgotPassword:
      case EventName.clickCountryPhoneNumber:
      case EventName.selectCountryPhoneNumber:
      case EventName.inputPhoneNumber:
      case EventName.clickContinuePhoneNumber:
      case EventName.clickAgreeTermAndCon:
      case EventName.inputCreateName:
      case EventName.clickContinueCreateName:
      case EventName.inputCreateUChatId:
      case EventName.clickContinueCreateUChatId:
      case EventName.uploadProfile:
      case EventName.registerCompleted:
        return EventCategory.loginRegister;

      case EventName.clickNewmessageChatlist:
      case EventName.chatOpened:
      case EventName.clickSendboxChatroom:
      case EventName.typingMessage:
      case EventName.messageSent:
      case EventName.resentMessage:
      case EventName.messageReceived:
      case EventName.messageRead:
      case EventName.chatErrorOccurred:
      case EventName.clickHamburgerChatlistpage:
      case EventName.clickEditChatlist:
      case EventName.chatlistEdited:
      case EventName.chatlistSorted:
      case EventName.chatlistCategory:
      case EventName.clickSearchboxChatlistpage:
      case EventName.clickClearSearchresult:
      case EventName.searchingChatlistpage:
      case EventName.clickSearchResultChatlist:
      case EventName.clickCreateGroup:
      case EventName.createGroupSuccessfully:
      case EventName.swipeChatlistpage:
      case EventName.clickMoreSwipeaction:
      case EventName.clickDelete:
      case EventName.longpressChatroom:
      case EventName.longpressActionChatroom:
      case EventName.messageCopied:
      case EventName.clickPinMessage:
      case EventName.clickUnpinMessage:
      case EventName.clickShareMessage:
      case EventName.messageShared:
      case EventName.messageReported:
      case EventName.messageUnsend:
      case EventName.messageDeleted:
      case EventName.clickStickerIcon:
      case EventName.clickGifIcon:
      case EventName.stickerSent:
      case EventName.clickPictureIcon:
      case EventName.clickAudioIcon:
      case EventName.clickPauseAudio:
      case EventName.clickContinueAudio:
      case EventName.clickCancelAudio:
      case EventName.clickAddIcon:
      case EventName.clickAddShareafile:
      case EventName.clickAddLocation:
      case EventName.clickAddContact:
      case EventName.contactShared:
      case EventName.clickCameraIcon:
      case EventName.clickContactinfo:
      case EventName.clickSearchRoomdetails:
      case EventName.searchingRoomdetails:
      case EventName.clickSearchresultRoomdetails:
      case EventName.clickMuteRoomdetails:
      case EventName.clickUnmuteRoomdetails:
      case EventName.clickEditNameRoomdetails:
      case EventName.editNameSuccessfully:
      case EventName.clickThemeRoomdetails:
      case EventName.changeThemeSuccessfully:
      case EventName.clickMediaRoomdetails:
      case EventName.clickFilesRoomdetails:
      case EventName.clickLinksRoomdetails:
      case EventName.clickAlbumRoomdetails:
      case EventName.clickSharecontactRoomdetails:
      case EventName.clickPinchatRoomdetails:
      case EventName.clickDeletechatRoomdetails:
      case EventName.clickBlockcontactRoomdetails:
      case EventName.clickReportRoomdetails:
      case EventName.contactReported:
      case EventName.longpressChatlist:
      case EventName.longpressActionChatlist:
      case EventName.clickUnblockcontactRoomdetails:
        return EventCategory.chatListChatRoom;
      case EventName.clickCallIcon:
      case EventName.clickVoiceCall:
      case EventName.clickVideoCall:
      case EventName.callStarted:
      case EventName.callConnected:
      case EventName.callFailed:
      case EventName.callDropped:
      case EventName.callEnded:
      case EventName.callSwitchedMode:
      case EventName.callAccepted:
        return EventCategory.call;
      case EventName.notificationOpened:
      case EventName.clickAcceptNotificationPage:
      case EventName.notificationUpdated:
        return EventCategory.notification;

      case EventName.clickStickerSettingPage:
      case EventName.clickCoinSettingPage:
      case EventName.clickSearchBarStickerStore:
      case EventName.searchingSticker:
      case EventName.clickStickerSearchResult:
      case EventName.stickerTabClicked:
      case EventName.stickerDetailViewed:
      case EventName.stickerDownloaded:
      case EventName.stickerPurchased:
      case EventName.stickerSentAsGift:
      case EventName.coinStoreViewed:
      case EventName.coinPackageSelected:
      case EventName.coinPurchaseInitiated:
      case EventName.coinPurchaseCompleted:
      case EventName.coinPurchaseFailed:
        return EventCategory.stickerAndCoin;
      case EventName.twoFactorEnable:
      case EventName.clickProfileSettingPage:
      case EventName.profileUpdated:
      case EventName.clickShowStatus:
      case EventName.clickHidePhoneNumber:
      case EventName.clickPasscode:
      case EventName.clickUseTouchAndFaceId:
      case EventName.logOutSuccessfully:
      case EventName.clickStickersSettingPage:
      case EventName.clickCoinsSettingPage:
      case EventName.clickAccountsCenterPage:
      case EventName.clickAccountSettingPage:
      case EventName.accountDeactivationInitiated:
      case EventName.accountDeleted:
      case EventName.clickChatAndCallSettingPage:
      case EventName.clickAllowToAddFriend:
      case EventName.clickHiddenAccount:
      case EventName.clickBlockedAccount:
      case EventName.clickHiddenChats:
      case EventName.clickAllowCall:
      case EventName.clickSettingsSettingPage:
      case EventName.clickHelpCenter:
        return EventCategory.setting;
      case EventName.receiveStateFromFirebase:
      case EventName.receiveStateFromSocket:
      case EventName.processStateCompleted:
        return EventCategory.statePerformanceTracking;

      default:
        return EventCategory.other;
    }
  }
}
