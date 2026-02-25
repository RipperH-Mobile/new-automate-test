import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';

class RichMenuUpdateEvent {
  final String accountId;
  final RichMenuModel? richMenu;

  RichMenuUpdateEvent({
    required this.accountId,
    required this.richMenu,
  });
}
