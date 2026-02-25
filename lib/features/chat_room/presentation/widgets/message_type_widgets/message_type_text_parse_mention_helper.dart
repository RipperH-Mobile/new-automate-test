import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_one_member_in_any_room_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_in_any_room_sync_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';

// final _log = useLogger();

const String mentionRegexPattern = UChatConstant.mentionRegexPattern;
const String lessMoreRegexPattern = UChatConstant.lessMoreRegexPattern;

/// Data/userId send in mention all pattern
/// @All message Example : [__0__](__All__).
const String mentionAllUserId = '0';
const String lessMoreId = '1';

extension FlutterMentionMarkup on String {
  Map<String, String> markupToDisplayRegExHelper({
    String pattern = mentionRegexPattern,
  }) {
    UserController userController = UserController.instance;
    Map<String, String> map = <String, String>{};
    RegExp customRegExp = RegExp(pattern);
    RegExpMatch match = customRegExp.firstMatch(this)!;

    var displayNameIndex = 3;
    var valueIndex = 2;
    var userId = match.group(2);
    String? displayName;
    if (match.groupCount == 2) {
      displayNameIndex = 2;
      valueIndex = 1;
      userId = match.group(1);
    }

    if (userController.currentUser()?.id == userId) {
      displayName = UserCollection.fromEntity(userController.currentUser()!).shortDisplayName;
    } else if (userId == mentionAllUserId) {
      displayName = 'All@mention'.trParams({'mention': ''});
    } else {
      String? memberName;
      String? contactName;
      if (userId != null) {
        final contact = GetIt.I<GetContactSyncUseCase>().call(userId);
        contactName = contact?.shortName;

        final member = GetIt.I<GetOneMemberInAnyRoomSyncUseCase>().call(GetOneMemberInAnyRoomRequest(
          accountId: userId,
        ));
        memberName = member?.shortName;
      }

      displayName = contactName ?? memberName ?? match.group(displayNameIndex) ?? '';
    }

    if (displayName.isEmpty == true) {
      map['display'] = '@UNKNOWN';
    } else {
      map['display'] = '@$displayName';
    }

    map['value'] = match.group(valueIndex) ?? 'UNKNOWN';

    if (userId == lessMoreId) {
      map['display'] = '${match.group(displayNameIndex)}';
      map['value'] = match.group(valueIndex) ?? '';
    }
    return map;
  }

  /// Show display mark up if [String] is regex pattern
  ///
  /// Example:
  ///
  /// ```dart
  /// // pattern ==> [__id__](__displayName__)
  /// final msg = '[__0123456789__](__abcdef__)';
  /// print(msg) // [__0123456789__](__abcdef__)
  /// print(msg.displayMarkUp(getDisplay: true)) // abcdef
  /// print(msg.displayMarkUp()) // @0123456789
  /// ```
  String displayMarkUp({
    String pattern = mentionRegexPattern,
    bool getDisplay = false,
  }) {
    return splitMapJoin(
      RegExp(
        pattern,
        multiLine: true,
        caseSensitive: true,
        dotAll: false,
        unicode: false,
      ),
      onMatch: (m) {
        if (getDisplay) {
          return m[0]?.markupToDisplayRegExHelper()['display'] ?? '';
        } else {
          return '@${m[0]?.markupToDisplayRegExHelper()["value"]}';
        }
      },
      onNonMatch: (nm) {
        return nm;
      },
    );
  }
}
