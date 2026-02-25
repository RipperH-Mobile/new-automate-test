import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:uchat/widgets.dart';
import '../utils/common.util.dart';

class ChatMessagePage {
  Future<void> proceedAddFriend($, phoneNumber) async {
    await $.pump();
    final appBarFinder = find.byType(AppBar);
    final svgIconFinder = find.byType(SvgPicture);
    final buttonInAppBarFinder = find.descendant(of: appBarFinder, matching: svgIconFinder);
    expect(buttonInAppBarFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: buttonInAppBarFinder);
    //await $.pumpAndSettle();
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Search');
    await CommonUtil.tapButton($, targetNameButton: 'Phone Number');
    await $.pump(const Duration(seconds: 1));
    final expandedFinder = find.byType(SearchBox);
    final textInput = find.byType(TextField);
    final phoneInputFinder = find.descendant(of: expandedFinder, matching: textInput);
    await $(phoneInputFinder).enterText(phoneNumber);
    //await $.native.pressBack();
    await $.pump(const Duration(seconds: 2));
    await CommonUtil.tapButton($, targetNameButton: 'Add friend');
    await $("Chat").waitUntilExists();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
  }

  Future<void> proceedDeleteFriend($, friendName) async {
    await $.pump();
    final friendNameFinder = find.textContaining(friendName);
    await CommonUtil.tapButtonLongPressV1($, targetNameButton: friendNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Delete');
    await $.pump();
    final cupertinoAlertDialogFinder = find.byType(CupertinoAlertDialog);
    final deleteInputFinder = find.descendant(of: cupertinoAlertDialogFinder, matching: find.text('Delete'));
    await CommonUtil.tapButton($, targetNameButton: deleteInputFinder);
    await $.pump();

    await CommonUtil.tapButton($, targetNameButton: TextField);
    await $.pumpAndSettle();
    await $(TextField).enterText(friendName);
    await $.pump();
    await $.native.pressBack();
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Friends');
    await $.pump();
  }

  Future<void> proceedChatWithMessage($, isGroup, friendName, targetMessage) async {
    await $.pump();
    final friendNameFinder = find.textContaining(friendName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonText = isGroup ? 'Send message' : 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);

    // await $.pumpAndSettle();
    // await $.pump();
    // if (isGroup) {
    //   await CommonUtil.tapButton($, targetNameButton: 'Send message');
    // } else {
    //   await CommonUtil.tapButton($, targetNameButton: 'Chat');
    // }
    // await $.pumpAndSettle();

    await $(TextField).enterText(targetMessage);
    final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/send.svg';
      }
      return false;
    });
    expect(sendSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
    //await $.pumpAndSettle();
    await $.pump();

    // SliverList >> Row (root)
    // time to send >> MessageStatusV2 >> text
    // message >> MessageTypeRegularText >> text

    // final rowFinder = find.descendant(
    //   of: find.byType(Column),
    //   matching: find.byType(MessageTypeRegularText),
    // );
    // await $.pumpAndSettle();
    // await $(MessageTypeRegularText).waitUntilExists(timeout: Duration(seconds: 10));
    // expect(find.byType(MessageTypeRegularText), findsNWidgets(9));

    // const targetMessageText = 'Hello';
    // final allMessageBubbles = $(SliverList);
    // await allMessageBubbles.waitUntilExists();
    // print('Found ${await allMessageBubbles.length} message bubbles.');
    // PatrolFinder? targetBubble;
    // for (var i = 0; i < await allMessageBubbles.length; i++) {
    //   final currentBubble = allMessageBubbles.at(i);
    //   if (await currentBubble.descendant(find.text(targetMessageText)).exists) {
    //     print('Found target message: "$targetMessageText"');
    //     targetBubble = currentBubble;
    //     break;
    //   }
    // }
    // expect(targetBubble, isNotNull, reason: 'Target message was not found');
    //await $.native.pressBack();

    final backSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_arrow_app_bar.svg';
      }
      return false;
    });
    await CommonUtil.tapButton($, targetNameButton: backSvgFinder);
    //await CommonUtil.tapButton($, targetNameButton: IconButton);
    //await $.pumpAndSettle();
  }
}
