part of 'app_pages.dart';

abstract class Routes {
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const loginWithPhoneNumber = '/login/phone';
  static const loginWelcome = '/login/welcome';
  static const verifyOtpLogin = '/otp-login';
  static const verifyOtpRegister = '/otp-register';
  static const verifyOtpLinkEmail = '/otp-link-email';
  static const verifyOtpForgotPassword = '/otp-forgot-password';
  static const otpGetToResetPassword = '/otp/get';
  static const otpConfirm = '/otp/confirm';
  static const forgotPasswordSetupNewPassword = '/forgot/setup-new-password';
  static const forgotPasswordSetupNewPasswordConfirm = '/forgot/setup-new-password/confirm';
  static const forgotPasswordSetupSuccess = '/forgot/success';
  static const setNewPassword = '/set-new-password';
  static const setNewPasswordSuccess = '/set-new-password/success';
  static const twoFaOtpReceiptMethod = '/2fa-otp-receipt-method';
  static const twoFaOtpLoginReceiptMethod = '/2fa-otp-login-receipt-method';
  static const twoFaOtpLoginRequest = '/2fa-otp-login-request';
  static const twoFaOtpLoginVerify = '/2fa-otp-login-verify';

  static const linkAccountWithFacebook = '/link/facebook';
  static const linkAccountWithApple = '/link/apple';
  static const linkAccountWithGoogle = '/link/google';
  static const linkAccountWithEmail = '/link/email';

  static const createAccountName = '/register/createAccountName';
  static const createAccountSetPassword = '/register/createAccounSetPassword';
  static const createAccountConfirmPassword = '/register/createAccounConfirmPassword';
  static const createAccountUChatID = '/register/createAccounUChatID';
  static const createAccountProfileAvatar = '/register/createAccounProfileAvatar';

  static const home = '/home';
  static const callLog = '/call-log';
  static const logout = '/logout';
  static const passcode = '/passcode';
  static const passcodeToggle = '/passcode-toggle';
  static const loginWithEmail = '/login-by-email';
  static const loginPassword = '/login-password';

  static const groupInvite = '/group_invite';

  static const bookmarkCategory = '/bookmark/category';
  static const bookmarkTagList = '/bookmark/tag-list';

  static const addContact = '/add/contact';
  static const addContactSearch = '/add/contact/search';
  static const addContactByQr = '/add/contact/by-qr';
  static const addContactMyQr = '/add/contact/my-qr';
  static const callLogSelectScreen = '/call-log/select';

  static const contactAdd = '/contacts/add';
  static const contactAddByQr = '/contacts/add/by-qr';
  static const contactSelection = '/contacts/:id/selection';
  static const mobileContacts = '/contacts/:id/mobile';

  static const universalSearchMain = '/universal-search';
  static const searchAllContactResult = '/universal-search/all-contact-result';
  static const searchAllMessageResult = '/universal-search/all-message-result';
  static const universalSearchAllRoom = '/universal-search/all-room';
  static const universalSearchAllContact = '/universal-search/all-contact';
  static const universalSearchRoomMessages = '/universal-search/room-messages';
  static const contactsSearchScreen = '/search/all-contact';
  static const callLogSearchScreen = '/search/call-log';

  static const groupCreate = '/groups/create';
  static const groupCreateFinal = '/groups/create/final';
  static const groupProfilePicker = '/groups/create/profile-picker';

  static const myQrCode = '/my/qr-code';
  static const myProfile = '/my/profile/';
  static const settingMyProfile = '/my/profile/setting';

  static const photoViewer = '/photo-viewer';

  // new setup password
  static const setupPasswordNew = '/setup-password';
  static const setupPasswordNewConfirm = '/setup-password/confirm';

  static const profile = '/profile-detail/:type/:id';
  static const groupProfile = '/group-profile/:id';

  static const profileNickname = '/profile-edit/:id/nickname';
  static const profileStatusMessage = '/profile-edit/:id/status';

  static const roomsEdit = '/rooms/edit';

  ///TODO: change name and delete ^
  static const newEditRoom = '/rooms-v3/edit-room';

  static const roomsCreate = '/rooms/create';

  static const chatRoomRoot = '/chat-room';
  static const chatRoomBookmark = '$chatRoomRoot/bookmark/:id';
  static const chatRoomDirect = '$chatRoomRoot/direct/:id';
  static const chatRoomGroup = '$chatRoomRoot/group/:id';
  static const chatRoomSecret = '$chatRoomRoot/secret/:id';
  static const queueMonitorDashboard = '/queue-monitor-dashboard';
  static const chatRoomDirectBookmarkTag = '/room/:id/bookmark/tag';
  static const chatRoomDirectBookmarkTagSearch = '/room/:id/bookmark/tag/search';
  static const roomDetailDirect = '/room/:id/detail-direct';
  static const roomDetailGroup = '/room/:id/detail-group';
  static const roomDetail = '/room/:id/detail';
  static const roomDetailSearch = '/room/:id/detail/search';
  static const roomDetailEdit = '/room/:id/detail/edit';
  static const roomDetailSelectPhotoProfile = '/room/:id/detail/select/photo-profile';
  static const roomDetailMember = '/room/:id/detail/member';
  static const roomDetailMemberInvite = '/room/:id/detail/member/invite';
  static const roomDetailGroupEditName = '/room/:id/detail/edit-name';
  static const roomDetailEditTheme = '/room/:id/detail/edit-theme';
  static const roomDetailAdmin = '/room/:id/detail/admin';
  static const roomDetailOwnerTransfer = '/room/:id/detail/owner-transfer';
  static const roomDetailAdminAddSelect = '/room/:id/detail/admin/add-select';
  static const roomDetailAdminAdd = '/room/:id/detail/admin/add';
  static const roomDetailAdminEdit = '/room/:id/detail/admin/edit';
  static const roomDetailGroupPermissions = '/room/:id/detail/group-permissions';
  static const roomDetailGroupTypeSetting = '/room/:id/detail/group-type-setting';
  static const roomDetailGroupInviteLink = '/room/:id/detail/group-invite-link';
  static const roomDetailGroupInviteLinkSetting = '/room/:id/detail/group-invite-link/setting';
  static const roomDetailGroupInviteLinkQrCode = '/room/:id/detail/group-invite-link/qr-code';

  static const changeLockMessagePassword = '/room/:id/detail/change-lock-message-password';
  static const roomCall = '/room/:id/call';
  static const roomPhotoView = '/room/:id/photo-viewer';
  static const roomDetailAlbumList = '/room/:id/album-list';
  static const roomDetailAlbumCreate = '/room/:id/album/create';
  static const roomDetailAlbumCreateConfirm = '/room/:id/album/create-confirm';
  static const roomDetailAlbumRename = '/room/:id/album/rename';
  static const roomDetailAlbumImageList = '/room/:id/album/:albumId';
  static const roomDetailAlbumNotFound = '/room/:id/album-not-found';
  static const roomPhotosAndVideos = '/room/:id/photos-and-videos';
  static const roomPhotosAndVideosModal = '/room/:id/photos-and-videos-modal/:mediaName';
  static const addToAlbum = '/room/:id/add-to-album';
  static const roomStickerDetail = '/room/:id/sticker-detail/:stickerPackId';
  static const roomDetailMedia = '/room/:id/media';
  static const roomDetailFiles = '/room/:id/files';
  static const roomDetailLinks = '/room/:id/links';

  static const settingFriendChatCall = '/setting/friend-chat-call';
  static const setting = '/settings';
  static const settingChangeLanguage = '/settings/language';
  static const settingChat = '/settings/chat';
  static const settingChatAnimation = '/settings/chat/animation';
  static const settingChatSound = '/settings/chat/sound';
  static const settingChatHidden = '/settings/chat/hidden';
  static const settingDeleteAccount = '/delete-acc';
  static const settingFriend = '/settings/friend';
  static const settingFriendHidden = '/settings/friend/hidden';
  static const settingFriendBlock = '/settings/friend/block';
  static const settingPrivacyPasscode = '/settings/privacy/passcode';
  static const settingProfile = '/settings/profile';
  static const settingProfileDisplayName = '/settings/profile/display-name';
  static const settingProfileBirthdate = '/settings/profile/birthdate';
  static const settingProfileUsername = '/settings/profile/username';
  static const settingProfileStatusMessage = '/settings/profile/status-message';
  static const settingTroubleshoot = '/settings/troubleshoot';
  static const troubleshootEventMonitor = '/troubleshoot/event_monitor';
  static const settingTalker = '/settings/talker';
  static const settingDevicesManager = '/settings/devices-manager';
  static const settingNotification = '/settings/notification';
  static const settingCall = '/settings/call';
  static const settingHelpCenter = '/settings/help-center';
  static const settingPrivacyPolicy = '/settings/privacy-policy';
  static const settingTermsAndConditions = '/settings/terms-and-conditions';

  // Developer Tools Routes
  static const devTools = '/dev-tools';
  static const devToolsTroubleshoot = '/dev-tools/troubleshoot';
  static const devToolsTalker = '/dev-tools/talker';
  static const devToolsEventBusTracking = '/dev-tools/event-bus-tracking';
  static const devToolsEventMonitor = '/dev-tools/event-monitor';
  static const devToolsCacheManager = '/dev-tools/cache-manager';
  static const devToolsNotificationDebugger = '/dev-tools/notification-debugger';

  // Premium Package Routes
  static const settingPremiumPacksStore = '/settings/premium-packages-store';
  static const settingPremiumPacksCompareStore = '/settings/premium-packages-store/compare';
  static const settingPremiumPacksDetail = '/settings/premium-packages-store/detail';

  /// UChat Coins Routes
  static const coinStore = '/coin/store';
  static const coinHistory = '/coin/history';

  static const accountsCenter = '/accounts-center';
  static const accountSetting = '/accounts-center/account-setting';
  static const selectAccount = '/select-account';
  static const settingAccountPhoneNumber = '/settings/account/setting-phone-number';
  static const settingAccountPhoneNumberChange = '/settings/account/setting-phone-number/change';
  static const settingChangeFont = '/settings/change-font';
  static const settingPremiumPackage = '/settings/premium-package';

  static const settingAccountEmailV2 = '/settings/account/email';
  static const settingAccountEmailUnregistered = '/settings/account/email/unregistered';
  static const settingAccountEmailChange = '/settings/account/email/change';

  static const settingAccountValidatePassword = '/settings/account/validate-password';

  static const settingAccountUpdateAppleId = '/settings/account/apple-id';
  static const settingAccountUpdateFacebookAccount = '/settings/account/facebook-account';
  static const settingAccountUpdateGoogleAccount = '/settings/account/google-account';

  static const settingAccountChangePassword = '/settings/account/change-password';
  static const settingAccountCreateNewPassword = '/settings/account/create-new-password';
  static const settingAccountConfirmNewPassword = '/settings/account/confirm-new-password';
  static const settingAccountPromptSetPassword = '/settings/account/prompt-set-password';

  static const settingAccountOtpRequest = '/settings/account/otp-request';
  static const settingAccountOtpVerify = '/settings/account/otp-verify';
  static const settingAccountSentEmailForgotPassword = '/settings/account/sent-email-forgot-password';

  static const premiumCancel = '/premium/cancel-sub';

  static const secretChatSetting = '/room/:id/secret-chat-setting';
  static const secretChatSettingDuration = '/room/:id/secret-chat-setting/duration';

  static const stickerFavorite = '/sticker-setting/favorite';
  static const stickerSetting = '/sticker_setting';
  static const stickerSettingMySticker = '/sticker_setting/my_sticker';
  static const stickerSettingPurchaseHistory = '/sticker_setting/purchase_history';
  static const stickerSettingGift = '/sticker_setting/gift';
  static const stickerSettingEditMySticker = '/sticker_setting/edit_my_sticker';
  static const stickerSettingSection = '/sticker_setting_section';
  static const stickerStore = '/sticker_store';
  static const stickerDetail = '/sticker-detail/:stickerPackId';
  static const stickerGiftChooseFriend = '/sticker-gift/choose-friend';
  static const mySticker = '/my_sticker';
  static const aboutApp = '/settings/about-app';
  static const stickerSearch = '/sticker-search';

  static const formTextbox = '/form/textbox';
  static const map = '/map';

  static const mediaViewer = '/media-viewer';

  static const chatFolder = '/chat-folder';
  static const chatFolderEditList = '/chat-folder/edit-list';
  static const chatFolderCreate = '/chat-folder/create';
  static const chatFolderEditDetail = '/chat-folder/edit-detail/:id';
  static const chatFolderSelectRoom = '/chat-folder-select-room';

  static const myNote = '/my-note';
  static const subscriptionList = '/subscription-list';

  static const myProfileDesktop = '/my/profile/desktop';
  static const myProfilePhotosAndAlbumDesktop = '/my/profile/desktop/photos-and-album';
  static const myProfileEditProfileDesktop = '/my/profile/desktop/edit-profile';
  static const myProfileFilesDesktop = '/my/profile/desktop/files';

  static const takePhotoAndVideoPath = '/take-photo-and-video-path';
  static const notificationDebug = '/notification_debug';
  static const notificationDebugLogDetails = '/notification_debug/log_details';
  static const messageStateLogDetails = '/notification_debug/message_state_details';
}
