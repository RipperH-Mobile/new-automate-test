import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/deleted_by_account_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_video_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';
import 'package:uchat/features/chat_room_list/data/models/room_recent_search_model.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'recent_search_collection.g.dart';

@Collection(accessor: 'recentSearch')
@Name('RecentSearch')
class RecentSearchCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  String? keyword;

  RoomRecentSearchModel? room;

  ContactModel? contact;

  @Enumerated(EnumType.name)
  RecentSearchType? type;

  @Index()
  DateTime? createdAt;

  RecentSearchCollection({
    this.id,
    this.keyword,
    this.room,
    this.contact,
    this.type,
    this.createdAt,
  });

  @override
  bool operator ==(Object other) {
    return other is RecentSearchCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;
}
