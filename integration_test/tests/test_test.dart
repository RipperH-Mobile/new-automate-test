import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  setUpAll(() async {
    debugPrint('🪀 MAIN setUpAll Called');
  });
  group('Group A', () {
    patrolTest('Chat and message scenario', ($) async {
      debugPrint('🛑 group 1');
      try {
        throw new Error();
      } catch (e) {
        debugPrint('🛑 group 1 fail');
      }
    });
  });
  group('Group B', () {
    patrolTest('Chat and message scenario', ($) async {
      debugPrint('🛑 group 1');
      try {
        throw new Error();
      } catch (e) {
        debugPrint('🛑 group 1 fail');
      }
    });
  });
  group('Group C', () {
    patrolTest('Casdadsads', ($) async {
      debugPrint('🛑 group 2');
      try {
        throw new Error();
      } catch (e) {
        debugPrint('🛑 group 2 fail');
      }
    });
  });
  tearDownAll(() async {
    debugPrint('🎃 MAIN tearDownAll Called! Disconnecting from MongoDB (Last)...');
  });
}
