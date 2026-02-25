import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/presentation/views/widgets/chat_room_detail_album_tab.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/action_button_room_detail.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_menu.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_menu_box.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/owner_transfer_helper.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_profile_section.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ChatRoomDetailGroupScreen extends GetView<ChatRoomDetailGroupController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailGroupScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
      appBar: RoomDetailAppBar(
        titleText: 'Group info'.tr,
        isSecret: false,
        onSearchPressed: controller.handleOpenSearch,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  _buildProfileSection(context),
                  _buildAction(context),
                  _buildGroupMenuSection(context),
                  _buildMediaTab(),
                  ChatRoomDetailMenuBox(
                    children: [
                      Obx(() {
                        return ChatRoomDetailAlbumTab(
                          previewAlbum: controller.roomAlbums.sublist(
                            0,
                            min(controller.roomAlbums.length, UChatConstant.roomDetailAlbumPreviewCount),
                          ),
                          albumCount: controller.albumCount(),
                          onTap: controller.openAlbumScreen,
                        );
                      })
                    ],
                  ),
                  ChatRoomDetailMenuBox(
                    children: _buildPinAndDeleteSection(context),
                  ),

                  ChatRoomDetailMenuBox(
                    children: _buildLeaveGroupSection(context),
                  ),

                  // _buildNotiAndMediaSection(),
                  AppSize.size10.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Obx(() {
      final isAdminCanEdit = controller.currentUserMemberData.value?.ableChangeGroupInfo == true;
      return RoomDetailProfileSection(
        roomName: controller.title,
        roomAvatar: GestureDetector(
          onTap: isAdminCanEdit
              ? () {
                  controller.handleGroupAvatarChange(context);
                }
              : null,
          child: Stack(
            children: [
              // Avatar widget
              AvatarWrapper<RoomCollection>(
                data: controller.room(),
                hasBorder: false,
                radius: AppSize.size20,
                showOnlineStatus: false,
              ),
              // Mini camera icon overlay
              isAdminCanEdit
                  ? Positioned(
                      right: AppSpace.space015,
                      bottom: AppSpace.space015,
                      child: Material(
                        elevation: 1,
                        shape: const CircleBorder(),
                        child: Container(
                          height: 36.spMin,
                          width: 36.spMin,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.appColors.backgroundNeutralBolderPressed,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                            child: SizedBox(
                              width: 18.spMin,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Assets.vectors.iconCamera.svg(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        isShowSubTitle: true,
        isShowCopyIcon: true,
      );
    });
  }

  Widget _buildGroupMenuSection(BuildContext context) {
    return Obx(() {
      return ChatRoomDetailMenuBox(
        children: [
          if (controller.currentUserMemberData.value?.ableChangeGroupInfo == true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Edit Group Name'.tr,
              icon: Assets.vectors.changeNameIcon.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: () {
                controller.handleOpenEditRoomDetail();
              },
            ),
          if (controller.currentUserMemberData.value?.ableToAccessGroupTypeInviteLinkSetting == true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Group type'.tr,
              icon: Assets.vectors.groupType.svg(),
              description: controller.accessType.displayValue,
              textColor: context.theme.appColors.textDarkest,
              onTap: controller.handleOpenGroupTypeSettingScreen,
            ),
          if (controller.currentUserMemberData.value?.ableToAccessGroupTypeInviteLinkSetting == true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Invite link'.tr,
              icon: Assets.vectors.inviteLink.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: controller.handleOpenGroupInviteLinkScreen,
            ),
          ChatRoomDetailMenu(
            hasBottomDivider: true,
            title: 'Member'.tr,
            icon: Assets.vectors.member.svg(),
            textColor: context.theme.appColors.textDarkest,
            onTap: () {
              controller.handleOpenRoomMemberView();
            },
          ),
          if (UserController.instance.enableGroupPermission)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Group permissions'.tr,
              icon: Assets.vectors.groupPermissionsIcon.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: () {
                controller.handleOpenGroupPermissionsScreen();
              },
            ),
          if (UserController.instance.enableGroupPermission && controller.currentUserMemberData()?.isOwner == true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Administrators'.tr,
              icon: Assets.vectors.roomDetailAdminIcon.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: () {
                controller.handleOpenAdministratorScreen();
              },
            ),
          if (UserController.instance.enableGroupPermission && controller.currentUserMemberData()?.isOwner == true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Ownership transfer'.tr,
              icon: Assets.vectors.iconOwnerTransfer.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: () {
                controller.handleOpenOwnerTransferScreen();
              },
            ),
          ChatRoomDetailMenu(
            textColor: context.theme.appColors.textDarkest,
            icon: Assets.vectors.themeIcon.svg(),
            title: 'Theme'.tr,
            onTap: () {
              controller.openRoomThemeScreen();
            },
          ),
        ],
      );
    });
  }

  Widget _buildAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.space4, AppSpace.space0, AppSpace.space4, AppSpace.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButtonRoomDetail(
            text: 'Call'.tr,
            icon: Assets.vectors.phone.svg(),
            textColor: context.theme.appColors.textDarkest,
            onTap: () async {
              final param = StartCallParam(
                callData: RoomCallModel.generateStartGroupCall(controller.room()!, CallType.voice),
              );
              GetIt.I<TaxonomyService>()
                  .sendEvent(EventName.clickVoiceCall, eventProperties: EventProperty.clickVoiceCall('group'));
              await GetIt.I<StartCallUseCase>().call(param);
            },
          ),
          ActionButtonRoomDetail(
            text: 'Video call'.tr,
            icon: Assets.vectors.videoCamera.svg(),
            textColor: context.theme.appColors.textDarkest,
            onTap: () async {
              final param = StartCallParam(
                callData: RoomCallModel.generateStartGroupCall(controller.room()!, CallType.video),
              );
              GetIt.I<TaxonomyService>()
                  .sendEvent(EventName.clickVideoCall, eventProperties: EventProperty.clickVideoCall('group'));
              await GetIt.I<StartCallUseCase>().call(param);
            },
          ),
          Obx(() {
            return ActionButtonRoomDetail(
              text: controller.isMuted.value == true ? 'Unmute'.tr : 'Mute'.tr,
              icon: controller.isMuted.value == true ? Assets.vectors.bellmute.svg() : Assets.vectors.bell.svg(),
              textColor: context.theme.appColors.textDarkest,
              onTap: controller.handleToggleMuteChat,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return Obx(() {
      return ChatRoomDetailMenuBox(
        children: [
          if ((controller.photoCount.value > 0 || controller.videoCount.value > 0) &&
              controller.roomCtl?.roomCapability.value.disableMediaMenu == false)
            ChatRoomDetailMenu(
              icon: Assets.vectors.pictureIcon.svg(),
              hasBottomDivider: controller.fileCount.value > 0 || controller.linkCount.value > 0 ? true : false,
              title: 'Media'.tr,
              isPhotoAndVideo: true,
              photoCount: controller.photoCount.value.toString(),
              videoCount: controller.videoCount.value.toString(),
              description: ''.tr,
              onTap: () {
                controller.openMediaScreen();
              },
            ),
          if (controller.fileCount.value > 0 && controller.roomCtl?.roomCapability.value.disableFilesMenu == false)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              icon: Assets.vectors.folderIcon.svg(),
              title: 'File'.tr,
              mediaCount: controller.fileCount.value.toString(),
              description: 'files'.tr,
              onTap: () {
                controller.openFileScreen();
              },
            ),
          if (controller.linkCount.value > 0)
            ChatRoomDetailMenu(
              icon: Assets.vectors.linkIcon.svg(),
              title: 'Links'.tr,
              mediaCount: controller.linkCount.value.toString(),
              description: 'links'.tr,
              onTap: () {
                controller.openLinkScreen();
              },
            )
        ],
      );
    });
  }

  List<Widget> _buildPinAndDeleteSection(BuildContext context) {
    return [
      Obx(() {
        return ChatRoomDetailMenu(
          hasBottomDivider: true,
          title: controller.isPinnedChat.value == false ? 'Pin chat'.tr : 'Unpin chat'.tr,
          onTap: () {
            controller.showDialogPinChat(context);
          },
        );
      }),
      ChatRoomDetailMenu(
        title: 'Delete chat'.tr,
        // textRed: true,
        textColor: context.theme.appColors.textError,
        onTap: () {
          controller.showDialogDeleteChat();
        },
      ),
    ];
  }

  List<Widget> _buildLeaveGroupSection(BuildContext context) {
    return [
      ChatRoomDetailMenu(
        hasBottomDivider: true,
        title: 'Leave group'.tr,
        textColor: context.theme.appColors.textError,
        onTap: () async {
          await controller.initNextOwnerSuggestion();

          if (controller.currentUserMemberData.value?.isOwner == true &&
              controller.nextOwnerSuggestionList.value.isNotEmpty &&
              context.mounted) {
            OwnerTransferHelper.showOwnerTransferBottomSheet(
              context: context,
              nextOwnerSuggestionList: controller.nextOwnerSuggestionList,
              allAdminAndMembersCount: controller.allAdminAndMembersCount,
              onOwnerTransfer: (member) {
                _showOwnershipTransferDialog(
                  context,
                  name: member.account.nickname ?? member.account.displayName ?? 'UNKNOWN'.tr,
                  onConfirm: () {
                    controller.handleOwnerTransfer(member);
                  },
                  urlOwner: controller.currentUserMemberData()?.account.avatarUrl ?? '',
                  urlTarget: member.account.avatarUrl,
                );
              },
              onSkipAndLeave: controller.showDialogLeaveGroup,
              onNavigateToOwnerTransferScreen: () {
                controller.handleOpenOwnerTransferScreen(isShowLeaveGroup: true);
              },
            );
          } else {
            controller.showDialogLeaveGroup();
          }
        },
      ),
      ChatRoomDetailMenu(
        title: 'Report group'.tr,
        textColor: context.theme.appColors.textError,
        onTap: () {
          //TODO: change to new ui report
          controller.handleReportGroupPressed(context: Get.context!);
        },
      ),
    ];
  }

  Future<void> _showOwnershipTransferDialog(
    BuildContext context, {
    required String name,
    required VoidCallback onConfirm,
    required String urlOwner,
    required String urlTarget,
  }) {
    return UChatDialogV3.showDefaultDialog(
        context: Get.context!,
        title: 'Transfer to @name?'.trParams({'name': name}),
        description: 'Do you confirm that you want to transfer ownership rights of @groupName to @name?'.trParams({
          'groupName': controller.title,
          'name': name,
        }),
        confirmText: 'Confirm'.tr,
        onConfirm: onConfirm,
        contentWidget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Avatar(
                      radius: 34.spMin,
                      url: urlOwner,
                    ),
                    Positioned(
                      bottom: -AppSpace.space4,
                      child: Assets.vectors.iconOldOwner.svg(),
                    ),
                  ],
                ),
                SizedBox(
                  width: AppSpace.space16,
                  child: DottedLine(
                    dashLength: AppSpace.space1,
                    dashGapLength: AppSpace.space2,
                    lineThickness: AppSpace.space05,
                    dashColor: context.theme.appColors.border,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Avatar(
                      radius: 34.spMin,
                      url: urlTarget,
                    ),
                    Positioned(
                      bottom: -AppSpace.space4,
                      child: Assets.vectors.iconNewOwner.svg(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpace.space6),
          ],
        ));
  }
}
