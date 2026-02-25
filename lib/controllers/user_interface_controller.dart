import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';

// final _log = useLogger();

const platformUi = MethodChannel('social.uchat/ui');

const bounceTime = Duration(milliseconds: 60);

class UserInterfaceController extends FullLifeCycleController {
  static UserInterfaceController get instance => Get.find();

  final keyboardData = KeyboardUpdateModel(
    height: 0.0,
    type: KeyboardUpdateType.close,
  ).obs;

  @override
  void onInit() async {
    ambiguate(WidgetsBinding.instance)?.addObserver(this);

    platformUi.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'keyboardUpdate':
          try {
            final receivedData = call.arguments as Map<dynamic, dynamic>;

            final receivedKeyboardHeight = receivedData['height'] as double?;
            final receivedType = receivedData['type'] as String?;

            if (receivedKeyboardHeight == null) {
              return;
            }

            // Handle the keyboard height here
            // useLogger().i('D>>> Received keyboard update: ${receivedData["height"]}, ${receivedData["type"]}');

            KeyboardUpdateType type = KeyboardUpdateType.from(receivedType ?? 'RESIZE');
            if ((type.isOpen && keyboardData.value.type.isOpen) || (type.isOpen && keyboardData.value.type.isResize)) {
              type = KeyboardUpdateType.resize;
            }

            // Update the UI or perform actions based on keyboard height
            keyboardData.value = KeyboardUpdateModel(
              height: receivedKeyboardHeight,
              type: type,
            );

            // useLogger().i('D>>> keyboardData: ${keyboardData.value}');

            eventBus.fire(UiKeyboardUpdateEvent(
              keyboardUpdate: keyboardData.value,
            ));

            // minValidOpenedKeyboardHeight is some random magic number. Because native returns non zero value when
            // keyboard is closed. This condition is used to check if the keyboard is actually open or closed.
            // Second condition is to prevent saving the same height multiple times.
            if (receivedKeyboardHeight > ChatRoomInputController.minValidOpenedKeyboardHeight &&
                receivedKeyboardHeight != keyboardData.value.height) {
              GetIt.I<ConfigDb>()
                  .general
                  .saveConfig(key: ConfigDb.getOpenedKeyboardHeightKey(), value: receivedKeyboardHeight);
            }
          } catch (e, stackTrace) {
            useLogger().e('D>>> Keyboard listen error', e, stackTrace);
          }

          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    super.onClose();
  }

// @override
// void didChangeMetrics() {
//   super.didChangeMetrics();
// }
}
