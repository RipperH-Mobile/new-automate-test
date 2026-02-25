enum InputModeState {
  close,
  keyboard,
  customInput,
  customInputFullScreen, // TODO: remove this
  moreMenu; // TODO: remove this

  String get value {
    switch (this) {
      case InputModeState.close:
        return 'CLOSE';
      case InputModeState.keyboard:
        return 'KEYBOARD';
      case InputModeState.customInput:
        return 'CUSTOM_INPUT';
      case InputModeState.customInputFullScreen:
        return 'CUSTOM_INPUT_FULL_SCREEN';
      case InputModeState.moreMenu:
        return 'MORE_MENU';
    }
  }

  static from(String val) {
    switch (val) {
      case 'CLOSE':
        return InputModeState.close;
      case 'KEYBOARD':
        return InputModeState.keyboard;
      case 'CUSTOM_INPUT':
        return InputModeState.customInput;
      case 'CUSTOM_INPUT_FULL_SCREEN':
        return InputModeState.customInputFullScreen;
      case 'MORE_MENU':
        return InputModeState.moreMenu;
    }
  }
}
