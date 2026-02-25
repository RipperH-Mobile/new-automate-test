import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/row_menu/uchat_switch_row_menu.dart';
import '../utils/common.util.dart';

class GroupInfoPage {
  Future<void> proceedSetGroupPerm($, groupPermissionsByMap) async {
    await CommonUtil.tapButton($, targetNameButton: 'Group permissions');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump(const Duration(seconds: 2));
    await CommonUtil.tapButton($, targetNameButton: 'Group permissions');
    await $.pump();
    if (groupPermissionsByMap.isNotSendMessages) {
      final targetFinder = find.ancestor(of: find.text('Send messages'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotSendMedia) {
      final targetFinder = find.ancestor(of: find.text('Send media'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotMentionAll) {
      final targetFinder = find.ancestor(of: find.text('Mention @all'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotEditTheirOwnSentMessage) {
      final targetFinder =
          find.ancestor(of: find.text('Edit their own sent messages'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotUnsendTheirOwnSentMessages) {
      final targetFinder =
          find.ancestor(of: find.text('Unsend their own sent messages'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotUseEmojiReactions) {
      final targetFinder =
          find.ancestor(of: find.text('Use emoji reactions'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isNotAddDeleteAlbumInGroup) {
      final targetFinder =
          find.ancestor(of: find.text('Add / Delete album in group'), matching: find.byType(UChatSwitchRowMenu));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
      await $.pump();
    }
    if (groupPermissionsByMap.isSetToDefault) {
      await CommonUtil.tapButton($, targetNameButton: 'Set to default');
      await $.pump();
    }
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump(const Duration(seconds: 2));
  }

  Future<void> proceedEnableGroupPerm($) async {
    await CommonUtil.tapButton($, targetNameButton: 'Group permissions');
    await $.pump();
    final targetFinder = find.ancestor(
      of: find.text('Customizable Permissions Settings'),
      matching: find.byType(UChatSwitchRowMenu),
    );
    await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump(const Duration(seconds: 2));
  }
}
