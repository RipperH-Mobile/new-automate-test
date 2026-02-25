import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import 'message_type.dart';

final _log = useLogger();

class MessageTypeMobileContactV2Controller extends MessageTypeController {
  MessageTypeMobileContactV2Controller({required super.initMessage});

  void handleViewMobileContact(MobileContactModel? mobileContact) async {
    bool hasPermission = await PermissionController.instance.checkContactsPermission();

    if (!hasPermission || mobileContact == null) {
      return;
    }

    final contact = Contact(
      displayName: mobileContact.displayName!,
      name: Name(first: mobileContact.displayName!),
      phones: [Phone(mobileContact.phoneNumber!)],
    );

    // Insert the contact temporarily
    Contact? insertedContact;

    try {
      insertedContact = await FlutterContacts.insertContact(contact);
    } catch (e) {
      _log.d('insertContact error.', e);
    }

    if (insertedContact == null) {
      return;
    }

    // Open external view
    try {
      await FlutterContacts.openExternalView(insertedContact.id);
    } catch (e) {
      _log.e('Error opening contact.', e);
    } finally {
      // Delete the contact after viewing
      await FlutterContacts.deleteContact(insertedContact);
    }
  }
}
