import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Typing message widget
///
/// This widget is used to display the typing message
///
/// This widget will display the avatar of the members who are currently typing
class TypingMessage extends StatelessWidget {
  /// The list of typing members
  final List<ContactInterface> typingMembers;

  const TypingMessage({super.key, required this.typingMembers});

  /// The length of the avatar
  ///
  /// This value is used to determine the number of avatars to display
  /// - If the length of the typing members is more than 3, the avatar length is 2
  /// - If the length of the typing members is less than 3, the avatar length is the same as the typing members length
  int get avatarLength {
    if (typingMembers.length == 3) {
      return 3;
    }

    if (typingMembers.length > 3) {
      return 2;
    }

    return typingMembers.length;
  }

  /// The length of the more member
  ///
  /// This value is used to determine the number of more members
  /// - If the length of the typing members is more than 3, the more member length is the difference between the typing members length and 3
  /// - If the length of the typing members is less than 3, the more member length is 0
  /// - If the more member length is more than 99, the more member text is '+99'
  int get moreMemberLength {
    if (typingMembers.length > 3) {
      return typingMembers.length - 2;
    }

    return 0;
  }

  String get moreMemberText {
    if (moreMemberLength == 0) {
      return '';
    }

    if (moreMemberLength > 99) {
      return '+99';
    }

    return '+$moreMemberLength';
  }

  @override
  Widget build(BuildContext context) {
    if (typingMembers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: AppSpace.space4 + 2, top: AppSpace.space3),
      child: Row(
        children: [
          /// Display the avatar of the typing members
          for (int i = 0; i < avatarLength; i++)
            Align(
              alignment: Alignment.center,
              widthFactor: .7,
              child: AvatarWrapper(
                data: typingMembers[i],
                radius: AppSize.size4,
                showOnlineStatus: false,
                hasBorder: false,
              ),
            ),

          /// If the typing members length is more than 3, display the more member widget
          /// - The more member widget is a circle container with the text number of more members
          if (typingMembers.length > 3)
            Align(
              alignment: Alignment.center,
              widthFactor: .7,
              child: Container(
                width: 32.spMin,
                height: 32.spMin,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.appColors.backgroundNeutralLight,
                ),
                child: Center(
                  child: AppText.caption1Bold(
                    moreMemberText,
                    context: context,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          AppSpace.space3.horizontalSpace,

          /// Display the typing text widget
          Container(
            width: 48.spMin,
            height: 40.spMin,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLight,
              borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
            ),
            child: Center(
              child: LoadingAnimationWidget.waveDots(
                color: context.theme.appColors.icon,
                size: AppSize.size4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
