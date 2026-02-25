import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../features/chat_list/chat_timestamp_display_test.dart' as chat_timestamp_display;
import '../features/chat_list/edit_chat_list_test.dart' as edit_chat_list;
import '../features/chat_list/last_message_preview_display_test.dart' as last_message_preview_display;
import '../features/chat_list/mark_as_read_test.dart' as mark_as_read;
import '../features/chat_list/pin_chat_test.dart' as pin_chat;
import '../features/chat_list/search_chat_test.dart' as search_chat;
import '../features/chat_list/unpin_chat_test.dart' as unpin_chat;
import '../features/chat_list/unread_message_test.dart' as unread_message;
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

  group('Chat timestamp display test scenario', () => chat_timestamp_display.runTests());
  group('Edit chat list test scenario', () => edit_chat_list.runTests());
  group('Last message preview display test scenario', () => last_message_preview_display.runTests());
  group('Mark as read test scenario', () => mark_as_read.runTests());
  group('Pin chat test scenario', () => pin_chat.runTests());
  group('Search chat test scenario', () => search_chat.runTests());
  group('Unpin chat test scenario', () => unpin_chat.runTests());
  group('Unread message test scenario', () => unread_message.runTests());

  tearDownAll(() async {
    debugPrint('🛑 MAIN tearDownAll Called! Disconnecting from MongoDB (Last)...');
    await mongoUtil.disconnectDb();
  });
}
