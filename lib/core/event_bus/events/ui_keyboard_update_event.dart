import 'package:uchat/entities/models.dart';

class UiKeyboardUpdateEvent {
  KeyboardUpdateModel keyboardUpdate;

  UiKeyboardUpdateEvent({
    required this.keyboardUpdate,
  });

  @override
  String toString() => 'UiKeyboardUpdateEvent(keyboardUpdate: $keyboardUpdate)';
}
