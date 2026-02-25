import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/models/models/deleted_by_account_model.dart';

part 'message_meta_model.g.dart';

final _log = useLogger();

@embedded
class MessageMetaModel {
  String? stickerPack = '';

  @override
  String toString() {
    return 'MessageMetaModel{stickerPublisher : $stickerPublisher , stickerPack: $stickerPack, stickerValue: $stickerValue, stickerEmoji: $stickerEmoji, stickerName: $stickerName, stickerDescription: $stickerDescription, stickerCoverId: $stickerCoverId, stickerPrice: $stickerPrice, gifUrl: $gifUrl, gifMp4Url: $gifMp4Url, gifWebpUrl: $gifWebpUrl, giphyId: $giphyId, gifWidth: $gifWidth, gifHeight: $gifHeight, albumName: $albumName, locationLng: $locationLng, locationName: $locationName, locationFormattedAddress: $locationFormattedAddress, locationPlacesId: $locationPlacesId, locationVicinity: $locationVicinity, locationImgBlurhash: $locationImgBlurhash, locationImgId: $locationImgId, locationLat: $locationLat, albumId: $albumId, albumTasks: $albumTasks, isCreatedAlbum: $isCreatedAlbum, lockMessageSalt: $lockMessageSalt, lockMessageIv: $lockMessageIv, lockMessageData: $lockMessageData}';
  }

  String? stickerPublisher;
  String? stickerValue = '';
  String? stickerEmoji;
  String? stickerName;
  String? stickerDescription;
  String? stickerCoverId;
  double stickerPrice;
  String? gifUrl = '';
  String? gifMp4Url = '';
  String? gifWebpUrl = '';
  String? giphyId = '';
  double? gifWidth = 0.0;
  double? gifHeight = 0.0;
  String? albumName;
  double? locationLng;
  String? locationName;
  String? locationFormattedAddress;
  String? locationPlacesId;
  String? locationVicinity;
  String? locationImgBlurhash;
  String? locationImgId;
  double? locationLat;
  DateTime? deletedAt;
  DeletedByAccountModel? deletedBy;
  String? albumId;
  AlbumTaskModel? albumTasks;

  // TODO (album) Unused variable. Remove this.
  @Deprecated('Unused variable.')
  bool? albumIsCreateOnly;

  /// Is this a message type album for creating a new album.
  /// Will be true if this is the message to notify that the album is created.
  /// Will be false if this is the message to notify that user upload new image to the album.
  bool? isCreatedAlbum;
  String? lockMessageSalt;
  String? lockMessageIv;
  String? lockMessageData;
  bool? isEmoji;
  bool? isRegEx;

  MessageMetaModel({
    this.stickerPublisher,
    this.stickerPack,
    this.stickerValue,
    this.stickerEmoji,
    this.gifUrl,
    this.gifWebpUrl,
    this.giphyId,
    this.gifMp4Url,
    this.gifWidth,
    this.gifHeight,
    this.albumName,
    this.albumId,
    this.albumTasks,
    this.albumIsCreateOnly,
    this.deletedAt,
    this.deletedBy,
    this.isCreatedAlbum,
    this.locationLat,
    this.locationLng,
    this.locationName,
    this.locationFormattedAddress,
    this.locationPlacesId,
    this.locationVicinity,
    this.locationImgBlurhash,
    this.locationImgId,
    this.stickerName,
    this.stickerDescription,
    this.stickerCoverId,
    this.stickerPrice = 0,
    this.lockMessageSalt,
    this.lockMessageIv,
    this.lockMessageData,
    this.isEmoji,
    this.isRegEx,
  });

  factory MessageMetaModel.fromMap(Map<String, dynamic> json) {
    // _log.i('Message meta JSON log: $json');

    double? gifWidth;
    if (json['gifWidth'] is int) {
      gifWidth = (json['gifWidth'] as int).toDouble();
    } else if (json['gifWidth'] is String) {
      gifWidth = double.parse(json['gifWidth'] as String);
    } else if (json['gifWidth'] is double) {
      gifWidth = json['gifWidth'] as double;
    }

    double? gifHeight;
    if (json['gifHeight'] is int) {
      gifHeight = (json['gifHeight'] as int).toDouble();
    } else if (json['gifHeight'] is String) {
      gifHeight = double.parse(json['gifHeight'] as String);
    } else if (json['gifHeight'] is double) {
      gifHeight = json['gifHeight'] as double;
    }

    AlbumTaskModel? albumTasks;
    if (json['albumTasks'] is Map<String, dynamic>) {
      try {
        albumTasks = AlbumTaskModel.fromMap(json['albumTasks']);
      } catch (e, stackTrace) {
        _log.e(
          'AlbumTasks, albumTasks in message meta model is failed.',
          e,
          stackTrace,
        );
      }
    }
    double tempStickerPrice = 0;
    if (json['stickerPrice'] != null) {
      tempStickerPrice = double.tryParse(json['stickerPrice'].toString()) ?? 0;
    }
    // _log.i('gifHeight: $gifHeight');
    // _log.i('gifWidth: $gifWidth');

    DateTime? deletedAt;
    if (json['deletedAt'] != null) {
      deletedAt = DateTime.parse(json['deletedAt']);
    }

    DeletedByAccountModel? deletedBy;
    if (json['deletedBy'] != null) {
      deletedBy = DeletedByAccountModel.fromMap(json['deletedBy']);
    }

    return MessageMetaModel(
      stickerPublisher: json['stickerPublisher'],
      stickerPack: json['stickerPack'],
      stickerValue: json['stickerValue'],
      stickerName: json['stickerName'],
      stickerDescription: json['stickerDescription'],
      stickerCoverId: json['stickerCoverId'],
      stickerPrice: tempStickerPrice,
      stickerEmoji: json['stickerEmoji'],
      gifUrl: json['gifUrl'],
      gifMp4Url: json['gifMp4Url'],
      gifWebpUrl: json['gifWebpUrl'],
      giphyId: json['giphyId'],
      gifWidth: gifWidth,
      gifHeight: gifHeight,
      albumName: json['albumName'],
      albumId: json['albumId'],
      albumTasks: albumTasks,
      albumIsCreateOnly: json['albumIsCreateOnly'],
      deletedAt: deletedAt,
      deletedBy: deletedBy,
      isCreatedAlbum: json['isCreatedAlbum'],
      locationLat: json['locationLat'],
      locationLng: json['locationLng'],
      locationName: json['locationName'],
      locationFormattedAddress: json['locationFormattedAddress'],
      locationPlacesId: json['locationPlacesId'],
      locationVicinity: json['locationVicinity'],
      locationImgBlurhash: json['locationImgBlurhash'],
      locationImgId: json['locationImgId'],
      lockMessageSalt: json['lockMessageSalt'],
      lockMessageIv: json['lockMessageIv'],
      lockMessageData: json['lockMessageData'],
      isEmoji: json['isEmoji'],
      isRegEx: json['isRegEx'],
    );
  }

  toMap() {
    return {
      'stickerPublisher': stickerPublisher,
      'stickerPack': stickerPack,
      'stickerValue': stickerValue,
      'stickerName': stickerName,
      'stickerDescription': stickerDescription,
      'stickerCoverId': stickerCoverId,
      'stickerPrice': stickerPrice,
      'gifUrl': gifUrl,
      'gifMp4Url': gifMp4Url,
      'gifWebpUrl': gifWebpUrl,
      'giphyId': giphyId,
      'gifWidth': gifWidth,
      'gifHeight': gifHeight,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'locationName': locationName,
      'locationFormattedAddress': locationFormattedAddress,
      'locationPlacesId': locationPlacesId,
      'locationVicinity': locationVicinity,
      'locationImgBlurhash': locationImgBlurhash,
      'locationImgId': locationImgId,
      'lockMessageSalt': lockMessageSalt,
      'lockMessageIv': lockMessageIv,
      'lockMessageData': lockMessageData,
      'isEmoji': isEmoji,
      'isRegEx': isRegEx,
      'deletedAt': deletedAt.toString(),
    };
  }
}
