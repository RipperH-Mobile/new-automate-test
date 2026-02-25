import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/domain/params/set_room_theme_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/set_room_theme_use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class ChatRoomDetailThemeController extends GetxController {
  final String tag;

  ChatRoomDetailThemeController({
    required this.tag,
  });

  final RxInt selected = 1.obs;

  @override
  void onInit() {
    // First try to load from an already registered ChatRoomController
    if (Get.isRegistered<ChatRoomController>(tag: tag)) {
      final chatRoomController = Get.find<ChatRoomController>(tag: tag);
      selected.value = chatRoomController.roomTheme.value;
      _log.d('Initialized selected theme from ChatRoomController: ${selected.value}');
    } else {
      // Load from the database if not already loaded via ChatRoomController
      loadRoomThemeFromDb();
    }

    super.onInit();
  }

  Future<void> loadRoomThemeFromDb() async {
    final currentAccountId = UserController.instance.currentUser.value?.id;
    if (currentAccountId == null) {
      _log.e('Current account ID is null. Cannot proceed with theme change.');
      return;
    }
    final roomSub = await GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionByRoomAndAccount(tag, currentAccountId);
    if (roomSub != null && roomSub.theme != null) {
      selected.value = roomSub.theme!;
      _log.d('Loaded room theme from DB for account $currentAccountId: ${selected.value}');
    } else {
      selected.value = 1; // fallback/default theme
      _log.d('No room theme found in DB; using default theme for account $currentAccountId');
    }
  }

  void onDonePressed() async {
    try {
      await GetIt.I<SetRoomThemeUseCase>().call(SetRoomThemeParams(
        roomId: tag,
        theme: selected.value.toString(),
      ));
      String theme = 'white';
      if (selected.value == 1) {
        theme = 'white';
      } else if (selected.value == 2) {
        theme = 'blue';
      } else {
        theme = 'black';
      }
      GetIt.I<TaxonomyService>()
          .sendEvent(EventName.changeThemeSuccessfully, eventProperties: EventProperty.changeThemeSuccessfully(theme));
      Get.back();
    } catch (e, stackTrace) {
      _log.e('onDonePressed error.', e, stackTrace);
    }
  }
}
