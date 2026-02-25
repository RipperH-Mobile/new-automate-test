import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';

class SelectMemberArguments {
  final List<RoomContactModel> contactAndGroupList;
  final List<RoomMemberCollection> roomMember;
  final List<RoomDetailMemberAndPendingModel> roomDetailMemberList;
  final bool isManageFolder;
  final bool fromRoomScreen;
  final bool fromSendContact;
  final bool fromRoomDetailInvite;
  final ChatFolderEntity? chatFolderCollection;
  final String? roomId;

  SelectMemberArguments({
    this.contactAndGroupList = const [],
    this.roomMember = const [],
    this.roomDetailMemberList = const [],
    this.isManageFolder = false,
    this.fromRoomScreen = false,
    this.fromSendContact = false,
    this.fromRoomDetailInvite = false,
    this.chatFolderCollection,
    this.roomId = '',
  });
}
