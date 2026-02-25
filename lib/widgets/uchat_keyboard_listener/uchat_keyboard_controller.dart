part of 'uchat_keyboard_listener.dart';

// final _log = useLogger();

class UChatKeyboardController extends GetxController {
  final passingKeyId = <int>{}.obs;
  final pressingKey = <LogicalKeyboardKey>{}.obs;

  void addKey(LogicalKeyboardKey key) {
    pressingKey.add(key);
    passingKeyId.add(key.keyId);
  }

  void removeKey(LogicalKeyboardKey key) {
    pressingKey.remove(key);
    passingKeyId.remove(key.keyId);
  }

  void clearKey() {
    pressingKey.clear();
  }

  Future<void> onKeyEvent(
    KeyEvent event,
    Set<UChatKeyboardAction> actionOnKeyPressed,
  ) async {
    if (event is KeyDownEvent) {
      if (!pressingKey.contains(event.logicalKey)) {
        addKey(event.logicalKey);
      }

      for (UChatKeyboardAction actionKey in actionOnKeyPressed) {
        if (actionKey.contains(pressingKey)) {
          actionKey.action();
          clearKey();
        }
      }
    } else if (event is KeyUpEvent) {
      removeKey(event.logicalKey);
    }
  }
}
