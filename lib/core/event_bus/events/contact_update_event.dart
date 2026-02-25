import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class ContactUpdateEvent {
  ContactCollection contact;

  ContactUpdateEvent({required this.contact});

  @override
  String toString() => 'ContactUpdateEvent(contact: $contact)';
}
