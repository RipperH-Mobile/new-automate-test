import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_items_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/react_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_default_emoji_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/current_emoji.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/customize_emoji_button.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/customize_emoji_header.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_list.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_packages.dart';

class CustomizeEmojiBottomSheet extends StatelessWidget {
  final MessageEntity message;

  const CustomizeEmojiBottomSheet({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizeReactionController>(
      init: CustomizeReactionController(
        message: message,
        getEmojiPackagesItemsUseCase: GetIt.I<GetEmojiPackagesItemsUseCase>(),
        getEmojiPackagesUseCase: GetIt.I<GetEmojiPackagesUseCase>(),
        updateDefaultEmojiUseCase: GetIt.I<UpdateDefaultEmojiUseCase>(),
        reactMessageUseCase: GetIt.I<ReactMessageUseCase>(),
        log: GetIt.I<LoggerService>(),
      ),
      builder: (controller) {
        return SizedBox(
          height: Get.height * 0.7,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizeEmojiHeader(),
              Divider(
                thickness: 1,
                height: 1,
                color: Color(0xFFF2F2F2),
              ),
              CurrentEmoji(),
              Divider(
                thickness: 1,
                height: 1,
                color: Color(0xFFF2F2F2),
              ),
              Expanded(
                child: EmojiList(),
              ),
              EmojiPackages(),
              CustomizeEmojiButton(),
            ],
          ),
        );
      },
    );
  }
}
