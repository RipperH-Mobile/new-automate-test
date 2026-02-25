import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class ContactSearchResultModel {
  ContactCollection? contact;
  RoomCollection? room;

  ContactSearchResultModel({
    this.contact,
    this.room,
  });
}
