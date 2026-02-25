import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class InitStateContactsRequest {
  int page;
  int pageSize;

  InitStateContactsRequest({
    required this.page,
    this.pageSize = 100,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
    };
  }
}

class InitStateContactsResponse {
  ContactCollection? contact;

  InitStateContactsResponse({
    this.contact,
  });

  factory InitStateContactsResponse.fromJson(Map<String, dynamic> json) {
    return InitStateContactsResponse(
      contact: ContactCollection.fromMap(json),
    );
  }
}
