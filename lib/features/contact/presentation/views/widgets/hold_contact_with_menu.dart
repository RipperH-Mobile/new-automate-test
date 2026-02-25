import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/hold_widget_with_menu.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class HoldContactWithMenu {
  /// Show the HoldContactWithMenu dialog.
  ///
  /// - [contact] is the contact.
  /// - [menuItems] is the list of menu list items.
  static Future<void> show<T>(T contact, List<MenuListItem> menuItems) async {
    String? contactId;
    if (contact is ContactInterface) {
      contactId = contact.id;
    } else if (contact is RoomCollection) {
      contactId = contact.id;
    }
    if (contactId == null) {
      return;
    }

    await HoldWidgetWithMenu.show(
      ContactListItem<T>(
        customBackgroundColor: Get.theme.appColors.backgroundNeutralLighter,
        data: contact,
        showStatusMessage: true,
        isPopUp: true,
        heroTag: 'hold_contact_with_menu_hero-$contactId',
      ),
      menuItems,
      barrierLabel: 'hold_contact_with_menu',
    );
  }
}
