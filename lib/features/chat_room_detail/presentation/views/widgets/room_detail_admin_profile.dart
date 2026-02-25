import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/contact/data/models/models/contact_model.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class RoomDetailAdminProfile extends StatelessWidget {
  final ContactModel contact;

  const RoomDetailAdminProfile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      margin: const EdgeInsets.all(AppSpace.space4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
            child: AvatarWrapper<ContactInterface>(
              data: contact,
              hasBorder: false,
              radius: 25.spMin,
              showOnlineStatus: false,
            ),
          ),
          const SizedBox(width: AppSpace.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body3Bold(
                  contact.name ?? 'UNKNOWN',
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textOverflow: TextOverflow.ellipsis,
                ),
                if (contact.originalStatusMessage?.isNotEmpty == true)
                  AppText.body4(
                    contact.statusMessage,
                    context: context,
                    color: context.theme.appColors.textLight,
                    textOverflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
