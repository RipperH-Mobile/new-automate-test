import 'package:uchat/entities/enum/album_role_type.dart';

class UpdateUserAlbumRoleRequest {
  final String albumId;
  final String accountId;
  final AlbumRoleType albumRoleType;

  UpdateUserAlbumRoleRequest({
    required this.albumId,
    required this.accountId,
    required this.albumRoleType,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'accountId': accountId,
      'albumRoleType': albumRoleType.value,
    };
  }
}
