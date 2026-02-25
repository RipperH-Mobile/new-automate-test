import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class RecentSearchModel {
  RoomCollection room;
  ContactModel contact;

  RecentSearchModel({required this.room, required this.contact});
}
