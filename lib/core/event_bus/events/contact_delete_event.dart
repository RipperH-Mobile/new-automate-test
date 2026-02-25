import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class ContactDeleteEvent {
  ContactCollection contact;

  ContactDeleteEvent({required this.contact});

  @override
  String toString() => 'ContactDeleteEvent(contact: $contact)';
}
