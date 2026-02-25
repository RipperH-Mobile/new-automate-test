import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class SearchContactRequest {
  String username;
  String type;

  SearchContactRequest({
    required this.username,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    if (type == 'PHONE') {
      return {'phoneNumber': username, 'type': type};
    }

    return {'username': username, 'type': type};
  }
}

class SearchContactResponse {
  ContactEntity? contact;

  SearchContactResponse({
    this.contact,
  });

  factory SearchContactResponse.fromMap(Map<String, dynamic> json) {
    ContactEntity contact = ContactEntity.fromMap(json);

    return SearchContactResponse(contact: contact);
  }
}
