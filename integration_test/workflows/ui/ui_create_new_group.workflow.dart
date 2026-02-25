import 'package:flutter_test/flutter_test.dart';
import '../../utils/common.util.dart';

class UiCreateNewGroupWorkflow {
  Future<void> proceedCreateGroup($, String addMemberDetail, String groupName) async {
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    await CommonUtil.tapCreateNewGroup($);
    await $.pump();

    // Select Members
    List<String> members = addMemberDetail.split('|');
    for (var member in members) {
      if (member.isEmpty) continue;
      final friendNameFinder = find.textContaining(member);
      await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    }

    await CommonUtil.tapButton($, targetNameButton: 'Next');
    await $.pump();

    // Set Group Name
    await CommonUtil.fillTextInput($, targetNameInput: 'Enter your group name', text: groupName);
    await CommonUtil.tapButton($, targetNameButton: 'Create');
    await $.pump();

    // Verify Group Created and Go Back
    await $(find.textContaining(groupName)).waitUntilExists();
    await CommonUtil.tapIconBack($);
    await $.pump();
  }
}
