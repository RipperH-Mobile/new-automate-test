import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/online_status.dart';

abstract class UserInterface {
  String? id;
  String? username;
  String? avatarId;
  String? displayName;
  String? originalStatusMessage;
  String? backgroundId;
  String? birthDate;
  String? email;
  bool? hasPassword;
  OnlineStatus? onlineStatus;

  String get statusMessage;

  set statusMessage(String statusMessage);

  bool get hasAvatar;

  String get avatarUrl;

  @ignore
  String get widgetKey;
}
