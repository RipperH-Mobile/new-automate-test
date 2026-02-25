import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class AddContactRequest {
  String friendAccountId;

  AddContactRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toMap() {
    return {'friendAccountId': friendAccountId};
  }
}

class AddContactResponse {
  final ContactCollection contact;

  AddContactResponse({
    required this.contact,
  });

  factory AddContactResponse.fromMap(Map<String, dynamic> json) {
    final ContactCollection contact = ContactCollection.fromMap(json);

    return AddContactResponse(contact: contact);
  }
}
