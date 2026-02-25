import 'package:enum_to_string/enum_to_string.dart';
import 'package:recase/recase.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

final _log = useLogger();

enum SocketCallType {
  acceptCallNotification,
  declineCallNotification,
  ringingCallNotification,
  callNotification,
  ringingTimeoutCallNotification,
  cancelCallNotification,
}

class RoomCallModel {
  String? liveKitRoomSID;

  ///
  /// Is `RoomCallId`.
  ///
  String? id;
  SocketCallType? type;
  String? title;
  String? liveKitToken;
  String? roomId;
  RoomType? roomType;
  CallType? callType;
  String? imageUrl;
  DateTime? createdAt;
  String? callOnSessionKeyId;
  bool? anotherSession;
  String? roomCallId;

  /// incoming call kit if [roomCallId] is null.
  /// using [roomCallIdChain] to mange call kit.
  String? roomCallIdChain;
  String? imageBlurHash;
  bool? isCancel;
  CallState? callState;
  CallConnectionType? callConnectionType;
  DateTime? startCallAt;

  RoomCallModel({
    this.liveKitRoomSID,
    this.id,
    this.type,
    this.title,
    this.liveKitToken,
    this.roomId,
    this.roomType,
    this.callType,
    this.imageUrl,
    this.createdAt,
    this.callOnSessionKeyId,
    this.anotherSession,
    this.roomCallId,
    this.imageBlurHash,
    this.isCancel,
    this.callState = CallState.idle,
    this.callConnectionType = CallConnectionType.accept,
    this.roomCallIdChain,
    this.startCallAt,
  });

  factory RoomCallModel.generateDirectCall(
    RoomCollection room,
    CallType callType,
  ) {
    return RoomCallModel(
      imageBlurHash: room.photoBlurhash ?? '',
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: room.id,
      callType: callType,
      roomType: room.roomType,
      title: room.title,
      imageUrl: room.roomAvatarUrl,
      liveKitToken: '',
      callConnectionType: CallConnectionType.start,
    );
  }

  factory RoomCallModel.generateStartGroupCall(
    RoomCollection room,
    CallType callType,
  ) {
    return RoomCallModel(
      imageBlurHash: room.photoBlurhash ?? '',
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: room.id,
      callType: callType,
      roomType: room.roomType,
      title: room.title,
      imageUrl: room.roomAvatarUrl,
      liveKitToken: '',
      callConnectionType: CallConnectionType.startGroup,
    );
  }

  factory RoomCallModel.generateAnswerCall(
    RoomCollection room,
    CallType callType,
  ) {
    return RoomCallModel(
      imageBlurHash: room.photoBlurhash ?? '',
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: room.id,
      callType: callType,
      roomType: room.roomType,
      title: room.title,
      imageUrl: room.roomAvatarUrl,
      liveKitToken: '',
      callConnectionType: CallConnectionType.accept,
    );
  }

  factory RoomCallModel.generateJoinGroupCall(
    RoomCollection room,
    CallType callType,
  ) {
    return RoomCallModel(
      imageBlurHash: room.photoBlurhash ?? '',
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: room.id,
      callType: callType,
      roomType: room.roomType,
      title: room.title,
      imageUrl: room.roomAvatarUrl,
      liveKitToken: '',
      callConnectionType: CallConnectionType.joinGroup,
    );
  }

  factory RoomCallModel.fromMap(Map<String, dynamic> json) {
    _log.d('SocketRoomCallModel from map $json');
    SocketCallType? stateType;
    if (json['type'] != null) {
      final String type = json['type'];
      stateType = EnumToString.fromString(
        SocketCallType.values,
        type.camelCase,
      );
    }
    DateTime? tempDateTime;
    if (json['createdAt'] != null) {
      tempDateTime = DateTime.tryParse(json['createdAt']);
    }

    DateTime? tempStartCallAt;
    if (json['startCallAt'] != null) {
      tempStartCallAt = DateTime.tryParse(json['startCallAt']);
    }

    RoomType? roomType;
    if (json['roomType'] is String) {
      roomType = RoomType.from(json['roomType']);
    } else if (json['roomType'] is RoomType) {
      roomType = json['roomType'];
    }

    CallType? callType;
    if (json['callType'] is String) {
      callType = CallType.fromString(json['callType']);
    } else if (json['callType'] is CallType) {
      callType = json['callType'];
    }

    final roomCallModel = RoomCallModel(
      id: json['roomCallId'] ?? json['uuid'],
      liveKitRoomSID: json['roomCallId'],
      type: stateType ?? SocketCallType.callNotification,
      title: json['title'],
      liveKitToken: json['liveKitToken'],
      roomId: json['roomId'],
      roomType: roomType,
      callType: callType,
      imageUrl: json['imageUrl'],
      createdAt: tempDateTime ?? DateTime.now(),
      callOnSessionKeyId: json['callOnSessionKeyId'],
      roomCallId: json['roomCallId'],
      imageBlurHash: json['imageBlurhash'],
      isCancel: json['isCancel'],
      startCallAt: tempStartCallAt,
      callConnectionType: json['callConnectionType'] ?? CallConnectionType.accept,
    );

    if (json['anotherSession'] != null) {
      final aSessionCheck = json['anotherSession'].toString().toLowerCase() == 'true';
      roomCallModel.anotherSession = aSessionCheck ? true : false;
    }
    _log.d('SocketRoomCallModel anotherSession before return ${roomCallModel.anotherSession}');

    return roomCallModel;
  }

  @override
  bool operator ==(covariant RoomCallModel other) {
    if (identical(this, other)) return true;

    return other.liveKitRoomSID == liveKitRoomSID;
  }

  @override
  int get hashCode {
    return liveKitRoomSID.hashCode ^
        id.hashCode ^
        type.hashCode ^
        title.hashCode ^
        liveKitToken.hashCode ^
        roomId.hashCode ^
        roomType.hashCode ^
        callType.hashCode ^
        imageUrl.hashCode ^
        createdAt.hashCode ^
        callOnSessionKeyId.hashCode ^
        roomCallId.hashCode ^
        anotherSession.hashCode;
  }

  @override
  String toString() {
    return ' liveKitRoomSID: $liveKitRoomSID \n'
        'id: $id \n'
        'type: ${type.toString()} \n'
        'title: $title \n'
        'liveKitToken: $liveKitToken \n'
        'roomId: $roomId \n'
        'roomType: $roomType \n'
        'callType: $callType \n'
        'imageUrl: $imageUrl \n'
        'createdAt: $createdAt \n'
        'callOnSessionKeyId: $callOnSessionKeyId \n'
        'id (roomCallId): $id \n'
        'liveKitRoomSID (roomCallId): $liveKitRoomSID \n'
        'roomCallId: $roomCallId \n'
        'isCancel: $isCancel \n'
        'callState: ${callState.toString()} \n'
        'callConnectionType: ${callConnectionType.toString()} \n'
        'anotherSession: $anotherSession \n';
  }
}
