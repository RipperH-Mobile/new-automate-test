import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/constants/uchat_error_label_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/domain/entities/get_image_from_clipboard_stream_state.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class PasteBoardImagePreviewController extends GetxController {
  final String tag;
  final String roomId;
  final List<ClipboardDataReader> clipboardImages;
  final MentionMarkModel mentionMarkModel;
  final void Function(String message) onSendMessage;
  final GetStreamImagesUseCase useCase;

  PasteBoardImagePreviewController({
    required this.tag,
    required this.roomId,
    required this.clipboardImages,
    required this.mentionMarkModel,
    required this.onSendMessage,
    required this.useCase,
  });

  final allImages = <PasteBoardImageEntity>[].obs;
  final selectedCount = 0.obs;
  final isAllLoaded = false.obs;

  final hasCopiedImages = false.obs;
  final hasCopiedText = false.obs;

  final FocusNode textFieldFocusNode = FocusNode();
  final GlobalKey<MentionTextFieldState> textFieldGlobalKey = GlobalKey<MentionTextFieldState>();
  final ScrollController textFieldScrollController = ScrollController();

  StreamSubscription? _contactUpdateSub;
  StreamSubscription<ClipboardState>? _clipboardStreamSub;

  @override
  void onInit() {
    super.onInit();

    _contactUpdateSub = eventBus.on<ContactUpdateEvent>().listen(
      (event) {
        onUpdateMentionInChatInput(event.contact);
      },
    );

    _clipboardStreamSub = useCase.stateStream.listen((state) {
      if (state is ClipboardInitiated) {
        allImages.value = List.generate(
          state.totalImages,
          (index) => PasteBoardImageEntity(
            index: index,
            isSelected: true,
            percentage: 0.0,
          ),
        );
      } else if (state is ClipboardLoading) {
        allImages[state.fileIndex].percentage = state.percentage;
      } else if (state is ClipboardLoaded) {
        final item = PasteBoardImageEntity(
          image: state.fileContent,
          index: state.fileIndex,
          isSelected: true,
          percentage: 1.0,
          format: state.format,
        );

        allImages[item.index] = item;
        selectedCount.value++;
        allImages.refresh();
      } else if (state is ClipboardAllLoaded) {
        isAllLoaded.value = true;
        final isSomeImageTooLarge = allImages.where((e) => e.isTooLarge).firstOrNull;

        if (isSomeImageTooLarge != null) {
          allImages.removeWhere((e) => e.isTooLarge);
          showFileIsTooLargeDialog();
        }

        if (allImages.isEmpty || state.totalImagesLoaded == 0) {
          useCase.dispose();
          Get.back();
        }
      } else if (state is ClipboardError) {
        final errorMsg = state.message;

        if (errorMsg == UChatErrorLabelConstant.fileIsTooLarge) {
          if (state.fileIndex == null) return;

          allImages[state.fileIndex!].isTooLarge = true;
          allImages[state.fileIndex!].isSelected = false;
        } else if (errorMsg == UChatErrorLabelConstant.cannotGetAnyImages) {
          useCase.dispose();
          Get.back();

          if (state.isTooLarge == true) {
            showFileIsTooLargeDialog();
          }
        } else {
          useCase.dispose();
          Get.back();

          UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        }
      }
    });

    useCase.call(clipboardImages);
  }

  @override
  void onClose() async {
    await _contactUpdateSub?.cancel();
    await _clipboardStreamSub?.cancel();
    useCase.dispose();

    super.onClose();
  }

  AnnotationTextEditingController get textFieldController {
    return textFieldGlobalKey.currentState!.textEditingController;
  }

  void onSelected(int index) {
    final imageFile = allImages[index];

    if (imageFile.isSelected == true) {
      selectedCount.value -= 1;
      allImages[index].isSelected = false;
    } else {
      selectedCount.value += 1;
      allImages[index].isSelected = true;
    }

    allImages.refresh();
  }

  void onReorder(int oldIndex, int newIndex) {
    final item = allImages.removeAt(oldIndex);
    allImages.insert(newIndex, item);
  }

  Future<void> onSend() async {
    final selectedImages = allImages.where((element) => element.isSelected == true).toList();
    final images = selectedImages.map((e) => e.image).toList();
    final message = textFieldController.markupText.$1.trim();

    Get.back();

    if (images.isEmpty) return;

    await onSendImages(images);
    AppToast.hideToast(Get.context!);

    if (message.isNotEmpty) {
      onSendMessage.call(message);
    }
  }

  Future<void> onSendImages(List<Uint8List?> images) async {
    List<FileInfoModel> imageFiles = [];

    for (int i = 0; i < images.length; i++) {
      final imageBytes = images[i];
      if (imageBytes == null) continue;

      final mimeFile = FileService.instance.findMimeFromUint8List(imageBytes);
      final fileExtension = FileService.instance.findExtensionFromMime(mimeFile);
      final imageFile = await FileService.instance.convertUint8ListToFile(imageBytes, fileExtension: fileExtension);
      final file = await FileInfoModel.fromFile(imageFile, i);
      imageFiles.add(file);
    }

    final groupImages = imageFiles.splitToGroup(UChatConstant.maxFilePerMessage);

    for (final group in groupImages) {
      await GetIt.I<SendFileMessageToServerUseCase>().call(
        SendFileMessageParams(
          chatRoomId: roomId,
          files: group,
          isSending: true,
          isLocked: false,
          isMyNote: false,
          enableUploadPro: UserController.instance.enableUploadPro,
        ),
      );
    }
  }

  void onUpdateMentionInChatInput(ContactCollection contact) {
    try {
      final isChatInputEmpty = textFieldController.text.isEmpty;
      final markupText = textFieldController.markupText;

      // If there is no mention in inputField
      if (isChatInputEmpty || !markupText.$1.contains(RegExp(UChatConstant.mentionRegexPattern))) {
        return;
      }

      final result = GetIt.I<UpdateMentionInChatInputUseCase>().call(UpdateMentionInChatInputParams(
        contact: contact,
        markupText: markupText,
        mapping: textFieldController.mapping,
      ));

      if (result.newMapping != null) {
        textFieldController.mapping = result.newMapping!;
      }

      if (result.updatedName != null) {
        textFieldController.text = result.updatedName!;
      }
    } catch (e, stackTrace) {
      _log.e('onUpdateMentionInChatInput error (PasteBoardImagePreviewController).', e, stackTrace);
    }
  }

  Future<void> onKeyboardTap() async {
    if (Platform.isIOS) {
      // Default as 'true' to prevent adding a paste image button
      hasCopiedImages.value =
          await GetIt.I<NativeMethodChannelService>().invokeMethod<bool>('getHasImageWasCopied') ?? true;

      hasCopiedText.value =
          await GetIt.I<NativeMethodChannelService>().invokeMethod<bool>('getHasTextWasCopied') ?? false;
    }

    textFieldFocusNode.requestFocus();
  }

  Future<void> onBodyTap() async {
    textFieldFocusNode.unfocus();
  }

  void showFileIsTooLargeDialog() {
    UChatNewDialog.showSingleButtonDialog(
      title: 'Max image size: 100 MB'.tr,
      description: 'This image exceeds the 100 MB file size limit. Please use a smaller image.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      isDestructive: true,
      context: Get.context!,
    );
  }

  List<ContextMenuButtonItem> getButtonItems(EditableTextState editableTextState) {
    return buildPasteContextMenuItems(
      editableTextState: editableTextState,
      hasCopiedText: hasCopiedText.value,
      hasCopiedImages: hasCopiedImages.value,
      onPaste: () {
        editableTextState.hideToolbar();

        AppToast.showToast(
          context: Get.context!,
          message: 'Unable to paste'.tr,
          icon: Assets.vectors.iconInfo.svg(
            colorFilter: ColorFilter.mode(Get.context!.theme.appColors.iconPrimaryInverse, BlendMode.srcIn),
            width: AppSize.size8,
            height: AppSize.size8,
          ),
        );
      },
    );
  }
}
