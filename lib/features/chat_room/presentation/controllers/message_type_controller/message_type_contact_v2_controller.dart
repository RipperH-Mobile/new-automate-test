import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/profile/service/profile_service.dart';

import 'message_type.dart';

class MessageTypeContactV2Ids {
  static const String all = 'message_type_contact_v2_all';
}

class MessageTypeContactV2Controller extends MessageTypeController {
  String? nickname;

  MessageTypeContactV2Controller({
    required super.initMessage,
  });

  @override
  void onInit() async {
    final contactId = initMessage.contact?.id;
    if (contactId != null) {
      final localContact = await GetIt.I<ContactLocalRepository>().getContact(contactId);
      if (localContact?.nickname?.isNotEmpty == true) {
        nickname = localContact?.nickname;
        update([MessageTypeContactV2Ids.all]);
      }
    }

    super.onInit();
  }

  Future<void> onViewContact() async {
    final contactId = initMessage.contact?.id;
    if (contactId != null) {
      GetIt.I<ProfileService>().openProfileScreen(
        contactId: contactId,
      );
    }
  }
}
