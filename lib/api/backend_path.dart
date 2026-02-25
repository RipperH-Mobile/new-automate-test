class BackendPath {
  /// AccountService
  static const getProfile = BackendPathModel(
    http: 'v3/my-profile',
    socket: 'v3.accounts.myProfile.get',
  );

  static const getProfileById = BackendPathModel(
    http: 'profile/:accountId',
    socket: 'account.getProfileById',
  );

  static const verifyUsername = BackendPathModel(
    http: 'my-profile/verify-username',
    socket: 'account.verifyUsername',
  );

  static const updateUsername = BackendPathModel(
    http: 'my-profile/updateUsername',
    socket: 'account.updateUsername',
  );

  static const updateProfile = BackendPathModel(
    http: 'v3/my-profile/update',
    socket: 'v3.account.profile.update',
  );

  static const updateAccountSetting = BackendPathModel(
    http: 'v3/my-profile/setting',
    socket: 'v3.accounts.setting.update',
  );

  static const uploadProfileImage = BackendPathModel(
    http: 'upload/avatar',
    socket: '',
  );

  static const uploadBackground = BackendPathModel(
    http: 'upload/background',
    socket: '',
  );

  static const deleteAccount = BackendPathModel(
    http: 'v3/users/settings/account',
    socket: 'v3.accounts.settings.account.delete',
  );

  static const getAllFriendLastSeen = BackendPathModel(
    http: 'my-friends/last-seen',
    socket: 'friend.friendLastSeenList',
  );

  static const updateOnlineStatus = BackendPathModel(
    http: 'v3/users/online-status',
    socket: 'v3.accounts.onlineStatus.update',
  );

  static const getSelfEncryptionKey = BackendPathModel(
    http: 'v2/users/encryption-key',
    socket: 'v2.accounts.encryptionKey.get',
  );

  // TODO Move this in to backend path of feature profile.
  static const getMyProfileMedia = BackendPathModel(
    http: 'v3/users/files',
    socket: 'v3.accounts.files.get',
  );

  static const checkEmailValid = BackendPathModel(
    http: 'v2/users/check-email-with-account',
    socket: 'v2.accounts.checkEmailAccount.post',
  );

  static const updateEmailOtpRequest = BackendPathModel(
    http: 'v2/users/otp/change-email',
    socket: 'v2.accounts.otpChangeEmail.post',
  );

  static const updateEmail = BackendPathModel(
    http: 'v2/users/email',
    socket: 'v2.accounts.email.update',
  );

  static const deleteEmail = BackendPathModel(
    http: 'v2/users/email',
    socket: 'v2.accounts.email.delete',
  );

  static const getCanChangePhoneNumber = BackendPathModel(
    http: 'v2/users/check-change-phone-number',
    socket: 'v2.accounts.checkChangePhoneNumber.post',
  );

  static const checkDuplicatePhoneNumber = BackendPathModel(
    http: 'v2/users/check-phone-number',
    socket: 'v2.accounts.checkPhoneNumber.post',
  );

  static const updatePhoneNumberOtpRequest = BackendPathModel(
    http: 'v2/users/otp/change-phone-number',
    socket: 'v2.accounts.otpChangePhoneNumber.post',
  );

  static const updatePhoneNumber = BackendPathModel(
    http: 'v2/users/phone-number',
    socket: 'v2.accounts.phoneNumber.update',
  );

  static const changePassword = BackendPathModel(
    http: 'v2/users/password',
    socket: 'v2.accounts.password.post',
  );

  static const enableMultiFactor = BackendPathModel(
    http: 'v2/my-profile/setting/multi-factor',
    socket: 'v2.accounts.enableMultiFactor.post',
  );

  static const authUserCheck = BackendPathModel(
    http: 'v3/auth/user/check',
    socket: '',
  );

  static const forgotPassword = BackendPathModel(
    http: 'v3/auth/forgot-password',
    socket: '',
  );

  static const getOtpMethodForgotPassword = BackendPathModel(
    http: 'v3/auth/forgot-password/request',
    socket: '',
  );

  static const getOtpForgotPassword = BackendPathModel(
    http: 'v3/auth/otp',
    socket: '',
  );

  static const verifyOtpForgotPassword = BackendPathModel(
    http: 'v3/auth/otp/verify',
    socket: '',
  );

  static const verifyTokenForgotPassword = BackendPathModel(
    http: 'v3/auth/forgot-password/verify',
    socket: '',
  );

  static const validateForgotPassword = BackendPathModel(
    http: 'v3/auth/forgot-password/validate-password',
    socket: '',
  );

  static const requestAuthentication = BackendPathModel(
    http: 'v2/users/multi-factor',
    socket: 'v2.accounts.multiFactor.post',
  );

  static const selectOtpType = BackendPathModel(
    http: 'v2/users/otp',
    socket: 'v2.accounts.otp.post',
  );

  static const verifyOtp = BackendPathModel(
    http: 'v2/users/otp/verify',
    socket: 'v2.accounts.otp.verify.post',
  );

  static const getAllSessions = BackendPathModel(
    http: 'v2/users/sessions',
    socket: 'v2.accounts.sessions.get',
  );

  static const deleteSessions = BackendPathModel(
    http: 'v2/users/sessions',
    socket: 'v2.accounts.sessions.delete',
  );

  static const linkAccountWithGoogleAccount = BackendPathModel(
    http: 'v2/users/gmail',
    socket: 'v2.accounts.gmail.update',
  );

  static const settingAccountLinkAccountWithGoogle = BackendPathModel(
    http: 'v3/users/settings/gmail',
    socket: 'v3.accounts.settings.gmail.put',
  );

  static const settingAccountUnlinkAccountWithGoogle = BackendPathModel(
    http: 'v3/users/settings/gmail',
    socket: 'v3.accounts.settings.gmail.delete',
  );

  static const settingAccountLinkAccountWithApple = BackendPathModel(
    http: 'v3/users/settings/apple',
    socket: 'v3.accounts.settings.apple.put',
  );

  static const settingAccountUnlinkAccountWithApple = BackendPathModel(
    http: 'v3/users/settings/apple',
    socket: 'v3.accounts.settings.apple.delete',
  );

  static const settingAccountLinkAccountWithFacebook = BackendPathModel(
    http: 'v3/users/settings/facebook',
    socket: 'v3.accounts.settings.facebook.put',
  );

  static const settingAccountUnlinkAccountWithFacebook = BackendPathModel(
    http: 'v3/users/settings/facebook',
    socket: 'v3.accounts.settings.facebook.delete',
  );

  static const unlinkAccountWithGoogleAccount = BackendPathModel(
    http: 'v2/users/gmail',
    socket: 'v2.accounts.gmail.delete',
  );

  static const signInByGoogleAccount = BackendPathModel(
    http: 'v2/auth/sign-in/gmail',
    socket: '',
  );

  static const linkAccountWithAppleId = BackendPathModel(
    http: 'v2/users/appleId',
    socket: 'v2.accounts.appleId.update',
  );

  static const unlinkAccountWithAppleId = BackendPathModel(
    http: 'v2/users/appleId',
    socket: 'v2.accounts.appleId.delete',
  );

  static const signInByFacebookAccount = BackendPathModel(
    http: 'v2/auth/sign-in/facebook',
    socket: '',
  );

  static const linkAccountWithFacebook = BackendPathModel(
    http: 'v2/users/facebook',
    socket: 'v2.accounts.facebook.update',
  );

  static const unlinkAccountWithFacebook = BackendPathModel(
    http: 'v2/users/facebook',
    socket: 'v2.accounts.facebook.delete',
  );

  static const signInByAppleId = BackendPathModel(
    http: 'v2/auth/sign-in/apple',
    socket: '',
  );

  /// AlbumService
  @Deprecated('Use createAlbumV3 instead')
  static const createAlbum = BackendPathModel(
    http: 'album',
    socket: 'album.createAlbum',
  );

  static const createAlbumV3 = BackendPathModel(
    http: 'v3/album',
    socket: 'v3.album.create.post',
  );

  @Deprecated('use uploadImageIntoAlbumV3 instead')
  static const uploadImageIntoAlbum = BackendPathModel(
    http: 'upload/album/:albumId/images',
    socket: '',
  );

  static const uploadImageIntoAlbumV3 = BackendPathModel(
    http: 'v3/upload/album/:albumId/images',
    socket: '',
  );

  @Deprecated('use updateAlbumNameV3 instead')
  static const updateAlbumName = BackendPathModel(
    http: 'album/:albumId/rename/',
    socket: 'album.updateAlbumName',
  );

  static const updateAlbumNameV3 = BackendPathModel(
    http: 'v3/album/:albumId/rename/',
    socket: 'v3.album.update.post',
  );

  @Deprecated('use updateAlbumNameV3 instead')
  static const deleteAlbum = BackendPathModel(
    http: 'album/:albumId',
    socket: 'album.deleteAlbum',
  );

  static const deleteAlbumV3 = BackendPathModel(
    http: 'v3/album/:albumId',
    socket: 'v3.album.delete',
  );

  @Deprecated('use deleteImageInAlbumV3 instead')
  static const deleteImageInAlbum = BackendPathModel(
    http: 'album/:albumId/image',
    socket: 'album.deleteImages',
  );

  static const deleteImageInAlbumV3 = BackendPathModel(
    http: 'v3/album/images',
    socket: 'v3.albums.images.delete',
  );

  @Deprecated('This feature is removed.')
  static const updateAlbumRoleMember = BackendPathModel(
    http: '',
    socket: 'album.updateAlbumRoleMember',
  );

  @Deprecated('use cancelUploadAlbumImageV3 instead')
  static const cancelUploadAlbumImage = BackendPathModel(
    http: 'album/:albumId/task',
    socket: 'album.cancelUploadImage',
  );

  static const cancelUploadAlbumImageV3 = BackendPathModel(
    http: 'v3/album/:albumId/task',
    socket: 'v3.album.task.delete',
  );

  @Deprecated('Use fetchImagesInAlbumV3 instead')
  static const fetchImagesInAlbum = BackendPathModel(
    http: 'album/:albumId/images',
    socket: 'album.imagesInAlbum',
  );

  static const fetchImagesInAlbumV3 = BackendPathModel(
    http: 'v3/album/:albumId/images',
    socket: 'v3.albums.images.get',
  );

  @Deprecated('Use fetchAlbumsV3 instead')
  static const fetchAlbums = BackendPathModel(
    http: 'chat-rooms/:roomId/albums',
    socket: 'album.getAlbums',
  );

  static const fetchAlbumsV3 = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/albums',
    socket: 'v3.albums.get',
  );

  static const shareImageFromAlbum = BackendPathModel(
    http: 'v3/album/images/share',
    socket: 'v3.albums.shareImages.post',
  );

  /// AnnouncementService
  static const getAvailableAnnouncement = BackendPathModel(
    http: 'v3/announcement/available',
    socket: 'announcement.getAvailableAnnouncement',
  );

  /// AppVersionService
  static const checkAppVersion = BackendPathModel(
    http: 'app-version/compare',
    socket: 'appVersion.compareAppVersion',
  );

  /// AuthService
  static const register = BackendPathModel(
    http: 'v2/upload/auth/sign-up',
    socket: '',
  );

  static const authVerifyOtp = BackendPathModel(
    http: 'v2/auth/otp/verify',
    socket: '',
  );

  static const verifyUChatId = BackendPathModel(
    http: 'auth/verify-username',
    socket: '',
  );

  static const logout = BackendPathModel(
    http: 'auth/logout',
    socket: 'account.logout',
  );

  static const verifyDebugPasscode = BackendPathModel(
    http: 'auth/passcode',
    socket: 'account.verifyDebugPasscode',
  );

  static const checkEmail = BackendPathModel(
    http: 'v2/users/check-email',
    socket: 'v2.accounts.checkEmail.post',
  );

  static const authSelectOtpType = BackendPathModel(
    http: 'v2/auth/otp',
    socket: '',
  );

  // There is no socket for this action, because preventing about 'exclusive-token'
  // Socket cannot sent it anyway
  // socket: 'v3.accounts.settings.otp.post',
  static const getOtpTwoFa = BackendPathModel(
    http: 'v3/users/settings/otp',
    socket: '',
  );

  static const verifyOtpTwoFa = BackendPathModel(
    http: 'v3/users/settings/otp/verify',
    socket: 'v3.accounts.settings.verifyOtp.post',
  );

  static const signIn = BackendPathModel(
    http: 'v2/auth/sign-in',
    socket: '',
  );

  static const officialAccountQRSignInVerifyToken = BackendPathModel(
    http: 'v2/official-accounts/validate-qr-token',
    socket: 'officialAccountProvider.validateQrToken',
  );

  static const authCodeVerifyToken = BackendPathModel(
    http: 'v3/auth/code/verify',
    socket: '',
  );

  static const accountSettingCheckPasswordRequire = BackendPathModel(
    http: 'v3/users/settings/password/require',
    socket: 'v3.accounts.settings.passwordRequire.check',
  );

  static const accountSettingVerifyPassword = BackendPathModel(
    http: 'v3/users/settings/password/verify',
    socket: 'v3.accounts.settings.verifyPassword.post',
  );

  static const accountSettingUpdateEmail = BackendPathModel(
    http: 'v3/users/settings/email',
    socket: 'v3.accounts.settings.email.post',
  );

  static const accountSettingValidateNewEmail = BackendPathModel(
    http: 'v3/users/settings/new-email/validate',
    socket: 'v3.accounts.settings.newEmail.check',
  );

  static const settingNewPasswordValidate = BackendPathModel(
    http: 'v3/users/settings/new-password/validate',
    socket: 'v3.accounts.settings.newPassword.check',
  );

  static const settingUpdateNewPassword = BackendPathModel(
    http: 'v3/users/settings/password',
    socket: 'v3.accounts.settings.password.post',
  );

  static const settingMultifactorValidate = BackendPathModel(
    http: 'v3/users/settings/multi-factor/validate',
    socket: 'v3.accounts.settings.updateMultiFactor.check',
  );

  static const settingMultifactorUpdate = BackendPathModel(
    http: 'v3/users/settings/multi-factor',
    socket: 'v3.accounts.settings.multiFactor.post',
  );

  /// CommonService
  static const getInfo = BackendPathModel(
    http: 'info',
    socket: '',
  );

  static const getPublicConfig = BackendPathModel(
    http: 'public/config',
    socket: '',
  );

  static const getFriendRequests = BackendPathModel(
    http: 'v3/new-friends',
    socket: 'v3.friends.pending.get',
  );

  static const getGroupInvites = BackendPathModel(
    http: 'v3/room-invited-list',
    socket: 'v3.rooms.invitedList.get',
  );

  static const getGroupRequests = BackendPathModel(
    http: 'v3/chat-rooms/members/requests',
    socket: 'v3.room.listMemberRequests.get',
  );

  static const approveGroupRequests = BackendPathModel(
    http: 'v3/chat-rooms/members/accept',
    socket: 'v3.rooms.member.accept.post',
  );

  static const rejectGroupRequests = BackendPathModel(
    http: 'v3/chat-rooms/members/reject',
    socket: 'v3.rooms.member.reject.post',
  );

  /// BookmarkService
  static const getBookmarkFiles = BackendPathModel(
    http: 'v2/chat-rooms/bookmark/category/files',
    socket: 'v2.bookmark.category.files.get',
  );

  static const getBookmarkMessages = BackendPathModel(
    http: 'v2/chat-rooms/bookmark/category/messages',
    socket: 'v2.bookmark.category.messages.get',
  );

  static const getBookmarkTags = BackendPathModel(
    http: 'v2/users/bookmark/tags/me',
    socket: 'v2.account.bookmarkTags.me.get',
  );

  static const deleteBookmarkTags = BackendPathModel(
    http: 'v2/users/bookmark/tags/me',
    socket: 'v2.account.bookmarkTags.me.delete',
  );

  static const setDefaultBookmarkTag = BackendPathModel(
    http: 'v2/users/bookmark/tags/default',
    socket: 'v2.account.bookmarkTags.default.put',
  );

  static const addTagToMessage = BackendPathModel(
    http: 'v2/messages/:messageId/tag',
    socket: 'v2.messages.tag',
  );

  static const addNewBookmarkTag = BackendPathModel(
    http: 'v2/users/bookmark/tags/me',
    socket: 'v2.account.bookmarkTags.me.post',
  );

  static const updateBookmarkTag = BackendPathModel(
    http: 'v2/users/bookmark/tags/me',
    socket: 'v2.account.bookmarkTags.me.put',
  );

  /// EmojiService
  static const getEmojiPackages = BackendPathModel(
    http: 'v3/emojis/me',
    socket: 'v3.emojis.me.get',
  );

  static const getMessageReact = BackendPathModel(
    http: 'v3/messages/:messageId/react',
    socket: 'v3.messages.react.get',
  );

  static const reactMessage = BackendPathModel(
    http: 'v3/messages/:messageId/react',
    socket: 'v3.messages.react',
  );

  static const setDefaultEmoji = BackendPathModel(
    http: 'v3/emojis/me/default',
    socket: 'v3.emojis.me.default.put',
  );

  /// GooglePlaceService
  static const placeTextSearch = BackendPathModel(
    http: 'map/textSearch',
    socket: 'map.textSearch',
  );

  /// LastSeenAtService
  static const updateLastSeenNotiAt = BackendPathModel(
    http: 'v3/users/notifications/last-seen',
    socket: 'v3.accounts.lastSeenNotificationAt.update',
  );

  /// MessageService
  static const getMessages = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages',
    socket: 'v3.messages.get',
  );

  static const sendMessage = BackendPathModel(
    http: 'v2/messages',
    socket: 'v2.messages.send',
  );

  static const uploadFile = BackendPathModel(
    http: 'v3/upload/room/:roomId/file',
    socket: '',
  );

  static const uploadFileConfirm = BackendPathModel(
    http: 'v2/upload/room/:roomId/confirm',
    socket: '',
  );

  static const uploadPro = BackendPathModel(
    http: 'file/upload/pro/urls',
    socket: '',
  );

  static const uploadProFinal = BackendPathModel(
    http: 'v3/file/upload/pro/finalize',
    socket: '',
  );

  static const uploadVideoThumbnail = BackendPathModel(
    http: 'v3/upload/room/:roomId/video/thumbnail',
    socket: '',
  );

  static const uploadFileThumbnail = BackendPathModel(
    http: 'v3/upload/room/:roomId/file/thumbnail',
    socket: '',
  );

  static const shareFile = BackendPathModel(
    http: 'v2/message/share-file',
    socket: '',
  );

  static const hideMessage = BackendPathModel(
    http: 'message/hide',
    socket: 'message.userHideMessage',
  );

  static const unhideMessage = BackendPathModel(
    http: 'message/unhide',
    socket: 'message.userUnHideMessage',
  );

  static const saveToBookmark = BackendPathModel(
    http: 'v2/messages/bookmark',
    socket: 'v2.messages.bookmark.post',
  );
  static const removeFromBookmark = BackendPathModel(
    http: 'v2/messages/bookmark',
    socket: 'v2.messages.bookmark.delete',
  );

  static const unsentMessage = BackendPathModel(
    http: 'v2/messages/:messageId/unsent',
    socket: 'v2.messages.unsent',
  );

  static const removeMessage = BackendPathModel(
    http: 'v2/messages/:messageId/remove',
    socket: 'v2.messages.remove',
  );

  static const editMessage = BackendPathModel(
    http: 'v3/messages/:messageId',
    socket: 'v3.messages.update',
  );

  static const pinMessage = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages/pin',
    socket: 'v3.room.pinMessage.post',
  );

  static const unpinMessage = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages/unpin',
    socket: 'v3.room.unpinMessage.post',
  );

  static const unpinAllMessages = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages/unpin-all',
    socket: 'v3.room.unpinAllMessage.post',
  );

  static const getPinMessages = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages/pin',
    socket: 'v3.room.pinMessage.get',
  );

  static const searchMessageInRoom = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/messages/search',
    socket: 'v3.messages.searchMessageInRoom',
  );

  static const searchUniversal = BackendPathModel(
    http: 'v2/search-messages',
    socket: 'v2.messages.search',
  );

  /// CentralNotificationService
  static const deleteNoti = BackendPathModel(
    http: 'v2/notifications',
    socket: 'v2.notifications.delete',
  );

  static const getNotiList = BackendPathModel(
    http: 'v3/notifications',
    socket: 'v3.notifications.get',
  );

  /// OfficialAccountService
  static const getMenu = BackendPathModel(
    http: 'oa/:officialAccountId/publish-menu',
    socket: 'officialAccount.getPublishMenu',
  );

  static const subscribeOA = BackendPathModel(
    http: '',
    socket: 'officialAccount.subscribe',
  );

  static const unsubscribeOA = BackendPathModel(
    http: '',
    socket: 'officialAccount.unsubscribe',
  );

  /// RoomCallService
  static const startCall = BackendPathModel(
    http: 'v2/room-calls',
    socket: 'v2.roomCalls.create',
  );

  static const ringingCall = BackendPathModel(
    http: 'v2/room-calls/:roomCallId/ringing',
    socket: 'v2.roomCalls.ringing',
  );

  static const acceptCall = BackendPathModel(
    http: 'v2/room-calls/:roomCallId/accept',
    socket: 'v2.roomCalls.accept',
  );

  static const declineCall = BackendPathModel(
    http: 'v2/room-calls/:roomCallId/decline',
    socket: 'v2.roomCalls.decline',
  );

  static const timeoutCall = BackendPathModel(
    http: 'v2/room-calls/:roomCallId/timeout',
    socket: 'v2.roomCalls.timeout',
  );

  static const resetRoomCall = BackendPathModel(
    http: 'v2/room-calls/reset',
    socket: '',
  );

  static const availableRoomCall = BackendPathModel(
    http: 'v2/room-calls/available',
    socket: 'liveKit.checkCallRoomAvailable',
  );

  static const joinGroupCall = BackendPathModel(
    http: 'v2/room-calls/group/:roomId/join',
    socket: 'v2.roomCalls.group.join',
  );

  static const leaveGroupCall = BackendPathModel(
    http: 'v2/room-calls/group/:roomId/leave',
    socket: 'v2.roomCalls.group.leave',
  );

  /// RoomService
  static const deleteRoom = BackendPathModel(
    http: 'chat-rooms/:roomId',
    socket: 'room.deleteRoom',
  );

  static const deleteRoomWithCountdown = BackendPathModel(
    http: 'v3/chat-rooms',
    socket: 'v3.rooms.delete',
  );

  static const undoDeleteRoomWithCountdown = BackendPathModel(
    http: 'v3/chat-rooms/undo',
    socket: 'v3.rooms.undo.delete',
  );

  static const triggerReadMessage = BackendPathModel(
    http: 'chat-rooms/:roomId/messages/read',
    socket: 'room.readMessageInRoom',
  );

  static const openDirectChat = BackendPathModel(
    http: 'open-chat/direct',
    socket: 'room.openDirectChatRoom',
  );

  static const openSystemChat = BackendPathModel(
    http: 'v3/open-chat/system',
    socket: 'v3.room.system.post',
  );

  static const openBookmarkChat = BackendPathModel(
    http: 'v2/open-chat/bookmark',
    socket: 'v2.rooms.bookmark.post',
  );

  static const createGroupChat = BackendPathModel(
    http: 'v2/upload/open-chat/group',
    socket: '',
  );

  static const addMemberToChat = BackendPathModel(
    http: 'open-chat/group/add',
    socket: 'room.addFriendInGroupRoom',
  );

  static const removeMemberFromChat = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/remove-member',
    socket: 'room.removeFriendInGroupRoom',
  );

  static const leaveGroup = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/leave',
    socket: 'v3.rooms.leave.post',
  );

  static const togglePinRoom = BackendPathModel(
    http: 'chat-rooms/togglePin',
    socket: 'roomSubscription.togglePinRoom',
  );

  static const toggleMuteRoom = BackendPathModel(
    http: 'chat-rooms/toggleMute',
    socket: 'roomSubscription.toggleMuteRoom',
  );

  static const toggleChatCategory = BackendPathModel(
    http: 'v3/my-profile/setting',
    socket: 'v3.accounts.setting.update',
  );

  static const toggleHideRoom = BackendPathModel(
    http: 'v3/chat-rooms/toggleHide',
    socket: 'v3.roomSubscription.hide.post',
  );

  static const changeRoomName = BackendPathModel(
    http: 'v3/chat-rooms/group/set/name',
    socket: 'room.changeGroupName',
  );

  static const changeRoomPhoto = BackendPathModel(
    http: 'upload/open-chat/group/:roomId/set/photo',
    socket: '',
  );

  static const fetchRoomPhotoAndVideo = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/images-videos',
    socket: 'v3.roomFiles.ImagesAndVideos.get',
  );

  static const fetchRoomFiles = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/file',
    socket: 'roomFile.getRoomFileV3',
  );

  static const findGroup = BackendPathModel(
    http: 'find-group',
    socket: 'room.findGroup',
  );

  static const joinGroup = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/join-group',
    socket: 'v3.room.join.post',
  );

  static const updateAdmins = BackendPathModel(
    http: 'chat-rooms/updateAdmins',
    socket: 'room.updateAdmins',
  );

  static const acceptGroupMemberRequest = BackendPathModel(
    http: 'chat-rooms/acceptMember',
    socket: 'room.acceptMemberInMemberRequestList',
  );

  static const rejectGroupMemberRequest = BackendPathModel(
    http: 'chat-rooms/rejectMember',
    socket: 'room.rejectMemberInMemberRequestList',
  );

  static const changeGroupOwner = BackendPathModel(
    http: 'chat-rooms/:roomId/change-owner',
    socket: 'v3.room.changeOwner.post',
  );

  static const getGroupMemberRequestList = BackendPathModel(
    http: 'chat-rooms/getMemberRequestList',
    socket: 'room.getMemberRequestList',
  );

  static const getRoomLinks = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/links',
    socket: 'v3.rooms.links.get',
  );

  static const getSessionsList = BackendPathModel(
    http: 'v3/users/settings/sessions',
    socket: 'v3.accounts.settings.sessions.get',
  );

  static const deleteSession = BackendPathModel(
    http: 'v3/users/settings/session',
    socket: 'v3.accounts.settings.session.delete',
  );

  static const deleteSessionsList = BackendPathModel(
    http: 'v3/users/settings/sessions',
    socket: 'v3.accounts.settings.sessions.delete',
  );

  static const changeGroupAccessType = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/change-access-type',
    socket: 'v3.rooms.changeAccessType.post',
  );

  static const getDraftMenu = BackendPathModel(
    http: 'chat-rooms/group/getDraftMenu',
    socket: 'room.getDraftMenu',
  );

  static const updateMenu = BackendPathModel(
    http: 'chat-rooms/group/updateMenu',
    socket: 'room.updateMenu',
  );

  static const publishMenu = BackendPathModel(
    http: 'chat-rooms/group/publishMenu',
    socket: 'room.publishMenu',
  );

  static const unpublishMenu = BackendPathModel(
    http: 'chat-rooms/group/unpublishMenu',
    socket: 'room.unpublishMenu',
  );

  static const liveKitUnreachableCall = BackendPathModel(
    http: 'livekit/:roomId/call/unreach',
    socket: 'liveKit.unreachRoomCall',
  );

  static const resetCallStatus = BackendPathModel(
    http: 'livekit/resetCallStatus',
    socket: '',
  );

  static const isCallStillAvailable = BackendPathModel(
    http: 'livekit/:roomId/call/check',
    socket: 'liveKit.checkCallRoomAvailable',
  );

  static const acceptRoomInvite = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/room-invited/accept',
    socket: 'room.acceptRoomInvited',
  );

  static const rejectRoomInvite = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/room-invited/reject',
    socket: 'room.rejectRoomInvited',
  );

  static const getMyChatRoom = BackendPathModel(
    http: 'v3/chat-rooms/:roomId',
    socket: 'room.myChatRoom',
  );

  static const getRoomInviteList = BackendPathModel(
    http: 'v3/chat-rooms/room-invited',
    socket: 'room.getRoomInvitedList',
  );

  static const getRoomOwnByMe = BackendPathModel(
    http: 'chat-rooms/owner',
    socket: 'room.myOwnerRooms',
  );

  static const createSecretRoom = BackendPathModel(
    http: 'chat-rooms/secret',
    socket: 'room.createSecretChatRoom',
  );

  static const getEncryptionKey = BackendPathModel(
    http: 'encryption-key/:roomId',
    socket: 'encryptionKey.requestEncryptionKey',
  );

  static const updateSecretRoomExpiredAt = BackendPathModel(
    http: 'v2/chat-rooms/secret/:roomId/expiration',
    socket: 'v2.rooms.secret.expiration.update',
  );

  static const updateLastTypedAt = BackendPathModel(
    http: '',
    socket: 'roomSubscription.updateLastTypedAt',
  );

  static const checkIsOwner = BackendPathModel(
    http: 'v3/chat-rooms/is-owner',
    socket: 'v3.rooms.isOwner.get',
  );

  static const leaveGroupWithMeAsAnOwner = BackendPathModel(
    http: 'v3/users/settings/leave-owner-room',
    socket: 'v3.accounts.settings.leaveOwnerRoom.post',
  );

  static const fetchChatRoom = BackendPathModel(
    http: 'chat-rooms/:roomId',
    socket: 'room.myChatRoom',
  );

  static const fetchDefaultGroupAvatar = BackendPathModel(
    http: 'room/getDefaultGroupAvatar',
    socket: 'room.getDefaultGroupAvatar',
  );

  static const setDefaultGroupAvatar = BackendPathModel(
    http: 'chat-rooms/group/set/photo/default',
    socket: 'room.setDefaultGroupPhoto',
  );

  static const openSupportTicket = BackendPathModel(
    http: 'support-ticket/open',
    socket: 'supportTicket.openTicket',
  );

  static const toggleHideMessageNotification = BackendPathModel(
    http: 'chat-rooms/toggleHideMessageNotification',
    socket: 'roomSubscription.toggleHideMessageNotification',
  );

  static const toggleMuteCallNotification = BackendPathModel(
    http: 'chat-rooms/toggleMuteCall',
    socket: 'roomSubscription.toggleMuteCall',
  );

  static const getAllRoomLastSeen = BackendPathModel(
    http: 'chat-rooms/last-seen',
    socket: 'room.roomLastSeenList',
  );

  static const getRoomEncryptionKey = BackendPathModel(
    http: 'v2/chat-rooms/:roomId/encryption-key',
    socket: 'v2.rooms.encryptionKey.get',
  );

  static const getMembersInRoom = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/members',
    socket: 'v3.rooms.members.get',
  );

  static const endSecretChat = BackendPathModel(
    http: 'v2/chat-rooms/secret/:roomId',
    socket: 'v2.rooms.secret.delete',
  );

  static const toggleShowExpiredDate = BackendPathModel(
    http: 'v2/chat-rooms/secret/toggleShowExpireTime',
    socket: 'v2.roomSubscriptions.toggleShowExpireTime.update',
  );

  static const notifyCaptureScreenInSecretChat = BackendPathModel(
    http: 'v2/chat-rooms/:roomId/capture-screen',
    socket: 'v2.rooms.captureScreen.post',
  );

  static const setLockMessagePassword = BackendPathModel(
    http: 'v2/chat-rooms/:roomId/locked-message-password',
    socket: 'roomSubscription.setPasswordForLockedMessageInRoom',
  );

  static const sendReview = BackendPathModel(
    http: 'v2/premium-package/review',
    socket: 'v2.premiumPackage.review.post',
  );

  //TODO: Don't need for now
  static const getPremiumPackageById = BackendPathModel(
    http: '',
    socket: '',
  );

  static const getAllPremiumPackage = BackendPathModel(
    http: 'v2/premium-package',
    socket: 'v2.premiumPackage.get',
  );

  static const sendRemindMeLater = BackendPathModel(
    http: 'v2/premium-package/review',
    socket: 'v2.premiumPackage.review.put',
  );

  static const sendReasonForCancel = BackendPathModel(
    http: 'v2/premium-package/reason-cancel',
    socket: 'v2.premiumPackage.reasonCancel.post',
  );

  static const checkIOSReceiptSubscription = BackendPathModel(
    http: '/store-hook/check-is-active-subscription-from-app-receipt',
    socket: 'v2.storeHook.isActiveSubscriptionFromAppReceipt.post',
  );

  ///V3 edit room
  static const readAllRoom = BackendPathModel(
    http: 'v3/chat-rooms/messages/read-all',
    socket: 'v3.rooms.messages.readAll.post',
  );

  static const unsendMessageV3 = BackendPathModel(
    http: 'v3/messages/unsend',
    socket: 'v3.messages.unsend.post',
  );

  static const removeMessageV3 = BackendPathModel(
    http: 'v3/messages',
    socket: 'v3.messages.delete',
  );

  static const removeOtherMessageV3 = BackendPathModel(
    http: 'v3/messages/remove-for-others',
    socket: 'v3.messages.deleteMessageForOthers.delete',
  );

  static const fetchRoomDetailMediaCount = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/count-media',
    socket: 'v3.rooms.countOfMedia.get',
  );

  static const getRoomMemberAndPendingList = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/members-and-pending',
    socket: 'v3.rooms.membersAndPending.get',
  );

  static const removeRoomDetailInvite = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/room-invited/remove',
    socket: 'v3.rooms.removeRoomInvited.post',
  );

  static const inviteMemberToGroup = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/invite-member',
    socket: 'v3.rooms.inviteFriends.post',
  );

  static const setRoomTheme = BackendPathModel(
    http: 'v3/chat-rooms/theme',
    socket: 'v3.rooms.theme.put',
  );

  static const getCallLogs = BackendPathModel(
    http: 'v3/room-calls/call-logs-by-accountIds',
    socket: 'v3.roomCalls.logs.byAccountIds.get',
  );

  static const deleteCallLogs = BackendPathModel(
    http: 'v3/room-calls/call-logs',
    socket: 'v3.roomCalls.logs.delete',
  );

  static const addGroupAdmin = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/admin/assign',
    socket: 'v3.roomSubscription.assignAdmin.post',
  );

  static const editGroupAdmin = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/admin/:accountId',
    socket: 'v3.roomSubscription.updateAdminPermissions.put',
  );

  static const removeGroupAdmin = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/admin/:accountId',
    socket: 'v3.roomSubscription.revokeAdmin.delete',
  );

  static const getGroupPermission = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/permissions',
    socket: 'v3.room.permissions.get',
  );

  static const updateGroupPermission = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/permissions',
    socket: 'v3.room.permissions.put',
  );

  static const updateRoomInviteLink = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/invite-link',
    socket: 'v3.rooms.inviteLink.put',
  );

  static const revokeRoomInviteLink = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/revoke-link',
    socket: 'v3.rooms.revokeLink.post',
  );

  static const getRoomInviteLink = BackendPathModel(
    http: 'v3/chat-rooms/:roomId/invite-link',
    socket: 'v3.rooms.inviteLink.get',
  );

  static const verifyInviteLink = BackendPathModel(
    http: 'v3/chat-rooms/invite-link/verify',
    socket: 'v3.rooms.verifyInviteLink.post',
  );

  static const getRecentSearchList = BackendPathModel(
    http: 'v3/users/recent-search',
    socket: 'v3.accounts.recentSearch.get',
  );

  static const saveRecentSearchResult = BackendPathModel(
    http: 'v3/users/recent-search',
    socket: 'v3.accounts.recentSearch.post',
  );

  static const removeRecentSearchResult = BackendPathModel(
    http: 'v3/users/recent-search/:recentSearchId',
    socket: 'v3.accounts.recentSearch.deleteById.delete',
  );

  static const clearAllRecentSearchResult = BackendPathModel(
    http: 'v3/users/recent-search',
    socket: 'v3.accounts.recentSearch.delete',
  );

  static const getOaRichMenu = BackendPathModel(
    http: 'v3/oa/:officialAccountId/rich-menu',
    socket: 'v3.oa.richMenu.get',
  );
}

class BackendPathModel {
  final String _http;
  final String _socket;

  const BackendPathModel({
    required String http,
    required String socket,
  })  : _http = http,
        _socket = socket;

  String get http {
    return _http;
  }

  String get socket {
    return _socket;
  }
}
