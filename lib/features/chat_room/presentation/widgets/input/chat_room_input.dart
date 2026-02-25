import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/api/payloads/message/edit_message.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_audio_input.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_text_input.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/screens/room_messages/enum/input_mode_state.dart';

// TODO New ui implement needed.
class ChatRoomInput extends GetView<ChatRoomInputController> {
  final String chatInputTag;
  final void Function({List<MessageLinkModel> links, required String message, int loopCount}) onSendText;
  final Function(EditMessageRequest) onEditText;
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final Function(FileInfoModel) onSendAudioRecording;
  final Function(MediaGalleryResult, {int loopCount}) onImageAndVideoPicked;
  final Function(FileInfoModel) onTakePicture;
  final Function(FileInfoModel, {int loopCount}) onSendFile;
  final Function(MapInfoResponse) onShareLocation;
  final Function(List<ContactCollection>) onShareUChatContact;
  final Function(List<Contact>) onSharePhoneContact;

  const ChatRoomInput({
    super.key,
    required this.chatInputTag,
    required this.onSendText,
    required this.onEditText,
    required this.onSendSticker,
    required this.onSendGif,
    required this.onSendAudioRecording,
    required this.onImageAndVideoPicked,
    required this.onTakePicture,
    required this.onSendFile,
    required this.onShareLocation,
    required this.onShareUChatContact,
    required this.onSharePhoneContact,
  });

  @override
  String? get tag => chatInputTag;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.only(
          bottom: controller.inputModeState.value == InputModeState.close ? Get.mediaQuery.viewPadding.bottom : 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () {
                if (controller.chatRoomCtl == null) {
                  return const SizedBox.shrink();
                }
                if (controller.isRecordingAudio() &&
                    !(controller.chatRoomCtl?.roomCapability.value.disableSendVoice ?? false)) {
                  return ChatRoomAudioInput(
                    chatInputTag: chatInputTag,
                    onSendAudioRecording: onSendAudioRecording,
                  );
                } else {
                  return ChatRoomTextInput(
                    onEditText: onEditText,
                    onSendText: onSendText,
                    onSendSticker: onSendSticker,
                    onSendGif: onSendGif,
                    onImageAndVideoPicked: onImageAndVideoPicked,
                    onTakePicture: onTakePicture,
                    onSendFile: onSendFile,
                    onShareLocation: onShareLocation,
                    onShareUChatContact: onShareUChatContact,
                    onSharePhoneContact: onSharePhoneContact,
                    chatInputTag: chatInputTag,
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
