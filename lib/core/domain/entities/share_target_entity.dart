import 'package:webcrypto/webcrypto.dart';

class ShareTargetEntity {
  String name;
  String roomId;
  String? avatarUrl;
  String? status;
  bool? isOa;
  int? groupMemberCount;
  AesGcmSecretKey? roomCryptoKey;
  String? contactId;

  ShareTargetEntity({
    required this.name,
    required this.roomId,
    this.avatarUrl,
    this.status,
    this.isOa,
    this.groupMemberCount,
    this.roomCryptoKey,
    this.contactId,
  });

  bool isSameTarget(ShareTargetEntity other) {
    if (roomId.isNotEmpty && roomId == other.roomId) {
      return true;
    }
    if (contactId != null && contactId == other.contactId) {
      return true;
    }
    return false;
  }
}
