import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/core/domain/params/app_share_bottom_sheet_share_param.dart';
import 'package:uchat/core/domain/params/get_chat_room_for_share_param.dart';
import 'package:uchat/core/domain/use_cases/app_share_bottom_sheet_share_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_chat_room_for_share_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_recent_chat_room_for_share_use_case.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/message_file_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/presentation/chat_room_presentation.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class AppShareBottomSheetController extends GetxController {
  final ShareBottomSheetDataEntity data;

  final selectedTargetList = <ShareTargetEntity>[].obs;

  /// List of friend, group, official account that we chat with recently.
  final recentChatList = <ShareTargetEntity>[].obs;

  /// List of all friend, group, official account that we can share to.
  final contactList = <ShareTargetEntity>[].obs;

  /// List of [recentChatList] after search is perform and ready to display in the ui.
  final recentChatDisplayList = <ShareTargetEntity>[].obs;

  /// List of [contactList] after search is perform and ready to display in the ui.
  final contactDisplayList = <ShareTargetEntity>[].obs;

  final enableShareToOtherAppButton = false.obs;

  TextEditingController captionTextFieldController = TextEditingController();
  TextEditingController searchTextFieldController = TextEditingController();
  ScrollController selectedTargetScrollController = ScrollController();
  FocusNode captionTextFieldFocusNode = FocusNode();
  FocusNode searchTextFieldFocusNode = FocusNode();

  bool get hasSelected {
    return selectedTargetList.isNotEmpty;
  }

  AppShareBottomSheetController({required this.data});

  @override
  void onInit() async {
    bool hasMessageType =
        (data.newMessage != null && UChatConstant.messageTypeMessageGroupPermission.contains(data.newMessage!.type)) ||
            (data.messageList != null &&
                data.messageList!.any((e) => UChatConstant.messageTypeMessageGroupPermission.contains(e.message.type)));
    bool hasMediaType = data.newFile != null ||
        data.albumImageList != null ||
        (data.messageList != null &&
            data.messageList!.any((e) => UChatConstant.messageTypeMediaGroupPermission.contains(e.message.type)));
    try {
      final recentResult = await GetIt.I<GetRecentChatRoomForShareUseCase>().call(
        GetRecentChatRoomForShareParam(
          hasMediaType: hasMediaType,
          hasMessageType: hasMessageType,
          limit: 5,
        ),
      );
      recentChatList(recentResult);
    } catch (e, stackTrace) {
      _log.e('AppShareBottomSheetController onInit get recent chat error.', e, stackTrace);
    }

    recentChatDisplayList(recentChatList());

    final contactResult = await GetIt.I<GetChatRoomForShareUseCase>().call(
      GetChatRoomForShareParam(
        hasMediaType: hasMediaType,
        hasMessageType: hasMessageType,
      ),
    );
    contactResult.match(
      (e) {
        _log.e('GetChatRoomForShareUseCase error.', e);
      },
      (value) {
        contactList(value);
      },
    );
    contactDisplayList(contactList());

    /// Enable share to other app if share data can be sent to other app.
    bool shareDataContainSharableToOtherAppType = data.messageList?.any(
          (e) {
            return UChatConstant.canShareToOtherAppTypeList.contains(e.message.type);
          },
        ) ==
        true;
    if (shareDataContainSharableToOtherAppType == false && data.newMessage != null) {
      shareDataContainSharableToOtherAppType = UChatConstant.canShareToOtherAppTypeList.contains(data.newMessage!.type);
    }

    bool isShareImageFromAlbum = data.albumImageList != null;

    /// Check if sharing a new image file (e.g. QR code).
    bool isSharingNewImageFile = data.newFile != null && data.newFile?.type == MessageFileType.image;

    if (shareDataContainSharableToOtherAppType || isShareImageFromAlbum || isSharingNewImageFile) {
      enableShareToOtherAppButton(true);
    }

    super.onInit();
  }

  void onSearchTextFieldChanged(String value) async {
    recentChatDisplayList(recentChatList.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList());
    contactDisplayList(contactList.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList());
  }

  void onSharePressed(BuildContext context) async {
    try {
      await UChatLoading.show();
      final errorRoomList = await GetIt.I<AppShareBottomSheetShareUseCase>().call(
        AppShareBottomSheetShareParam(
          data: data,
          selectedTargetList: selectedTargetList(),
          captionText: captionTextFieldController.text,
        ),
      );
      if (errorRoomList?.isNotEmpty == true) {
        Get.back(result: false);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'Can not share messages to these room'.tr,
          description: errorRoomList!.join(', '),
        );
      } else if (errorRoomList != null) {
        Get.back(result: false);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        GetIt.I<TaxonomyService>().sendEvent(EventName.myQRShared);
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.messageShared, eventProperties: EventProperty.messageShared('In app'));
        // If success just close bottom sheet.
        Get.back(result: true);
        AppToast.showToast(
          context: Get.context!,
          message: 'Shared'.tr,
          icon: Assets.vectors.iconShare.svg(),
          sbMargin: const EdgeInsets.only(bottom: 42),
        );
      }
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
      _log.e('onSharePressed from AppShareBottomSheetController error.', e, stackTrace);
    } finally {
      await UChatLoading.hide();
    }
  }

  void onShareInOtherAppPressed(BuildContext context) async {
    final params = ShareToOtherAppParams(data: data);

    params.data.messageList?.forEach((selection) {
      if (selection.message.type == MessageType.text) {
        selection.message.message = selection.message.message?.displayMarkUp(getDisplay: true);
      }
    });

    await UChatLoading.show();
    final result = await GetIt.I<ShareToOtherAppUseCase>().call(params);
    await UChatLoading.hide();
    result.match(
      (e) {
        UChatNewDialog.showGeneralErrorDialog(
          context: context,
          e: e,
        );
        _log.e('onShareInOtherAppPressed from AppShareBottomSheetController error.', e);
      },
      (isSuccess) {
        if (isSuccess) {
          GetIt.I<TaxonomyService>()
              .sendEvent(EventName.messageShared, eventProperties: EventProperty.messageShared('Other App'));
          Get.back(result: true);
          AppToast.showToast(
            context: Get.context!,
            message: 'Shared'.tr,
            icon: Assets.vectors.iconShare.svg(),
            sbMargin: const EdgeInsets.only(bottom: 42),
          );
        }
      },
    );
  }

  void onItemPressed({required ShareTargetEntity target}) {
    final index = selectedTargetList.indexWhere((e) => e.isSameTarget(target));

    if (index >= 0) {
      selectedTargetList.removeAt(index);
    } else {
      if (selectedTargetList.length >= UChatConstant.maxShareTargetNumber) {
        EasyThrottle.throttle(
          'share_max_selection_toast',
          const Duration(seconds: 3),
          () {
            AppToast.showToast(
              context: Get.context!,
              message: 'Maximum @count selections reached'.trParams({
                'count': UChatConstant.maxShareTargetNumber.toString(),
              }),
              icon: Assets.vectors.iconInfo.svg(),
            );
          },
        );

        return;
      }
      selectedTargetList.add(target);

      /// Scroll to the end (right side) after adding new item.
      /// Use addPostFrameCallback to wait for ScrollView to add new element first before scrolling to the end.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectedTargetScrollController.animateTo(
          selectedTargetScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void removeSelectedTarget({required ShareTargetEntity target}) {
    selectedTargetList.removeWhere((e) => e.roomId == target.roomId);
  }
}
