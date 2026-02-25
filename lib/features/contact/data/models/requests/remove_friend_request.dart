import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class RemoveFriendRequest {
  String friendAccountId;

  RemoveFriendRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toMap() {
    return {'friendAccountId': friendAccountId};
  }
}

class RemoveFriendResponse {
  ContactCollection? contact;

  RemoveFriendResponse({
    this.contact,
  });

  factory RemoveFriendResponse.fromMap(Map<String, dynamic> json) {
    ContactCollection contact = ContactCollection.fromMap(json);

    return RemoveFriendResponse(contact: contact);
  }
}
