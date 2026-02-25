import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';

class CustomizeEmojiHeader extends GetView<CustomizeReactionController> {
  const CustomizeEmojiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.spMin,
        right: 20.spMin,
        bottom: 16.spMin,
        top: 4.spMin,
      ),
      child: Row(
        children: [
          const Expanded(
            child: SizedBox.shrink(),
          ),
          Expanded(
            child: Text(
              'Reactions'.tr,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 18.spMin,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 18.spMin,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
