import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../features/chat/chat_message_test.dart' as chat_message;
import '../features/chat/delete_all_message_test.dart' as delete_all_message;
import '../features/chat/delete_message_test.dart' as delete_message;
import '../features/chat/edit_message_test.dart' as edit_message;
import '../features/chat/input_message_test.dart' as input_message;
import '../features/chat/pin_message_test.dart' as pin_message;
import '../features/chat/reply_message_test.dart' as reply_message;
import '../features/chat/search_message_test.dart' as search_message;
import '../features/chat/unpin_message_test.dart' as unpin_message;
import '../features/chat/unsend_message_test.dart' as unsend_message;
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

  group('Chat message test scenario', () => chat_message.runTests());
  group('Delete all message test scenario', () => delete_all_message.runTests());
  group('Delete message test scenario', () => delete_message.runTests());
  group('Edit message test scenario', () => edit_message.runTests());
  group('Input message test scenario', () => input_message.runTests());
  group('Pin message test scenario', () => pin_message.runTests());
  group('Reply message test scenario', () => reply_message.runTests());
  group('Search message test scenario', () => search_message.runTests());
  group('Unpin message test scenario', () => unpin_message.runTests());
  group('Unsend message test scenario', () => unsend_message.runTests());

  tearDownAll(() async {
    debugPrint('🛑 MAIN tearDownAll Called! Disconnecting from MongoDB (Last)...');
    await mongoUtil.disconnectDb();
  });
}
