part of 'uchat_keyboard_listener.dart';

class UChatKeyboardAction {
  final List<Set<LogicalKeyboardKey>> keys;
  final VoidCallback action;

  UChatKeyboardAction({
    required this.keys,
    required this.action,
  });

  bool contains(Set<LogicalKeyboardKey> pressedKeys) {
    for (var i = 0; i < keys.length; i++) {
      final key = keys[i];
      if (key.deepEquals(pressedKeys)) {
        return true;
      }
    }

    return false;
  }
}
