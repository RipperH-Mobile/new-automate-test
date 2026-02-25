import 'package:uchat/features/add_contact/data/model/add_contact_account_model.dart';
import 'package:uchat/utils/datetime.dart';

class AddContactRoomMemberModel {
  String? accountId;

  String? role;

  DateTime? lastSeenMessageAt;

  DateTime? lastSeenAt;

  String? roomId;

  bool? isRoomDeleted;

  AddContactAccountModel? account;

  AddContactRoomMemberModel({
    this.accountId,
    this.roomId,
    this.role,
    this.lastSeenMessageAt,
    this.lastSeenAt,
    this.isRoomDeleted,
    this.account,
  });

  // Convert from json to model
  factory AddContactRoomMemberModel.fromMap(Map<String, dynamic> data) {
    return AddContactRoomMemberModel(
      accountId: data['accountId'],
      roomId: data['roomId'],
      role: data['role'],
      lastSeenMessageAt: strToDateTime(data['lastSeenMessageAt']),
      lastSeenAt: strToDateTime(data['lastSeenAt']),
      isRoomDeleted: data['isRoomDeleted'],
      account: AddContactAccountModel.fromMap(data['account']),
    );
  }
}
