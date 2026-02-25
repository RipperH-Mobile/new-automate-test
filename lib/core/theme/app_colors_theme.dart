// ignore_for_file: unused_field

import 'package:flutter/material.dart';

// The AppColorsTheme class extending ThemeExtension
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color textDarkest;
  final Color textDarker;
  final Color textDark;
  final Color textLight;
  final Color textLighter;
  final Color textLightest;
  final Color textDisable;
  final Color textPrimary;
  final Color textPrimaryInverse;
  final Color textError;
  final Color textErrorInverse;
  final Color textSuccess;
  final Color textSuccessInverse;
  final Color textWarning;
  final Color textWarningInverse;
  final Color textInformation;
  final Color textInformationInverse;
  final Color textChatInput;
  final Color linkText;
  final Color border;
  final Color borderLight;
  final Color borderLighter;
  final Color borderDark;
  final Color borderDarker;
  final Color borderDisable;
  final Color borderSelected;
  final Color borderInput;
  final Color borderPrimary;
  final Color borderPrimaryLight;
  final Color borderError;
  final Color borderErrorInverse;
  final Color borderSuccess;
  final Color borderSuccessInverse;
  final Color borderWarning;
  final Color borderWarningInverse;
  final Color borderInformation;
  final Color borderInformationInverse;
  final Color borderMenu;
  final Color borderProgress;
  final Color backgroundNeutralLightest;
  final Color backgroundNeutralLightestPressed;
  final Color backgroundNeutralLighter;
  final Color backgroundNeutralLighterPressed;
  final Color backgroundNeutralLight;
  final Color backgroundNeutralLightPressed;
  final Color backgroundNeutralBolder;
  final Color backgroundNeutralBolderPressed;
  final Color backgroundGrayLightest;
  final Color backgroundGrayLightestPressed;
  final Color backgroundGrayLighter;
  final Color backgroundGrayLighterPressed;
  final Color backgroundGrayLight;
  final Color backgroundGrayLightPressed;
  final Color backgroundGray;
  final Color backgroundGrayBolder;
  final Color backgroundGrayBolderPressed;
  final Color backgroundPrimaryLightest;
  final Color backgroundPrimaryLightestPressed;
  final Color backgroundPrimaryLighter;
  final Color backgroundPrimaryLighterPressed;
  final Color backgroundPrimaryLight;
  final Color backgroundPrimaryLightPressed;
  final Color backgroundPrimary;
  final Color backgroundPrimaryBolder;
  final Color backgroundPrimaryBolderPressed;
  final Color backgroundDarkNeutral;
  final Color backgroundDisable;
  final Color backgroundError;
  final Color backgroundWarning;
  final Color backgroundSuccess;
  final Color backgroundInformation;
  final Color backgroundSystemMessage;
  final Color backgroundStickerSelect;
  final Color backgroundChatSender;
  final Color backgroundChatReceiver;
  final Color backgroundStartingChat;
  final Color elevationSurface;
  final Color elevationSurfaceDark;
  final Color elevationSurfaceChat;
  final Color elevationSurfaceUnderChatInput;
  final Color backgroundChatHeader;
  final Color backgroundCallJoin;
  final Color backgroundAudioReceiverPlaying;
  final Color backgroundPinnedBanner;
  final Color icon;
  final Color iconLight;
  final Color iconLighter;
  final Color iconInverse;
  final Color iconSelected;
  final Color iconDisable;
  final Color iconPrimary;
  final Color iconPrimaryInverse;
  final Color iconError;
  final Color iconErrorInverse;
  final Color iconSuccess;
  final Color iconSuccessInverse;
  final Color iconWarning;
  final Color iconWarningInverse;
  final Color iconInformation;
  final Color iconInformationInverse;
  final Color iconCallChatRoom;
  final Color iconJoinCall;
  final Color buttonPrimary;
  final Color buttonPrimaryPressed;
  final Color buttonSecondary;
  final Color buttonSecondaryPressed;
  final Color buttonDefault;
  final Color buttonDefaultPressed;
  final Color buttonDisable;
  final Color buttonError;
  final Color buttonErrorPressed;
  final Color buttonErrorSecondary;
  final Color buttonErrorSecondaryPressed;
  final Color buttonSuccess;
  final Color buttonSuccessPressed;
  final Color buttonSuccessSecondary;
  final Color buttonSuccessSecondaryPressed;
  final Color buttonWarning;
  final Color buttonWarningPressed;
  final Color buttonWarningSecondary;
  final Color buttonWarningSecondaryPressed;
  final Color buttonBlack;
  final Color buttonBlackPressed;
  final Color buttonDark;
  final Color buttonDarkPressed;
  final Color buttonBlackTransparent;
  final Color blanket;
  final Color surface;
  final Color surfaceDark;

  // add by dev because figma not found token
  final Color backgroundBottomSheet;
  final Color divider;
  final Color backgroundPopUp;
  final Color neutral32;

  // Constructor to initialize the color properties
  const AppColorsTheme._internal({
    required this.textDarkest,
    required this.textDarker,
    required this.textDark,
    required this.textLight,
    required this.textLighter,
    required this.textLightest,
    required this.textDisable,
    required this.textPrimary,
    required this.textPrimaryInverse,
    required this.textError,
    required this.textErrorInverse,
    required this.textSuccess,
    required this.textSuccessInverse,
    required this.textWarning,
    required this.textWarningInverse,
    required this.textInformation,
    required this.textInformationInverse,
    required this.textChatInput,
    required this.linkText,
    required this.border,
    required this.borderLight,
    required this.borderLighter,
    required this.borderDark,
    required this.borderDarker,
    required this.borderDisable,
    required this.borderSelected,
    required this.borderInput,
    required this.borderPrimary,
    required this.borderPrimaryLight,
    required this.borderError,
    required this.borderErrorInverse,
    required this.borderSuccess,
    required this.borderSuccessInverse,
    required this.borderWarning,
    required this.borderWarningInverse,
    required this.borderInformation,
    required this.borderInformationInverse,
    required this.borderMenu,
    required this.borderProgress,
    required this.backgroundNeutralLightest,
    required this.backgroundNeutralLightestPressed,
    required this.backgroundNeutralLighter,
    required this.backgroundNeutralLighterPressed,
    required this.backgroundNeutralLight,
    required this.backgroundNeutralLightPressed,
    required this.backgroundNeutralBolder,
    required this.backgroundNeutralBolderPressed,
    required this.backgroundGrayLightest,
    required this.backgroundGrayLightestPressed,
    required this.backgroundGrayLighter,
    required this.backgroundGrayLighterPressed,
    required this.backgroundGrayLight,
    required this.backgroundGrayLightPressed,
    required this.backgroundGray,
    required this.backgroundGrayBolder,
    required this.backgroundGrayBolderPressed,
    required this.backgroundPrimaryLightest,
    required this.backgroundPrimaryLightestPressed,
    required this.backgroundPrimaryLighter,
    required this.backgroundPrimaryLighterPressed,
    required this.backgroundPrimaryLight,
    required this.backgroundPrimaryLightPressed,
    required this.backgroundPrimary,
    required this.backgroundPrimaryBolder,
    required this.backgroundPrimaryBolderPressed,
    required this.backgroundDarkNeutral,
    required this.backgroundDisable,
    required this.backgroundError,
    required this.backgroundWarning,
    required this.backgroundSuccess,
    required this.backgroundInformation,
    required this.backgroundSystemMessage,
    required this.backgroundStickerSelect,
    required this.backgroundChatSender,
    required this.backgroundChatReceiver,
    required this.backgroundStartingChat,
    required this.backgroundPinnedBanner,
    required this.elevationSurface,
    required this.elevationSurfaceDark,
    required this.elevationSurfaceChat,
    required this.elevationSurfaceUnderChatInput,
    required this.backgroundChatHeader,
    required this.backgroundCallJoin,
    required this.backgroundAudioReceiverPlaying,
    required this.icon,
    required this.iconLight,
    required this.iconLighter,
    required this.iconInverse,
    required this.iconSelected,
    required this.iconDisable,
    required this.iconPrimary,
    required this.iconPrimaryInverse,
    required this.iconError,
    required this.iconErrorInverse,
    required this.iconSuccess,
    required this.iconSuccessInverse,
    required this.iconWarning,
    required this.iconWarningInverse,
    required this.iconInformation,
    required this.iconInformationInverse,
    required this.iconCallChatRoom,
    required this.iconJoinCall,
    required this.buttonPrimary,
    required this.buttonPrimaryPressed,
    required this.buttonSecondary,
    required this.buttonSecondaryPressed,
    required this.buttonDefault,
    required this.buttonDefaultPressed,
    required this.buttonDisable,
    required this.buttonError,
    required this.buttonErrorPressed,
    required this.buttonErrorSecondary,
    required this.buttonErrorSecondaryPressed,
    required this.buttonSuccess,
    required this.buttonSuccessPressed,
    required this.buttonSuccessSecondary,
    required this.buttonSuccessSecondaryPressed,
    required this.buttonWarning,
    required this.buttonWarningPressed,
    required this.buttonWarningSecondary,
    required this.buttonWarningSecondaryPressed,
    required this.buttonBlack,
    required this.buttonBlackPressed,
    required this.buttonDark,
    required this.buttonDarkPressed,
    required this.buttonBlackTransparent,
    required this.blanket,
    required this.surface,
    required this.surfaceDark,
    // add by dev because figma not found token
    required this.backgroundBottomSheet,
    required this.divider,
    required this.backgroundPopUp,
    required this.neutral32,
  });

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  // Overriding the lerp method to support smooth transitions between themes
  @override
  AppColorsTheme lerp(ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) {
      return this;
    }
    return AppColorsTheme._internal(
      textDarkest: Color.lerp(textDarkest, other.textDarkest, t)!,
      textDarker: Color.lerp(textDarker, other.textDarker, t)!,
      textDark: Color.lerp(textDark, other.textDark, t)!,
      textLight: Color.lerp(textLight, other.textLight, t)!,
      textLighter: Color.lerp(textLighter, other.textLighter, t)!,
      textLightest: Color.lerp(textLightest, other.textLightest, t)!,
      textDisable: Color.lerp(textDisable, other.textDisable, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textPrimaryInverse: Color.lerp(textPrimaryInverse, other.textPrimaryInverse, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textErrorInverse: Color.lerp(textErrorInverse, other.textErrorInverse, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textSuccessInverse: Color.lerp(textSuccessInverse, other.textSuccessInverse, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textWarningInverse: Color.lerp(textWarningInverse, other.textWarningInverse, t)!,
      textInformation: Color.lerp(textInformation, other.textInformation, t)!,
      textInformationInverse: Color.lerp(textInformationInverse, other.textInformationInverse, t)!,
      textChatInput: Color.lerp(textChatInput, other.textChatInput, t)!,
      linkText: Color.lerp(linkText, other.linkText, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      borderLighter: Color.lerp(borderLighter, other.borderLighter, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
      borderDarker: Color.lerp(borderDarker, other.borderDarker, t)!,
      borderDisable: Color.lerp(borderDisable, other.borderDisable, t)!,
      borderSelected: Color.lerp(borderSelected, other.borderSelected, t)!,
      borderInput: Color.lerp(borderInput, other.borderInput, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      borderPrimaryLight: Color.lerp(borderPrimaryLight, other.borderPrimaryLight, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderErrorInverse: Color.lerp(borderErrorInverse, other.borderErrorInverse, t)!,
      borderSuccess: Color.lerp(borderSuccess, other.borderSuccess, t)!,
      borderSuccessInverse: Color.lerp(borderSuccessInverse, other.borderSuccessInverse, t)!,
      borderWarning: Color.lerp(borderWarning, other.borderWarning, t)!,
      borderWarningInverse: Color.lerp(borderWarningInverse, other.borderWarningInverse, t)!,
      borderInformation: Color.lerp(borderInformation, other.borderInformation, t)!,
      borderInformationInverse: Color.lerp(borderInformationInverse, other.borderInformationInverse, t)!,
      borderMenu: Color.lerp(borderMenu, other.borderMenu, t)!,
      borderProgress: Color.lerp(borderProgress, other.borderProgress, t)!,
      backgroundNeutralLightest: Color.lerp(backgroundNeutralLightest, other.backgroundNeutralLightest, t)!,
      backgroundNeutralLightestPressed:
          Color.lerp(backgroundNeutralLightestPressed, other.backgroundNeutralLightestPressed, t)!,
      backgroundNeutralLighter: Color.lerp(backgroundNeutralLighter, other.backgroundNeutralLighter, t)!,
      backgroundNeutralLighterPressed:
          Color.lerp(backgroundNeutralLighterPressed, other.backgroundNeutralLighterPressed, t)!,
      backgroundNeutralLight: Color.lerp(backgroundNeutralLight, other.backgroundNeutralLight, t)!,
      backgroundNeutralLightPressed: Color.lerp(backgroundNeutralLightPressed, other.backgroundNeutralLightPressed, t)!,
      backgroundNeutralBolder: Color.lerp(backgroundNeutralBolder, other.backgroundNeutralBolder, t)!,
      backgroundNeutralBolderPressed:
          Color.lerp(backgroundNeutralBolderPressed, other.backgroundNeutralBolderPressed, t)!,
      backgroundGrayLightest: Color.lerp(backgroundGrayLightest, other.backgroundGrayLightest, t)!,
      backgroundGrayLightestPressed: Color.lerp(backgroundGrayLightestPressed, other.backgroundGrayLightestPressed, t)!,
      backgroundGrayLighter: Color.lerp(backgroundGrayLighter, other.backgroundGrayLighter, t)!,
      backgroundGrayLighterPressed: Color.lerp(backgroundGrayLighterPressed, other.backgroundGrayLighterPressed, t)!,
      backgroundGrayLight: Color.lerp(backgroundGrayLight, other.backgroundGrayLight, t)!,
      backgroundGrayLightPressed: Color.lerp(backgroundGrayLightPressed, other.backgroundGrayLightPressed, t)!,
      backgroundGray: Color.lerp(backgroundGray, other.backgroundGray, t)!,
      backgroundGrayBolder: Color.lerp(backgroundGrayBolder, other.backgroundGrayBolder, t)!,
      backgroundGrayBolderPressed: Color.lerp(backgroundGrayBolderPressed, other.backgroundGrayBolderPressed, t)!,
      backgroundPrimaryLightest: Color.lerp(backgroundPrimaryLightest, other.backgroundPrimaryLightest, t)!,
      backgroundPrimaryLightestPressed:
          Color.lerp(backgroundPrimaryLightestPressed, other.backgroundPrimaryLightestPressed, t)!,
      backgroundPrimaryLighter: Color.lerp(backgroundPrimaryLighter, other.backgroundPrimaryLighter, t)!,
      backgroundPrimaryLighterPressed:
          Color.lerp(backgroundPrimaryLighterPressed, other.backgroundPrimaryLighterPressed, t)!,
      backgroundPrimaryLight: Color.lerp(backgroundPrimaryLight, other.backgroundPrimaryLight, t)!,
      backgroundPrimaryLightPressed: Color.lerp(backgroundPrimaryLightPressed, other.backgroundPrimaryLightPressed, t)!,
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundPrimaryBolder: Color.lerp(backgroundPrimaryBolder, other.backgroundPrimaryBolder, t)!,
      backgroundPrimaryBolderPressed:
          Color.lerp(backgroundPrimaryBolderPressed, other.backgroundPrimaryBolderPressed, t)!,
      backgroundDarkNeutral: Color.lerp(backgroundDarkNeutral, other.backgroundDarkNeutral, t)!,
      backgroundDisable: Color.lerp(backgroundDisable, other.backgroundDisable, t)!,
      backgroundError: Color.lerp(backgroundError, other.backgroundError, t)!,
      backgroundWarning: Color.lerp(backgroundWarning, other.backgroundWarning, t)!,
      backgroundSuccess: Color.lerp(backgroundSuccess, other.backgroundSuccess, t)!,
      backgroundInformation: Color.lerp(backgroundInformation, other.backgroundInformation, t)!,
      backgroundSystemMessage: Color.lerp(backgroundSystemMessage, other.backgroundSystemMessage, t)!,
      backgroundStickerSelect: Color.lerp(backgroundStickerSelect, other.backgroundStickerSelect, t)!,
      backgroundChatSender: Color.lerp(backgroundChatSender, other.backgroundChatSender, t)!,
      backgroundChatReceiver: Color.lerp(backgroundChatReceiver, other.backgroundChatReceiver, t)!,
      backgroundStartingChat: Color.lerp(backgroundStartingChat, other.backgroundStartingChat, t)!,
      backgroundPinnedBanner: Color.lerp(backgroundPinnedBanner, other.backgroundPinnedBanner, t)!,
      elevationSurface: Color.lerp(elevationSurface, other.elevationSurface, t)!,
      elevationSurfaceDark: Color.lerp(elevationSurfaceDark, other.elevationSurfaceDark, t)!,
      elevationSurfaceChat: Color.lerp(elevationSurfaceChat, other.elevationSurfaceChat, t)!,
      elevationSurfaceUnderChatInput:
          Color.lerp(elevationSurfaceUnderChatInput, other.elevationSurfaceUnderChatInput, t)!,
      backgroundChatHeader: Color.lerp(backgroundChatHeader, other.backgroundChatHeader, t)!,
      backgroundCallJoin: Color.lerp(backgroundCallJoin, other.backgroundCallJoin, t)!,
      backgroundAudioReceiverPlaying:
          Color.lerp(backgroundAudioReceiverPlaying, other.backgroundAudioReceiverPlaying, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      iconLight: Color.lerp(iconLight, other.iconLight, t)!,
      iconLighter: Color.lerp(iconLighter, other.iconLighter, t)!,
      iconInverse: Color.lerp(iconInverse, other.iconInverse, t)!,
      iconSelected: Color.lerp(iconSelected, other.iconSelected, t)!,
      iconDisable: Color.lerp(iconDisable, other.iconDisable, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconPrimaryInverse: Color.lerp(iconPrimaryInverse, other.iconPrimaryInverse, t)!,
      iconError: Color.lerp(iconError, other.iconError, t)!,
      iconErrorInverse: Color.lerp(iconErrorInverse, other.iconErrorInverse, t)!,
      iconSuccess: Color.lerp(iconSuccess, other.iconSuccess, t)!,
      iconSuccessInverse: Color.lerp(iconSuccessInverse, other.iconSuccessInverse, t)!,
      iconWarning: Color.lerp(iconWarning, other.iconWarning, t)!,
      iconWarningInverse: Color.lerp(iconWarningInverse, other.iconWarningInverse, t)!,
      iconInformation: Color.lerp(iconInformation, other.iconInformation, t)!,
      iconInformationInverse: Color.lerp(iconInformationInverse, other.iconInformationInverse, t)!,
      iconCallChatRoom: Color.lerp(iconCallChatRoom, other.iconCallChatRoom, t)!,
      iconJoinCall: Color.lerp(iconJoinCall, other.iconJoinCall, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonPrimaryPressed: Color.lerp(buttonPrimaryPressed, other.buttonPrimaryPressed, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonSecondaryPressed: Color.lerp(buttonSecondaryPressed, other.buttonSecondaryPressed, t)!,
      buttonDefault: Color.lerp(buttonDefault, other.buttonDefault, t)!,
      buttonDefaultPressed: Color.lerp(buttonDefaultPressed, other.buttonDefaultPressed, t)!,
      buttonDisable: Color.lerp(buttonDisable, other.buttonDisable, t)!,
      buttonError: Color.lerp(buttonError, other.buttonError, t)!,
      buttonErrorPressed: Color.lerp(buttonErrorPressed, other.buttonErrorPressed, t)!,
      buttonErrorSecondary: Color.lerp(buttonErrorSecondary, other.buttonErrorSecondary, t)!,
      buttonErrorSecondaryPressed: Color.lerp(buttonErrorSecondaryPressed, other.buttonErrorSecondaryPressed, t)!,
      buttonSuccess: Color.lerp(buttonSuccess, other.buttonSuccess, t)!,
      buttonSuccessPressed: Color.lerp(buttonSuccessPressed, other.buttonSuccessPressed, t)!,
      buttonSuccessSecondary: Color.lerp(buttonSuccessSecondary, other.buttonSuccessSecondary, t)!,
      buttonSuccessSecondaryPressed: Color.lerp(buttonSuccessSecondaryPressed, other.buttonSuccessSecondaryPressed, t)!,
      buttonWarning: Color.lerp(buttonWarning, other.buttonWarning, t)!,
      buttonWarningPressed: Color.lerp(buttonWarningPressed, other.buttonWarningPressed, t)!,
      buttonWarningSecondary: Color.lerp(buttonWarningSecondary, other.buttonWarningSecondary, t)!,
      buttonWarningSecondaryPressed: Color.lerp(buttonWarningSecondaryPressed, other.buttonWarningSecondaryPressed, t)!,
      buttonBlack: Color.lerp(buttonBlack, other.buttonBlack, t)!,
      buttonBlackPressed: Color.lerp(buttonBlackPressed, other.buttonBlackPressed, t)!,
      buttonDark: Color.lerp(buttonDark, other.buttonDark, t)!,
      buttonDarkPressed: Color.lerp(buttonDarkPressed, other.buttonDarkPressed, t)!,
      buttonBlackTransparent: Color.lerp(buttonBlackTransparent, other.buttonBlackTransparent, t)!,
      blanket: Color.lerp(blanket, other.blanket, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceDark: Color.lerp(surfaceDark, other.surfaceDark, t)!,
      // add by dev because figma not found token
      backgroundBottomSheet: Color.lerp(backgroundBottomSheet, other.backgroundBottomSheet, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      backgroundPopUp: Color.lerp(backgroundPopUp, other.backgroundPopUp, t)!,
      neutral32: Color.lerp(neutral32, other.neutral32, t)!,
    );
  }

  static AppColorsTheme blue() {
    return const AppColorsTheme._internal(
      textDarkest: _AppColors.neutral950,
      textDarker: _AppColors.neutral800,
      textDark: _AppColors.neutral600,
      textLight: _AppColors.neutral500,
      textLighter: _AppColors.neutral400,
      textLightest: _AppColors.neutral300,
      textDisable: _AppColors.neutral300,
      textPrimary: _AppColors.blue700,
      textPrimaryInverse: _AppColors.neutral0,
      textError: _AppColors.red600,
      textErrorInverse: _AppColors.neutral0,
      textSuccess: _AppColors.green600,
      textSuccessInverse: _AppColors.neutral0,
      textWarning: _AppColors.yellow600,
      textWarningInverse: _AppColors.neutral0,
      textInformation: _AppColors.blue700,
      textInformationInverse: _AppColors.neutral0,
      textChatInput: _AppColors.neutral600,
      linkText: _AppColors.blue700,
      border: _AppColors.gray200,
      borderLight: _AppColors.gray50,
      borderLighter: _AppColors.neutral0,
      borderDark: _AppColors.gray400,
      borderDarker: _AppColors.gray600,
      borderDisable: _AppColors.gray200,
      borderSelected: _AppColors.gray800,
      borderInput: _AppTransparent.gray32,
      borderPrimary: _AppColors.blue700,
      borderPrimaryLight: _AppColors.blue600,
      borderError: _AppColors.red600,
      borderErrorInverse: _AppColors.neutral0,
      borderSuccess: _AppColors.green500,
      borderSuccessInverse: _AppColors.neutral0,
      borderWarning: _AppColors.yellow500,
      borderWarningInverse: _AppColors.neutral0,
      borderInformation: _AppColors.blue700,
      borderInformationInverse: _AppColors.neutral0,
      borderMenu: _AppTransparent.darkNeutral8,
      borderProgress: _AppTransparent.darkNeutral32,
      backgroundNeutralLightest: _AppColors.neutral0,
      backgroundNeutralLightestPressed: _AppColors.neutral0,
      backgroundNeutralLighter: _AppColors.neutral50,
      backgroundNeutralLighterPressed: _AppColors.neutral100,
      backgroundNeutralLight: _AppColors.neutral100,
      backgroundNeutralLightPressed: _AppColors.neutral200,
      backgroundNeutralBolder: _AppColors.neutral700,
      backgroundNeutralBolderPressed: _AppColors.neutral800,
      backgroundGrayLightest: _AppColors.gray200,
      backgroundGrayLightestPressed: _AppColors.gray300,
      backgroundGrayLighter: _AppColors.gray300,
      backgroundGrayLighterPressed: _AppColors.gray400,
      backgroundGrayLight: _AppColors.gray400,
      backgroundGrayLightPressed: _AppColors.gray500,
      backgroundGray: _AppColors.gray500,
      backgroundGrayBolder: _AppColors.gray700,
      backgroundGrayBolderPressed: _AppColors.gray800,
      backgroundPrimaryLightest: _AppColors.blue50,
      backgroundPrimaryLightestPressed: _AppColors.blue100,
      backgroundPrimaryLighter: _AppColors.blue200,
      backgroundPrimaryLighterPressed: _AppColors.blue300,
      backgroundPrimaryLight: _AppColors.blue300,
      backgroundPrimaryLightPressed: _AppColors.blue400,
      backgroundPrimary: _AppColors.blue700,
      backgroundPrimaryBolder: _AppColors.blue800,
      backgroundPrimaryBolderPressed: _AppColors.blue900,
      backgroundDarkNeutral: _AppColors.darkNeutral0,
      backgroundDisable: _AppTransparent.neutral16,
      backgroundError: _AppColors.red500,
      backgroundWarning: _AppColors.yellow500,
      backgroundSuccess: _AppColors.green500,
      backgroundInformation: _AppColors.blue700,
      backgroundSystemMessage: _AppTransparent.gray48,
      backgroundStickerSelect: _AppTransparent.darkNeutral72,
      backgroundChatSender: _AppColors.blue700,
      backgroundChatReceiver: _AppColors.neutral0,
      backgroundStartingChat: _AppColors.spindle100,
      elevationSurface: _AppColors.neutral50,
      elevationSurfaceDark: _AppColors.neutral100,
      elevationSurfaceChat: _AppColors.spindle300,
      elevationSurfaceUnderChatInput: _AppColors.neutral100,
      backgroundChatHeader: _AppColors.spindle300,
      backgroundCallJoin: _AppColors.neutral0,
      backgroundAudioReceiverPlaying: _AppColors.neutral200,
      backgroundPinnedBanner: _AppTransparent.darkNeutral72,
      icon: _AppColors.neutral950,
      iconLight: _AppColors.neutral500,
      iconLighter: _AppColors.neutral400,
      iconInverse: _AppColors.neutral0,
      iconSelected: _AppColors.blue700,
      iconDisable: _AppColors.neutral300,
      iconPrimary: _AppColors.blue700,
      iconPrimaryInverse: _AppColors.neutral0,
      iconError: _AppColors.red600,
      iconErrorInverse: _AppColors.neutral0,
      iconSuccess: _AppColors.green500,
      iconSuccessInverse: _AppColors.neutral0,
      iconWarning: _AppColors.yellow600,
      iconWarningInverse: _AppColors.neutral0,
      iconInformation: _AppColors.blue700,
      iconInformationInverse: _AppColors.neutral0,
      iconCallChatRoom: _AppColors.green500,
      iconJoinCall: _AppColors.green500,
      buttonPrimary: _AppColors.blue700,
      buttonPrimaryPressed: _AppColors.blue800,
      buttonSecondary: _AppColors.neutral0,
      buttonSecondaryPressed: _AppColors.neutral50,
      buttonDefault: _AppColors.neutral100,
      buttonDefaultPressed: _AppColors.neutral200,
      buttonDisable: _AppTransparent.neutral16,
      buttonError: _AppColors.red600,
      buttonErrorPressed: _AppColors.red700,
      buttonErrorSecondary: _AppColors.neutral0,
      buttonErrorSecondaryPressed: _AppColors.neutral50,
      buttonSuccess: _AppColors.green500,
      buttonSuccessPressed: _AppColors.green600,
      buttonSuccessSecondary: _AppColors.neutral0,
      buttonSuccessSecondaryPressed: _AppColors.neutral50,
      buttonWarning: _AppColors.yellow500,
      buttonWarningPressed: _AppColors.yellow600,
      buttonWarningSecondary: _AppColors.neutral0,
      buttonWarningSecondaryPressed: _AppColors.neutral50,
      buttonBlack: _AppColors.darkNeutralMinus100,
      buttonBlackPressed: _AppColors.darkNeutral350,
      buttonDark: _AppColors.neutral800,
      buttonDarkPressed: _AppColors.neutral600,
      buttonBlackTransparent: _AppTransparent.darkNeutral48,
      blanket: _AppTransparent.darkNeutral48,
      surface: _AppColors.neutral50,
      surfaceDark: _AppColors.neutral100,
      // add by dev because figma not found token
      backgroundBottomSheet: _AppTransparent.gray8,
      divider: _AppColors.darkNeutral800,
      backgroundPopUp: _AppColors.darkNeutral1200,
      neutral32: _AppTransparent.neutral32,
    );
  }

  // Static method to get the light theme colors
  static AppColorsTheme light() {
    return const AppColorsTheme._internal(
      textDarkest: _AppColors.neutral950,
      textDarker: _AppColors.neutral800,
      textDark: _AppColors.neutral600,
      textLight: _AppColors.neutral500,
      textLighter: _AppColors.neutral400,
      textLightest: _AppColors.neutral300,
      textDisable: _AppColors.neutral300,
      textPrimary: _AppColors.blue700,
      textPrimaryInverse: _AppColors.neutral0,
      textError: _AppColors.red600,
      textErrorInverse: _AppColors.neutral0,
      textSuccess: _AppColors.green600,
      textSuccessInverse: _AppColors.neutral0,
      textWarning: _AppColors.yellow600,
      textWarningInverse: _AppColors.neutral0,
      textInformation: _AppColors.blue700,
      textInformationInverse: _AppColors.neutral0,
      textChatInput: _AppColors.neutral600,
      linkText: _AppColors.blue700,
      border: _AppColors.gray200,
      borderLight: _AppColors.gray50,
      borderLighter: _AppColors.neutral0,
      borderDark: _AppColors.gray400,
      borderDarker: _AppColors.gray600,
      borderDisable: _AppColors.gray200,
      borderSelected: _AppColors.gray800,
      borderInput: _AppTransparent.gray32,
      borderPrimary: _AppColors.blue700,
      borderPrimaryLight: _AppColors.blue600,
      borderError: _AppColors.red600,
      borderErrorInverse: _AppColors.neutral0,
      borderSuccess: _AppColors.green500,
      borderSuccessInverse: _AppColors.neutral0,
      borderWarning: _AppColors.yellow500,
      borderWarningInverse: _AppColors.neutral0,
      borderInformation: _AppColors.blue700,
      borderInformationInverse: _AppColors.neutral0,
      borderMenu: _AppTransparent.darkNeutral8,
      borderProgress: _AppTransparent.darkNeutral32,
      backgroundNeutralLightest: _AppColors.neutral0,
      backgroundNeutralLightestPressed: _AppColors.neutral0,
      backgroundNeutralLighter: _AppColors.neutral50,
      backgroundNeutralLighterPressed: _AppColors.neutral100,
      backgroundNeutralLight: _AppColors.neutral100,
      backgroundNeutralLightPressed: _AppColors.neutral200,
      backgroundNeutralBolder: _AppColors.neutral700,
      backgroundNeutralBolderPressed: _AppColors.neutral800,
      backgroundGrayLightest: _AppColors.gray200,
      backgroundGrayLightestPressed: _AppColors.gray300,
      backgroundGrayLighter: _AppColors.gray300,
      backgroundGrayLighterPressed: _AppColors.gray400,
      backgroundGrayLight: _AppColors.gray400,
      backgroundGrayLightPressed: _AppColors.gray500,
      backgroundGray: _AppColors.gray500,
      backgroundGrayBolder: _AppColors.gray700,
      backgroundGrayBolderPressed: _AppColors.gray800,
      backgroundPrimaryLightest: _AppColors.blue50,
      backgroundPrimaryLightestPressed: _AppColors.blue100,
      backgroundPrimaryLighter: _AppColors.blue200,
      backgroundPrimaryLighterPressed: _AppColors.blue300,
      backgroundPrimaryLight: _AppColors.blue300,
      backgroundPrimaryLightPressed: _AppColors.blue400,
      backgroundPrimary: _AppColors.blue700,
      backgroundPrimaryBolder: _AppColors.blue800,
      backgroundPrimaryBolderPressed: _AppColors.blue900,
      backgroundDarkNeutral: _AppColors.darkNeutral0,
      backgroundDisable: _AppTransparent.neutral16,
      backgroundError: _AppColors.red500,
      backgroundWarning: _AppColors.yellow500,
      backgroundSuccess: _AppColors.green500,
      backgroundInformation: _AppColors.blue700,
      backgroundSystemMessage: _AppTransparent.gray48,
      backgroundStickerSelect: _AppTransparent.darkNeutral72,
      backgroundChatSender: _AppColors.blue700,
      backgroundChatReceiver: _AppColors.neutral100,
      backgroundStartingChat: _AppColors.neutral100,
      elevationSurface: _AppColors.neutral50,
      elevationSurfaceDark: _AppColors.neutral100,
      elevationSurfaceChat: _AppColors.neutral50,
      elevationSurfaceUnderChatInput: _AppColors.neutral50,
      backgroundChatHeader: _AppColors.neutral50,
      backgroundCallJoin: _AppColors.blue700,
      backgroundAudioReceiverPlaying: _AppColors.neutral200,
      backgroundPinnedBanner: _AppTransparent.darkNeutral72,
      icon: _AppColors.neutral950,
      iconLight: _AppColors.neutral500,
      iconLighter: _AppColors.neutral400,
      iconInverse: _AppColors.neutral0,
      iconSelected: _AppColors.blue700,
      iconDisable: _AppColors.neutral300,
      iconPrimary: _AppColors.blue700,
      iconPrimaryInverse: _AppColors.neutral0,
      iconError: _AppColors.red600,
      iconErrorInverse: _AppColors.neutral0,
      iconSuccess: _AppColors.green500,
      iconSuccessInverse: _AppColors.neutral0,
      iconWarning: _AppColors.yellow600,
      iconWarningInverse: _AppColors.neutral0,
      iconInformation: _AppColors.blue700,
      iconInformationInverse: _AppColors.neutral0,
      iconCallChatRoom: _AppColors.blue700,
      iconJoinCall: _AppColors.neutral0,
      buttonPrimary: _AppColors.blue700,
      buttonPrimaryPressed: _AppColors.blue800,
      buttonSecondary: _AppColors.neutral0,
      buttonSecondaryPressed: _AppColors.neutral50,
      buttonDefault: _AppColors.neutral100,
      buttonDefaultPressed: _AppColors.neutral200,
      buttonDisable: _AppTransparent.neutral16,
      buttonError: _AppColors.red600,
      buttonErrorPressed: _AppColors.red700,
      buttonErrorSecondary: _AppColors.neutral0,
      buttonErrorSecondaryPressed: _AppColors.neutral50,
      buttonSuccess: _AppColors.green500,
      buttonSuccessPressed: _AppColors.green600,
      buttonSuccessSecondary: _AppColors.neutral0,
      buttonSuccessSecondaryPressed: _AppColors.neutral50,
      buttonWarning: _AppColors.yellow500,
      buttonWarningPressed: _AppColors.yellow600,
      buttonWarningSecondary: _AppColors.neutral0,
      buttonWarningSecondaryPressed: _AppColors.neutral50,
      buttonBlack: _AppColors.darkNeutralMinus100,
      buttonBlackPressed: _AppColors.darkNeutral350,
      buttonDark: _AppColors.neutral800,
      buttonDarkPressed: _AppColors.neutral600,
      buttonBlackTransparent: _AppTransparent.darkNeutral48,
      blanket: _AppTransparent.darkNeutral48,
      surface: _AppColors.neutral50,
      surfaceDark: _AppColors.neutral100,
      // add by dev because figma not found token
      backgroundBottomSheet: _AppTransparent.gray8,
      divider: _AppColors.darkNeutral800,
      backgroundPopUp: _AppColors.darkNeutral1200,
      neutral32: _AppTransparent.neutral32,
    );
  }

  // Static method to get the dark theme colors
  static AppColorsTheme dark() {
    return const AppColorsTheme._internal(
      textDarkest: _AppColors.neutral0,
      textDarker: _AppColors.darkNeutral900,
      textDark: _AppColors.darkNeutral700,
      textLight: _AppColors.darkNeutral600,
      textLighter: _AppColors.darkNeutral500,
      textLightest: _AppColors.darkNeutral400,
      textDisable: _AppColors.darkNeutral400,
      textPrimary: _AppColors.blue600,
      textPrimaryInverse: _AppColors.neutral0,
      textError: _AppColors.red600,
      textErrorInverse: _AppColors.neutral0,
      textSuccess: _AppColors.green600,
      textSuccessInverse: _AppColors.neutral0,
      textWarning: _AppColors.yellow600,
      textWarningInverse: _AppColors.neutral0,
      textInformation: _AppColors.blue600,
      textInformationInverse: _AppColors.neutral0,
      textChatInput: _AppColors.neutral300,
      linkText: _AppColors.blue600,
      border: _AppColors.gray800,
      borderLight: _AppColors.gray900,
      borderLighter: _AppColors.darkNeutral0,
      borderDark: _AppColors.gray600,
      borderDarker: _AppColors.gray400,
      borderDisable: _AppColors.gray800,
      borderSelected: _AppColors.gray200,
      borderInput: _AppTransparent.gray32,
      borderPrimary: _AppColors.blue600,
      borderPrimaryLight: _AppColors.neutral0,
      borderError: _AppColors.red600,
      borderErrorInverse: _AppColors.neutral0,
      borderSuccess: _AppColors.green500,
      borderSuccessInverse: _AppColors.neutral0,
      borderWarning: _AppColors.yellow500,
      borderWarningInverse: _AppColors.neutral0,
      borderInformation: _AppColors.blue600,
      borderInformationInverse: _AppColors.neutral0,
      borderMenu: _AppTransparent.neutral12,
      borderProgress: _AppTransparent.darkNeutral32,
      backgroundNeutralLightest: _AppColors.darkNeutralMinus100,
      backgroundNeutralLightestPressed: _AppColors.darkNeutral0,
      backgroundNeutralLighter: _AppColors.darkNeutral0,
      backgroundNeutralLighterPressed: _AppColors.darkNeutral100,
      backgroundNeutralLight: _AppColors.darkNeutral200,
      backgroundNeutralLightPressed: _AppColors.darkNeutral350,
      backgroundNeutralBolder: _AppColors.neutral600,
      backgroundNeutralBolderPressed: _AppColors.neutral700,
      backgroundGrayLightest: _AppColors.gray800,
      backgroundGrayLightestPressed: _AppColors.gray700,
      backgroundGrayLighter: _AppColors.gray700,
      backgroundGrayLighterPressed: _AppColors.gray600,
      backgroundGrayLight: _AppColors.gray600,
      backgroundGrayLightPressed: _AppColors.gray500,
      backgroundGray: _AppColors.gray500,
      backgroundGrayBolder: _AppColors.gray500,
      backgroundGrayBolderPressed: _AppColors.gray600,
      backgroundPrimaryLightest: _AppColors.blue950,
      backgroundPrimaryLightestPressed: _AppColors.blue900,
      backgroundPrimaryLighter: _AppColors.blue800,
      backgroundPrimaryLighterPressed: _AppColors.blue700,
      backgroundPrimaryLight: _AppColors.blue700,
      backgroundPrimaryLightPressed: _AppColors.blue600,
      backgroundPrimary: _AppColors.blue600,
      backgroundPrimaryBolder: _AppColors.blue800,
      backgroundPrimaryBolderPressed: _AppColors.blue100,
      backgroundDarkNeutral: _AppColors.neutral0,
      backgroundDisable: _AppTransparent.neutral16,
      backgroundError: _AppColors.red500,
      backgroundWarning: _AppColors.yellow500,
      backgroundSuccess: _AppColors.green500,
      backgroundInformation: _AppColors.blue600,
      backgroundSystemMessage: _AppTransparent.gray48,
      backgroundStickerSelect: _AppColors.neutral0,
      backgroundChatSender: _AppColors.blue700,
      backgroundChatReceiver: _AppColors.darkNeutral200,
      backgroundStartingChat: _AppColors.darkNeutral200,
      backgroundPinnedBanner: _AppTransparent.darkNeutral72,
      elevationSurface: _AppColors.darkNeutral0,
      elevationSurfaceDark: _AppColors.darkNeutralMinus100,
      elevationSurfaceChat: _AppColors.darkNeutral0,
      elevationSurfaceUnderChatInput: _AppColors.darkNeutral0,
      backgroundChatHeader: _AppColors.darkNeutral0,
      backgroundCallJoin: _AppColors.blue700,
      backgroundAudioReceiverPlaying: _AppColors.darkNeutral350,
      icon: _AppColors.neutral0,
      iconLight: _AppColors.darkNeutral500,
      iconLighter: _AppColors.darkNeutral400,
      iconInverse: _AppColors.darkNeutral0,
      iconSelected: _AppColors.blue600,
      iconDisable: _AppColors.darkNeutral300,
      iconPrimary: _AppColors.blue600,
      iconPrimaryInverse: _AppColors.neutral0,
      iconError: _AppColors.red600,
      iconErrorInverse: _AppColors.neutral0,
      iconSuccess: _AppColors.green500,
      iconSuccessInverse: _AppColors.neutral0,
      iconWarning: _AppColors.yellow600,
      iconWarningInverse: _AppColors.neutral0,
      iconInformation: _AppColors.blue600,
      iconInformationInverse: _AppColors.neutral0,
      iconCallChatRoom: _AppColors.blue700,
      iconJoinCall: _AppColors.neutral0,
      buttonPrimary: _AppColors.blue600,
      buttonPrimaryPressed: _AppColors.blue700,
      buttonSecondary: _AppColors.darkNeutral0,
      buttonSecondaryPressed: _AppColors.darkNeutral100,
      buttonDefault: _AppColors.darkNeutral100,
      buttonDefaultPressed: _AppColors.darkNeutral200,
      buttonDisable: _AppTransparent.neutral16,
      buttonError: _AppColors.red600,
      buttonErrorPressed: _AppColors.red700,
      buttonErrorSecondary: _AppColors.darkNeutral0,
      buttonErrorSecondaryPressed: _AppColors.darkNeutral100,
      buttonSuccess: _AppColors.green500,
      buttonSuccessPressed: _AppColors.green600,
      buttonSuccessSecondary: _AppColors.darkNeutral0,
      buttonSuccessSecondaryPressed: _AppColors.darkNeutral100,
      buttonWarning: _AppColors.yellow500,
      buttonWarningPressed: _AppColors.yellow600,
      buttonWarningSecondary: _AppColors.darkNeutral0,
      buttonWarningSecondaryPressed: _AppColors.darkNeutral100,
      buttonBlack: _AppColors.neutral0,
      buttonBlackPressed: _AppColors.neutral200,
      buttonDark: _AppColors.neutral200,
      buttonDarkPressed: _AppColors.neutral300,
      buttonBlackTransparent: _AppTransparent.darkNeutral48,
      blanket: _AppTransparent.darkNeutral48,
      surface: _AppColors.darkNeutral0,
      surfaceDark: _AppColors.darkNeutralMinus100,
      // add by dev because figma not found token
      backgroundBottomSheet: _AppTransparent.gray8,
      divider: _AppColors.darkNeutral800,
      backgroundPopUp: _AppColors.darkNeutral1200,
      neutral32: _AppTransparent.neutral32,
    );
  }
}

class AppGradientTheme extends ThemeExtension<AppGradientTheme> {
  final List<Color> gradientBlack;
  final List<Color> gradientGray;
  final List<Color> gradientWhite;
  final List<Color> gradientBlue;
  final List<Color> gradientBlue2;
  final List<Color> gradientBlackGray;
  final List<Color> gradientBlueGray;

  const AppGradientTheme._internal({
    required this.gradientBlack,
    required this.gradientGray,
    required this.gradientWhite,
    required this.gradientBlue,
    required this.gradientBlue2,
    required this.gradientBlackGray,
    required this.gradientBlueGray,
  });

  @override
  ThemeExtension<AppGradientTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppGradientTheme> lerp(covariant ThemeExtension<AppGradientTheme>? other, double t) {
    return this;
  }

  static AppGradientTheme dark() {
    return const AppGradientTheme._internal(
      gradientBlack: [Color(0xFF0D1115), Color(0xFF323941)],
      gradientGray: [Color(0xFF24272B), Color(0xFF48505C)],
      gradientWhite: [Colors.white, Color(0xFFA3A6B0)],
      gradientBlue: [Color(0xFF3277FF), Color(0xFF0056FD)],
      gradientBlue2: [Color(0xFF4685FF), Color(0xFF0056FD)],
      gradientBlackGray: [Color(0xFF0E1216), Color(0xFF333942)],
      gradientBlueGray: [Color(0xFFE8ECF3), Color(0xFFDDE3EE)],
    );
  }

  static AppGradientTheme light() {
    return const AppGradientTheme._internal(
      gradientBlack: [Color(0xFF0D1115), Color(0xFF323941)],
      gradientGray: [Color(0xFF24272B), Color(0xFF48505C)],
      gradientWhite: [Colors.white, Color(0xFFA3A6B0)],
      gradientBlue: [Color(0xFF3277FF), Color(0xFF0056FD)],
      gradientBlue2: [Color(0xFF4685FF), Color(0xFF0056FD)],
      gradientBlackGray: [Color(0xFF0E1216), Color(0xFF333942)],
      gradientBlueGray: [Color(0xFFE8ECF3), Color(0xFFDDE3EE)],
    );
  }
}

class _AppColors {
  // Blue
  static const Color blue50 = Color(0xFFEDF7FF);
  static const Color blue100 = Color(0xFFD6ECFF);
  static const Color blue200 = Color(0xFFB5E0FF);
  static const Color blue300 = Color(0xFF83CEFF);
  static const Color blue400 = Color(0xFF48B1FF);
  static const Color blue500 = Color(0xFF1E8DFF);
  static const Color blue600 = Color(0xFF066BFF);
  static const Color blue700 = Color(0xFF0056FD);
  static const Color blue800 = Color(0xFF0843C5);
  static const Color blue900 = Color(0xFF0D3D9B);
  static const Color blue950 = Color(0xFF0E265D);

  // Neutral
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF9F9F9);
  static const Color neutral100 = Color(0xFFEFEFEF);
  static const Color neutral200 = Color(0xFFDCDCDC);
  static const Color neutral300 = Color(0xFFBDBDBD);
  static const Color neutral400 = Color(0xFF989898);
  static const Color neutral500 = Color(0xFF7C7C7C);
  static const Color neutral600 = Color(0xFF656565);
  static const Color neutral700 = Color(0xFF525252);
  static const Color neutral800 = Color(0xFF464646);
  static const Color neutral900 = Color(0xFF3D3D3D);
  static const Color neutral950 = Color(0xFF292929);

  // DarkNeutral
  static const Color darkNeutralMinus100 = Color(0xFF101214);
  static const Color darkNeutral0 = Color(0xFF161A1D);
  static const Color darkNeutral100 = Color(0xFF1D2125);
  static const Color darkNeutral200 = Color(0xFF22272B);
  static const Color darkNeutral250 = Color(0xFF282E33);
  static const Color darkNeutral300 = Color(0xFF2C333A);
  static const Color darkNeutral350 = Color(0xFF38414A);
  static const Color darkNeutral400 = Color(0xFF454F59);
  static const Color darkNeutral500 = Color(0xFF596773);
  static const Color darkNeutral600 = Color(0xFF738496);
  static const Color darkNeutral700 = Color(0xFF8C9BAB);
  static const Color darkNeutral800 = Color(0xFF9FADBC);
  static const Color darkNeutral900 = Color(0xFFB6C2CF);
  static const Color darkNeutral1000 = Color(0xFFC7D1DB);
  static const Color darkNeutral1100 = Color(0xFFDEE4EA);
  static const Color darkNeutral1200 = Color(0xFFF5F6FA);

  // Gray
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color gray950 = Color(0xFF030712);

  // Red
  static const Color red50 = Color(0xFFFFEFF1);
  static const Color red100 = Color(0xFFFFE0E4);
  static const Color red200 = Color(0xFFFFC6D0);
  static const Color red300 = Color(0xFFFF97A9);
  static const Color red400 = Color(0xFFFF5D7D);
  static const Color red500 = Color(0xFFFF2455);
  static const Color red600 = Color(0xFFFF1552);
  static const Color red700 = Color(0xFFD70038);
  static const Color red800 = Color(0xFFB40037);
  static const Color red900 = Color(0xFF990236);
  static const Color red950 = Color(0xFF570018);

  // Yellow
  static const Color yellow50 = Color(0xFFFFFBEC);
  static const Color yellow100 = Color(0xFFFFF7D3);
  static const Color yellow200 = Color(0xFFFFECA5);
  static const Color yellow300 = Color(0xFFFFDB6D);
  static const Color yellow400 = Color(0xFFFFBF32);
  static const Color yellow500 = Color(0xFFFFA80A);
  static const Color yellow600 = Color(0xFFFF9100);
  static const Color yellow700 = Color(0xFFCC6B02);
  static const Color yellow800 = Color(0xFFA1520B);
  static const Color yellow900 = Color(0xFF82450C);
  static const Color yellow950 = Color(0xFF462104);

  // Green
  static const Color green50 = Color(0xFFEDFFF7);
  static const Color green100 = Color(0xFFD5FFEE);
  static const Color green200 = Color(0xFFAEFFDD);
  static const Color green300 = Color(0xFF70FFC4);
  static const Color green400 = Color(0xFF2BFDA4);
  static const Color green500 = Color(0xFF00DD80);
  static const Color green600 = Color(0xFF00C06B);
  static const Color green700 = Color(0xFF009657);
  static const Color green800 = Color(0xFF067547);
  static const Color green900 = Color(0xFF07603D);
  static const Color green950 = Color(0xFF003721);

  // Spindle
  static const Color spindle50 = Color(0xFFF0F6FE);
  static const Color spindle100 = Color(0xFFDEEAFB);
  static const Color spindle200 = Color(0xFFC4DBF9);
  static const Color spindle300 = Color(0xFFA8CCF6);
  static const Color spindle400 = Color(0xFF6CA5EE);
  static const Color spindle500 = Color(0xFF4A84E7);
  static const Color spindle600 = Color(0xFF3567DB);
  static const Color spindle700 = Color(0xFF2C53C9);
  static const Color spindle800 = Color(0xFF2945A4);
  static const Color spindle900 = Color(0xFF263D82);
  static const Color spindle950 = Color(0xFF1C274F);
}

// ignore: avoid_classes_
class _AppTransparent {
  ///NOTE
  ///Hex alpha values
  ///0x14 = 8%
  ///0x1F = 12%
  ///0x29 = 16%
  ///0x3D = 24%
  ///0x52 = 32%
  ///0x7A = 48%

  // Blue Transparency
  static const Color blue8 = Color(0x14066CFF); // 8% transparency
  static const Color blue12 = Color(0x1F066CFF); // 12% transparency
  static const Color blue16 = Color(0x29066CFF); // 16% transparency
  static const Color blue24 = Color(0x3D066CFF); // 24% transparency
  static const Color blue32 = Color(0x52066CFF); // 32% transparency
  static const Color blue48 = Color(0x7A066CFF); // 48% transparency

  // Neutral Transparency
  static const Color neutral8 = Color(0x147C7C7C); // 8% transparency
  static const Color neutral12 = Color(0x1F7C7C7C); // 12% transparency
  static const Color neutral16 = Color(0x297C7C7C); // 16% transparency
  static const Color neutral24 = Color(0x3D7C7C7C); // 24% transparency
  static const Color neutral32 = Color(0x527C7C7C); // 32% transparency
  static const Color neutral48 = Color(0x7A7C7C7C); // 48% transparency
  static const Color neutral56 = Color(0x8C7C7C7C); // 56% transparency
  static const Color neutral64 = Color(0xA07C7C7C); // 64% transparency
  static const Color neutral72 = Color(0xB37C7C7C); // 72% transparency

  // DarkNeutral Transparency
  static const Color darkNeutral8 = Color(0x141D2125); // 8% transparency
  static const Color darkNeutral12 = Color(0x1F1D2125); // 12% transparency
  static const Color darkNeutral16 = Color(0x291D2125); // 16% transparency
  static const Color darkNeutral24 = Color(0x3D1D2125); // 24% transparency
  static const Color darkNeutral32 = Color(0x521D2125); // 32% transparency
  static const Color darkNeutral48 = Color(0x7A1D2125); // 48% transparency
  static const Color darkNeutral56 = Color(0x8C1D2125); // 56% transparency
  static const Color darkNeutral64 = Color(0xA01D2125); // 64% transparency
  static const Color darkNeutral72 = Color(0xB31D2125); // 72% transparency

  // Gray Transparency
  static const Color gray8 = Color(0x144B5563); // 8% transparency
  static const Color gray12 = Color(0x1F4B5563); // 12% transparency
  static const Color gray16 = Color(0x294B5563); // 16% transparency
  static const Color gray24 = Color(0x3D4B5563); // 24% transparency
  static const Color gray32 = Color(0x524B5563); // 32% transparency
  static const Color gray48 = Color(0x7A4B5563); // 48% transparency

  // Red Transparency
  static const Color red8 = Color(0x14FF1552); // 8% transparency
  static const Color red12 = Color(0x1FFF1552); // 12% transparency
  static const Color red16 = Color(0x29FF1552); // 16% transparency
  static const Color red24 = Color(0x3DFF1552); // 24% transparency
  static const Color red32 = Color(0x52FF1552); // 32% transparency
  static const Color red48 = Color(0x7AFF1552); // 48% transparency

  // Yellow Transparency
  static const Color yellow8 = Color(0x14FF9100); // 8% transparency
  static const Color yellow12 = Color(0x1FFF9100); // 12% transparency
  static const Color yellow16 = Color(0x29FF9100); // 16% transparency
  static const Color yellow24 = Color(0x3DFF9100); // 24% transparency
  static const Color yellow32 = Color(0x52FF9100); // 32% transparency
  static const Color yellow48 = Color(0x7AFF9100); // 48% transparency

  // Green Transparency
  static const Color green8 = Color(0x1400DD80); // 8% transparency
  static const Color green12 = Color(0x1F00DD80); // 12% transparency
  static const Color green16 = Color(0x2900DD80); // 16% transparency
  static const Color green24 = Color(0x3D00DD80); // 24% transparency
  static const Color green32 = Color(0x5200DD80); // 32% transparency
  static const Color green48 = Color(0x7A00DD80); // 48% transparency
}
