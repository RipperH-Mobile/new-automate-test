import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class RejectFriendRequest {
  String friendAccountId;

  RejectFriendRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toMap() {
    return {'friendAccountId': friendAccountId};
  }
}

class RejectFriendResponse {
  ContactCollection? contact;

  RejectFriendResponse({
    this.contact,
  });

  factory RejectFriendResponse.fromMap(Map<String, dynamic> json) {
    ContactCollection contact = ContactCollection.fromMap(json);

    return RejectFriendResponse(contact: contact);
  }
}
