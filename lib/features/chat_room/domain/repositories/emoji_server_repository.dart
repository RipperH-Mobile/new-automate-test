import 'dart:async';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';

abstract class EmojiServerRepository {
  Future<PaginationPayload<EmojiPackageWithItemsEntity>> getEmojiPackagesItems(GetEmojiPackageItemsRequest request);

  Future<PaginationPayload<EmojiPackageEntity>> getEmojiPackages(GetEmojiPackagesRequest request);

  Future<UpdateDefaultEmojiEntity> updateDefaultEmoji(UpdateDefaultEmojiRequest request);
}
