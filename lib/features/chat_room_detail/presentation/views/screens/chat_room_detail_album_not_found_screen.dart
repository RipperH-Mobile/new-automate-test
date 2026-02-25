import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class ChatRoomDetailAlbumNotFoundScreen extends StatelessWidget {
  const ChatRoomDetailAlbumNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      body: Center(
        child: AppText.body1(
          context: context,
          'This album has been deleted'.tr,
        ),
      ),
    );
  }
}
