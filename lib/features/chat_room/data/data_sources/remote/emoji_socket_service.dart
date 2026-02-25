import 'dart:async';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';

class EmojiSocketService {
  EmojiSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<PaginationPayload<EmojiPackageWithItemsEntity>?> getEmojiPackagesItems(
      GetEmojiPackageItemsRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.getEmojiPackages.socket,
      request.toMap(),
    );

    return res.mapToResponse((e) {
      return PaginationPayload<EmojiPackageWithItemsEntity>.fromMapV3(
        e,
        listMapper: (data) => (data).map((item) => EmojiPackageWithItemsEntity.fromMap(item)).toList(),
      );
    });
  }

  Future<PaginationPayload<EmojiPackageEntity>?> getEmojiPackages(GetEmojiPackagesRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.getEmojiPackages.socket,
      request.toMap(),
    );
    return res.mapToResponse((e) {
      return PaginationPayload<EmojiPackageEntity>.fromMapV3(
        e,
        listMapper: (data) => (data).map((item) => EmojiPackageEntity.fromMap(item)).toList(),
      );
    });
  }

  Future<UpdateDefaultEmojiEntity?> setDefaultEmoji(UpdateDefaultEmojiRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.setDefaultEmoji.socket,
      request.toMap(),
    );

    return res.mapToResponseV3<UpdateDefaultEmojiEntity>(
      (result) => UpdateDefaultEmojiEntity.fromMap(result),
    );
  }
}
