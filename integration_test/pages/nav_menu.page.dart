import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../utils/common.util.dart';

class NavMenuPage {
  Future<void> tapProfile($) async {
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(
      of: parentPopupMenuFinder,
      matching: find.byType(ListTile),
    );
    final targetProfileFinder = find.descendant(
      of: targetTextFinder,
      matching: find.byType(CircleAvatar),
    );
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pumpAndSettle();
  }
}
