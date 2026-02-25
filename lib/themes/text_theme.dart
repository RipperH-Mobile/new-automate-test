import 'package:flutter/material.dart';

class UChatTextTheme {
  final TextStyle strong;
  final TextStyle messageTitle;
  final TextStyle messageStatus;
  final TextStyle messageUnreadCount;
  final TextStyle appBarTitle;
  final TextStyle appBarSubTitle;
  final TextStyle appBarAction;
  final TextStyle topSheetTitle;
  final TextStyle topSheetMenu;
  final TextStyle bottomSheetMenu;
  final TextStyle bottomSheetOptionsTitle;
  final TextStyle bottomSheetOptionsSubtitle;
  final TextStyle bottomSheetOptionsItem;
  final TextStyle optionsDialogTitle;
  final TextStyle optionsDialogMenu;
  final TextStyle input;
  final TextStyle inputLabel;
  final TextStyle inputHint;
  final TextStyle chatInput;
  final TextStyle chatInputDisabled;
  final TextStyle chatMessageStatus;
  final TextStyle chatMessageLinkStyle;
  final TextStyle chatMessageStyle;
  final TextStyle chatMessagePopupMenu;
  final TextStyle chatPlatformPopupMenu;
  final TextStyle chatSenderName;
  final TextStyle chatLinkPreviewTitle;
  final TextStyle chatLinkPreviewDesc;
  final TextStyle chatDateHeader;
  final TextStyle chatSystemMessage;
  final TextStyle chatFileMessageTitle;
  final TextStyle chatFileMessageDesc;
  final TextStyle emoji;
  final TextStyle gifCancelSearch;
  final TextStyle gifSearchInput;
  final TextStyle gifSearchInputHint;
  final TextStyle profileName;
  final TextStyle profileStatusMessage;
  final TextStyle profileRoomMemberPlus;
  final TextStyle profileRoomMemberTitle;
  final TextStyle profileInfoTitle;
  final TextStyle roomInfoItemLabel;
  final TextStyle roomInfoItemValue;
  final TextStyle buttonTitle;
  final TextStyle buttonLabel;
  final TextStyle roomDetailTitle;
  final TextStyle roomDetailSubtitle;
  final TextStyle roomDetailActionButtonLabel;
  final TextStyle roomDetailMemberTitle;
  final TextStyle roomDetailMemberUsername;
  final TextStyle listLabel;
  final TextStyle settingItemTitle;
  final TextStyle settingItemValue;
  final TextStyle settingAppVersion;
  final TextStyle settingAppVersionNumber;
  final TextStyle contactRequestSection;
  final TextStyle contactItemType;
  final TextStyle contactItemTitle;
  final TextStyle contactItemSubtitle;
  final TextStyle pageTitle;
  final TextStyle pageSubtitle;
  final TextStyle pageSecondSubtitle;
  final TextStyle pageBottomTitle;
  final TextStyle inputCounter;
  final TextStyle formOriginalValueTitle;
  final TextStyle formOriginalValue;
  final TextStyle formDescription;

  const UChatTextTheme.raw({
    required this.strong,
    required this.messageTitle,
    required this.messageStatus,
    required this.messageUnreadCount,
    required this.appBarTitle,
    required this.appBarSubTitle,
    required this.appBarAction,
    required this.topSheetTitle,
    required this.topSheetMenu,
    required this.bottomSheetMenu,
    required this.bottomSheetOptionsTitle,
    required this.bottomSheetOptionsSubtitle,
    required this.bottomSheetOptionsItem,
    required this.optionsDialogTitle,
    required this.optionsDialogMenu,
    required this.input,
    required this.inputLabel,
    required this.inputHint,
    required this.chatInput,
    required this.chatInputDisabled,
    required this.chatMessageStatus,
    required this.chatMessageLinkStyle,
    required this.chatMessageStyle,
    required this.chatMessagePopupMenu,
    required this.chatPlatformPopupMenu,
    required this.chatSenderName,
    required this.chatLinkPreviewTitle,
    required this.chatLinkPreviewDesc,
    required this.chatDateHeader,
    required this.chatSystemMessage,
    required this.chatFileMessageTitle,
    required this.chatFileMessageDesc,
    required this.emoji,
    required this.gifCancelSearch,
    required this.gifSearchInput,
    required this.gifSearchInputHint,
    required this.profileName,
    required this.profileStatusMessage,
    required this.profileRoomMemberPlus,
    required this.profileRoomMemberTitle,
    required this.profileInfoTitle,
    required this.roomInfoItemLabel,
    required this.roomInfoItemValue,
    required this.buttonTitle,
    required this.buttonLabel,
    required this.roomDetailTitle,
    required this.roomDetailSubtitle,
    required this.roomDetailActionButtonLabel,
    required this.roomDetailMemberTitle,
    required this.roomDetailMemberUsername,
    required this.listLabel,
    required this.settingItemTitle,
    required this.settingItemValue,
    required this.settingAppVersion,
    required this.settingAppVersionNumber,
    required this.contactRequestSection,
    required this.contactItemType,
    required this.contactItemTitle,
    required this.contactItemSubtitle,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.pageSecondSubtitle,
    required this.pageBottomTitle,
    required this.inputCounter,
    required this.formOriginalValueTitle,
    required this.formOriginalValue,
    required this.formDescription,
  });

  factory UChatTextTheme({
    TextStyle? strong,
    TextStyle? messageTitle,
    TextStyle? messageStatus,
    TextStyle? messageUnreadCount,
    TextStyle? appBarTitle,
    TextStyle? appBarSubTitle,
    TextStyle? appBarAction,
    TextStyle? topSheetTitle,
    TextStyle? topSheetMenu,
    TextStyle? bottomSheetMenu,
    TextStyle? bottomSheetOptionsTitle,
    TextStyle? bottomSheetOptionsSubtitle,
    TextStyle? bottomSheetOptionsItem,
    TextStyle? optionsDialogTitle,
    TextStyle? optionsDialogMenu,
    TextStyle? input,
    TextStyle? inputLabel,
    TextStyle? inputHint,
    TextStyle? chatInput,
    TextStyle? chatInputDisabled,
    TextStyle? chatMessageStatus,
    TextStyle? chatMessageLinkStyle,
    TextStyle? chatMessageStyle,
    TextStyle? chatMessagePopupMenu,
    TextStyle? chatPlatformPopupMenu,
    TextStyle? chatSenderName,
    TextStyle? chatLinkPreviewTitle,
    TextStyle? chatLinkPreviewDesc,
    TextStyle? chatDateHeader,
    TextStyle? chatSystemMessage,
    TextStyle? chatFileMessageTitle,
    TextStyle? chatFileMessageDesc,
    TextStyle? emoji,
    TextStyle? gifCancelSearch,
    TextStyle? gifSearchInput,
    TextStyle? gifSearchInputHint,
    TextStyle? profileName,
    TextStyle? profileStatusMessage,
    TextStyle? profileRoomMemberPlus,
    TextStyle? profileRoomMemberTitle,
    TextStyle? profileInfoTitle,
    TextStyle? roomInfoItemLabel,
    TextStyle? roomInfoItemValue,
    TextStyle? buttonTitle,
    TextStyle? buttonLabel,
    TextStyle? roomDetailTitle,
    TextStyle? roomDetailSubtitle,
    TextStyle? roomDetailActionButtonLabel,
    TextStyle? roomDetailMemberTitle,
    TextStyle? roomDetailMemberUsername,
    TextStyle? listLabel,
    TextStyle? settingItemTitle,
    TextStyle? settingItemValue,
    TextStyle? settingAppVersion,
    TextStyle? settingAppVersionNumber,
    TextStyle? contactRequestSection,
    TextStyle? contactItemType,
    TextStyle? contactItemTitle,
    TextStyle? contactItemSubtitle,
    TextStyle? pageTitle,
    TextStyle? pageSubtitle,
    TextStyle? pageSecondSubtitle,
    TextStyle? pageBottomTitle,
    TextStyle? inputCounter,
    TextStyle? formOriginalValueTitle,
    TextStyle? formOriginalValue,
    TextStyle? formDescription,
  }) {
    strong ??= const TextStyle(fontWeight: FontWeight.w500);
    messageTitle ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    messageStatus ??= const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );
    messageUnreadCount ??= const TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
    appBarTitle ??= const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
    appBarSubTitle ??= const TextStyle(fontWeight: FontWeight.w100, fontSize: 10);
    appBarAction ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    topSheetTitle ??= const TextStyle(fontWeight: FontWeight.w500, fontSize: 17);
    bottomSheetMenu ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    bottomSheetOptionsTitle ??= const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    bottomSheetOptionsSubtitle ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    bottomSheetOptionsItem ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    topSheetMenu ??= const TextStyle(fontSize: 12);
    optionsDialogTitle ??= const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    optionsDialogMenu ??= const TextStyle(fontSize: 16);
    input = const TextStyle(fontSize: 16);
    inputLabel = const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0);
    inputHint = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    chatInput = const TextStyle(
      fontSize: 15.0,
      height: 1.3,
      fontWeight: FontWeight.w500,
    );
    chatInputDisabled ??= const TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
    chatMessageStatus ??= const TextStyle(fontWeight: FontWeight.w500, fontSize: 10);
    chatMessageLinkStyle ??= const TextStyle(decoration: TextDecoration.underline);
    chatMessageStyle ??= const TextStyle(height: 1.5, fontSize: 16);
    chatMessagePopupMenu ??= const TextStyle(height: 1, fontSize: 12);
    chatPlatformPopupMenu ??= const TextStyle(
      height: 1,
      fontSize: 14,
    );
    chatSenderName ??= const TextStyle(fontWeight: FontWeight.w500, fontSize: 10);
    chatLinkPreviewTitle ??= const TextStyle(fontWeight: FontWeight.bold);
    chatLinkPreviewDesc ??= const TextStyle(fontWeight: FontWeight.w500);
    chatDateHeader ??= const TextStyle(fontWeight: FontWeight.bold, fontSize: 11);
    chatSystemMessage ??= const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );
    chatFileMessageTitle ??= const TextStyle(
      height: 1,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    chatFileMessageDesc ??= const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
    emoji ??= const TextStyle(fontSize: 24);
    gifCancelSearch ??= const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0);
    gifSearchInput ??= const TextStyle(
      fontSize: 16,
      height: 1.4,
      fontWeight: FontWeight.w500,
    );
    gifSearchInputHint ??= const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    profileName = const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    profileStatusMessage ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    profileRoomMemberPlus ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    profileRoomMemberTitle ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    profileInfoTitle ??= const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    roomInfoItemLabel ??= const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    roomInfoItemValue ??= const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    buttonTitle ??= const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    buttonLabel ??= const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    roomDetailTitle ??= const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
    roomDetailSubtitle ??= const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    roomDetailActionButtonLabel ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    roomDetailMemberTitle ??= const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
    );
    roomDetailMemberUsername ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    listLabel ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    settingItemTitle ??= const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    settingItemValue ??= const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    settingAppVersion ??= const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    settingAppVersionNumber ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    contactRequestSection ??= const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black,
    );
    contactItemType ??= const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    contactItemTitle ??= const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
    );
    contactItemSubtitle ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    pageTitle ??= const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    pageSubtitle ??= const TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: Color(0xFF666666),
    );
    pageSecondSubtitle ??= const TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: Color(0xFF666666),
    );
    pageBottomTitle ??= const TextStyle(
      fontSize: 13,
      height: 1.5,
      fontWeight: FontWeight.w500,
    );
    inputCounter ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    formOriginalValueTitle ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    formOriginalValue ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    formDescription ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    return UChatTextTheme.raw(
      strong: strong,
      messageTitle: messageTitle,
      messageUnreadCount: messageUnreadCount,
      messageStatus: messageStatus,
      appBarTitle: appBarTitle,
      appBarSubTitle: appBarSubTitle,
      appBarAction: appBarAction,
      topSheetTitle: topSheetTitle,
      topSheetMenu: topSheetMenu,
      bottomSheetMenu: bottomSheetMenu,
      bottomSheetOptionsTitle: bottomSheetOptionsTitle,
      bottomSheetOptionsSubtitle: bottomSheetOptionsSubtitle,
      bottomSheetOptionsItem: bottomSheetOptionsItem,
      optionsDialogTitle: optionsDialogTitle,
      optionsDialogMenu: optionsDialogMenu,
      input: input,
      inputLabel: inputLabel,
      inputHint: inputHint,
      chatInputDisabled: chatInputDisabled,
      chatMessageStatus: chatMessageStatus,
      chatMessageLinkStyle: chatMessageLinkStyle,
      chatMessageStyle: chatMessageStyle,
      chatMessagePopupMenu: chatMessagePopupMenu,
      chatPlatformPopupMenu: chatPlatformPopupMenu,
      chatSenderName: chatSenderName,
      chatLinkPreviewTitle: chatLinkPreviewTitle,
      chatLinkPreviewDesc: chatLinkPreviewDesc,
      chatDateHeader: chatDateHeader,
      chatSystemMessage: chatSystemMessage,
      chatFileMessageTitle: chatFileMessageTitle,
      chatFileMessageDesc: chatFileMessageDesc,
      emoji: emoji,
      gifCancelSearch: gifCancelSearch,
      gifSearchInput: gifSearchInput,
      gifSearchInputHint: gifSearchInputHint,
      chatInput: chatInput,
      profileName: profileName,
      profileStatusMessage: profileStatusMessage,
      profileRoomMemberPlus: profileRoomMemberPlus,
      profileRoomMemberTitle: profileRoomMemberTitle,
      profileInfoTitle: profileInfoTitle,
      roomInfoItemLabel: roomInfoItemLabel,
      roomInfoItemValue: roomInfoItemValue,
      buttonTitle: buttonTitle,
      buttonLabel: buttonLabel,
      roomDetailTitle: roomDetailTitle,
      roomDetailSubtitle: roomDetailSubtitle,
      roomDetailActionButtonLabel: roomDetailActionButtonLabel,
      roomDetailMemberTitle: roomDetailMemberTitle,
      roomDetailMemberUsername: roomDetailMemberUsername,
      listLabel: listLabel,
      settingItemTitle: settingItemTitle,
      settingItemValue: settingItemValue,
      settingAppVersion: settingAppVersion,
      settingAppVersionNumber: settingAppVersionNumber,
      contactRequestSection: contactRequestSection,
      contactItemType: contactItemType,
      contactItemTitle: contactItemTitle,
      contactItemSubtitle: contactItemSubtitle,
      pageTitle: pageTitle,
      pageSubtitle: pageSubtitle,
      pageSecondSubtitle: pageSecondSubtitle,
      pageBottomTitle: pageBottomTitle,
      inputCounter: inputCounter,
      formOriginalValueTitle: formOriginalValueTitle,
      formOriginalValue: formOriginalValue,
      formDescription: formDescription,
    );
  }
}
