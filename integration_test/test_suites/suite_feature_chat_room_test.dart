import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../features/chat_room/direct_delete_history_chat_test.dart' as direct_delete_history_chat;
import '../features/chat_room/direct_new_chat_test.dart' as direct_new_chat;
import '../features/chat_room/direct_pin_chat_test.dart' as direct_pin_chat;
import '../features/chat_room/group_count_member_test.dart' as group_count_member;
import '../features/chat_room/group_delete_history_chat_test.dart' as group_delete_history_chat;
import '../features/chat_room/group_info_management_test.dart' as group_info_management;
import '../features/chat_room/group_leave_chat_test.dart' as group_leave_chat;
import '../features/chat_room/group_member_management_test.dart' as group_member_management;
import '../features/chat_room/group_new_chat_test.dart' as group_new_chat;
import '../features/chat_room/group_ownership_transfer_test.dart' as group_ownership_transfer;
import '../features/chat_room/group_perm_mention_manage_test.dart' as group_perm_mention_manage;
import '../features/chat_room/group_perm_message_manage_test.dart' as group_perm_message_manage;
import '../features/chat_room/group_perm_set_default_test.dart' as group_perm_set_default;
import '../features/chat_room/group_system_message_test.dart' as group_system_message;
import '../features/chat_room/group_type_setting_test.dart' as group_type_setting;
import '../utils/mongodb/base/base_db.util.dart';

void main() {
  setUpAll(() async {
    debugPrint('🪀 MAIN setUpAll Called');
    if (!dotenv.isInitialized) {
      await dotenv.load(fileName: '.env');
    }
    try {
      await mongoUtil.connectDb();
    } catch (e, stackTrace) {
      debugPrint('---connectDb error ---$e\n$stackTrace');
      rethrow;
    }
  });

  group('Direct delete history chat test scenario', () => direct_delete_history_chat.runTests());
  group('Direct new chat test scenario', () => direct_new_chat.runTests());
  group('Direct pin chat test scenario', () => direct_pin_chat.runTests());
  group('Group count member test scenario', () => group_count_member.runTests());
  group('Group delete history chat test scenario', () => group_delete_history_chat.runTests());
  group('Group info management test scenario', () => group_info_management.runTests());
  group('Group leave chat test scenario', () => group_leave_chat.runTests());
  group('Group member management test scenario', () => group_member_management.runTests());
  group('Group new chat test scenario', () => group_new_chat.runTests());
  group('Group ownership transfer test scenario', () => group_ownership_transfer.runTests());
  group('Group perm mention manage test scenario', () => group_perm_mention_manage.runTests());
  group('Group perm message manage test scenario', () => group_perm_message_manage.runTests());
  group('Group perm set default test scenario', () => group_perm_set_default.runTests());
  group('Group system message test scenario', () => group_system_message.runTests());
  group('Group type setting test scenario', () => group_type_setting.runTests());

  tearDownAll(() async {
    debugPrint('🛑 MAIN tearDownAll Called! Disconnecting from MongoDB (Last)...');
    await mongoUtil.disconnectDb();
  });
}
