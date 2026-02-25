import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/create_group_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/create_group_chat_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_default_group_avatar_use_case.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class GroupCreateFinalController extends GetxController {
  final groupNameController = TextEditingController();

  final focusNode = FocusNode();

  int randomAvatarSeed = Random().nextInt(1000);
  int textLength = 0;

  final groupName = ''.obs;
  final accessTypePrivate = true.obs;
  final selectedAvatar = File('').obs;
  final selectedAvatarUrl = ''.obs;

  final defaultGroupAvatarImages = <String>[].obs;
  final randomDefaultGroupAvatar = ''.obs;

  @override
  void onInit() {
    groupNameController.addListener(() {
      groupName(groupNameController.value.text.trim());
    });
    handleFetchDefaultGroupAvatar();
    super.onInit();
  }

  @override
  void onClose() {
    groupNameController.dispose();
    super.onClose();
  }

  void handleBack() {
    Get.back();
  }

  void mockGroupCreate50() async {
    for (var i = 0; i < 100; i++) {
      groupName('testGroup${i + 1}');
      handleCreateGroupToServer();

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void handleCreateGroupToServer() async {
    // Determine whether user has selected a local file or custom URL
    final noLocalOrNetworkSelected = selectedAvatar.value.path.isEmpty && selectedAvatarUrl.value.isEmpty;

    // If none was selected, we’ll try to use randomDefaultGroupAvatar
    //    Otherwise, use the user's selection.
    String? finalAvatarUrl;
    if (noLocalOrNetworkSelected && randomDefaultGroupAvatar.value.isNotEmpty) {
      finalAvatarUrl = randomDefaultGroupAvatar.value;
    } else if (!noLocalOrNetworkSelected) {
      finalAvatarUrl = selectedAvatarUrl.value;
    }

    // If we have some URL, extract the final "photo name" from it,
    //    otherwise keep it as `null`.
    final defaultPhotoName =
        (finalAvatarUrl != null && finalAvatarUrl.isNotEmpty) ? finalAvatarUrl.split('/').last : null;

    // If user selected a file, pass it in groupPhotoFile;
    final request = CreateGroupChatRequest(
      groupName: groupName(),
      selectedContactList: SelectMemberController.to.selectedContacts(),
      defaultPhotoName: defaultPhotoName,
      groupPhotoFile: selectedAvatar(),
    );
    UChatLoading.show();
    try {
      final response = await GetIt.I.get<CreateGroupChatUseCase>().call(request);
      focusNode.unfocus();
      UChatLoading.hide();

      if (response?.room != null) {
        Get.offNamedUntil(
          Routes.chatRoomDirect.replaceAll(':id', response!.room.id!),
          (r) => r.settings.name == Routes.home,
          arguments: ChatRoomArguments(room: response.room, fromPage: 'createGroup'),
        );
        GetIt.I<TaxonomyService>().sendEvent(EventName.createGroupSuccessfully);
      } else {
        _log.e('Result from CreateGroupChatUseCase is null. Cannot go to chat room.');
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      }
    } catch (e, stackTrace) {
      _log.e('handleCreateGroupToServer error.', e, stackTrace);
      UChatLoading.hide();

      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to create group'.tr,
        description: 'An error occured while creating \nthe group. Please try again later.'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
      );
    }
  }

  Future<void> handleSelectImage(BuildContext context, File? file) async {
    if (file == null) {
      return;
    }

    selectedAvatar(file);
    selectedAvatarUrl.value = '';
  }

  void handleToggleAccessTypePrivate() {
    accessTypePrivate(!accessTypePrivate());
  }

  /// Handle open room detail select photo
  /// It will fetch when open room detail edit screen
  Future<void> handleFetchDefaultGroupAvatar() async {
    try {
      final response = await GetIt.I<FetchDefaultGroupAvatarUseCase>().call(NoParams());

      defaultGroupAvatarImages.value = response;
    } catch (e) {
      defaultGroupAvatarImages.value = [];
    }

    // After fetching, pick one random default avatar if the list is not empty
    if (defaultGroupAvatarImages.isNotEmpty) {
      randomDefaultGroupAvatar.value = defaultGroupAvatarImages[Random().nextInt(defaultGroupAvatarImages.length)];
    }
  }

  Future<void> handleGroupProfilePicker(BuildContext context) async {
    // Determine if the user is using a random default image.
    final noLocalOrNetworkSelected = selectedAvatar.value.path.isEmpty && selectedAvatarUrl.value.isEmpty;
    final isUsingRandomDefault = noLocalOrNetworkSelected && randomDefaultGroupAvatar.value.isNotEmpty;

    // Figure out which default (if any) the user is currently using
    //    If the user manually picked an avatar from the grid before, we store it in `selectedAvatarUrl`
    //    Else if they're still using random default, we store `randomDefaultGroupAvatar`
    String? currentSelectedUrl;
    if (selectedAvatarUrl.value.isNotEmpty) {
      // User previously selected some default from the grid
      currentSelectedUrl = selectedAvatarUrl.value;
    } else if (isUsingRandomDefault) {
      // They are still on the random default
      currentSelectedUrl = randomDefaultGroupAvatar.value;
    }

    // Pass necessary arguments to the picker screen.
    final result = await Get.toNamed(
      Routes.groupProfilePicker,
      arguments: {
        'randomDefaultGroupAvatar': randomDefaultGroupAvatar.value,
        'isUsingRandomDefault': isUsingRandomDefault,
        'currentSelectedUrl': currentSelectedUrl,
      },
    );

    // Process the result from the picker screen.
    if (result != null) {
      if (result is File) {
        // User picked from camera
        await handleSelectImage(context, result);
      } else if (result is String) {
        // User selected a default avatar from the grid.
        selectedAvatarUrl.value = result;
        selectedAvatar.value = File('');
      } else if (result is MediaGalleryResult) {
        // User picked from gallery.
        final image = result.images.firstOrNull;
        final file = await image?.file;
        await handleSelectImage(context, file);
      }
    }
  }
}
