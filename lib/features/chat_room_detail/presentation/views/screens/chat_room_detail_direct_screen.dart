import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/presentation/views/widgets/chat_room_detail_album_tab.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_direct_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/action_button_room_detail.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_menu.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_menu_box.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_profile_section.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets.dart';

class ChatRoomDetailDirectScreen extends GetView<ChatRoomDetailDirectController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailDirectScreen({super.key});

  @override
  String? get tag => roomTag;

  bool get isBlock => controller.isBlocked() || controller.contact.value == null;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
      appBar: RoomDetailAppBar(
        titleText: 'Contact info'.tr,
        isSecret: false,
        onSearchPressed: controller.handleOpenSearch,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileSection(),
                (controller.roomCtl?.roomCapability.value.disableCall == true)
                    ? const SizedBox.shrink()
                    : _buildAction(context),

                _buildDirectMenuSection(context),
                _buildMediaTab(),
                if (controller.roomCtl?.roomCapability.value.disableAlbumMenu != true)
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
                          enable: controller.isBlocked() != true,
                        );
                      })
                    ],
                  ),
                _buildSharePinDeleteSection(context),
                _buildBlockAndReportSection(context),

                /// last size box for bottom padding
                const SizedBox(height: kBottomNavigationBarHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Obx(() {
      return RoomDetailProfileSection(
        roomName: controller.room()?.title ?? 'Unknown'.tr,
        subTitle: controller.contact()?.username,
        roomAvatar: AvatarWrapper<RoomCollection>(
          data: controller.room(),
          hasBorder: false,
          radius: 60.spMin,
          onlineStatusSize: 14.spMin,
        ),
        isShowSubTitle: !AppEnv.isProd,
        isOfficialAccount: controller.roomCtl?.roomCapability.value == RoomCapabilityEntity.official,
      );
    });
  }

  Widget _buildDirectMenuSection(BuildContext context) {
    return Obx(() {
      return ChatRoomDetailMenuBox(
        children: [
          if (controller.contact() != null && controller.roomCtl?.roomCapability.value.disableEditNameMenu != true)
            ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: 'Edit Nickname'.tr,
              icon: Assets.vectors.changeNameIcon.svg(
                colorFilter: isBlock == false
                    ? ColorFilter.mode(
                        context.theme.appColors.icon,
                        BlendMode.srcIn,
                      )
                    : ColorFilter.mode(
                        context.theme.appColors.iconDisable,
                        BlendMode.srcIn,
                      ),
              ),
              textColor: isBlock == false ? context.theme.appColors.textDarkest : context.theme.appColors.textLightest,
              onTap: () {
                isBlock == false ? controller.handleOpenEditNickName() : null;
              },
            ),
          if (controller.contact() != null)
            ChatRoomDetailMenu(
              textColor: isBlock == false ? context.theme.appColors.textDarkest : context.theme.appColors.textLightest,
              icon: Assets.vectors.themeIcon.svg(
                colorFilter: isBlock == false
                    ? ColorFilter.mode(
                        context.theme.appColors.icon,
                        BlendMode.srcIn,
                      )
                    : ColorFilter.mode(
                        context.theme.appColors.iconDisable,
                        BlendMode.srcIn,
                      ),
              ),
              title: 'Theme'.tr,
              onTap: () {
                if (isBlock == false) {
                  controller.openRoomThemeScreen();
                }
              },
            ),
        ],
      );
    });
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

  Widget _buildSharePinDeleteSection(BuildContext context) {
    return Obx(() {
      return ChatRoomDetailMenuBox(
        children: [
          Obx(() {
            return Visibility(
              visible: !controller.isSystemRoom,
              child: ChatRoomDetailMenu(
                hasBottomDivider: true,
                title: 'Share contact'.tr,
                onTap: () {
                  controller.handleShareContact();
                },
              ),
            );
          }),
          Obx(() {
            return ChatRoomDetailMenu(
              hasBottomDivider: true,
              title: controller.isPinnedChat.value ? 'Unpin chat'.tr : 'Pin chat'.tr,
              onTap: () {
                controller.showDialogPinChat(context);
              },
            );
          }),
          if (controller.roomCtl?.roomCapability == RoomCapabilityEntity.official)
            Obx(() {
              return ChatRoomDetailMenu(
                hasBottomDivider: true,
                title: controller.isMuted.value == true ? 'Unmute chat'.tr : 'Mute chat'.tr,
                onTap: () {
                  controller.handleToggleMuteChat();
                },
              );
            }),
          ChatRoomDetailMenu(
            title: 'Delete chat'.tr,
            textColor: context.theme.appColors.textError,
            onTap: () {
              controller.showDialogDeleteChat();
            },
          ),
        ],
      );
    });
  }

  Widget _buildBlockAndReportSection(BuildContext context) {
    return ChatRoomDetailMenuBox(children: [
      Obx(() {
        return ChatRoomDetailMenu(
          hasBottomDivider: true,
          title: isBlock == false ? 'Block'.tr : 'Unblock'.tr,
          roomName: controller.title,
          textColor: context.theme.appColors.textError,
          onTap: () {
            controller.showDialogBlockUser();
          },
        );
      }),
      Obx(() {
        return ChatRoomDetailMenu(
          title: 'Report'.tr,
          roomName: controller.title,
          textColor: context.theme.appColors.textError,
          onTap: () {
            //TODO: change to new ui report
            controller.handleReportUserPressed(context: Get.context!);
          },
        );
      }),
    ]);
  }

  Widget _buildAction(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpace.space4,
          AppSpace.space0,
          AppSpace.space4,
          controller.contact() != null ? AppSpace.space4 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButtonRoomDetail(
              text: 'Call'.tr,
              icon: Assets.vectors.phone.svg(
                colorFilter: controller.isDirectCallAvailable
                    ? ColorFilter.mode(context.theme.appColors.textDarkest, BlendMode.srcIn)
                    : ColorFilter.mode(context.theme.appColors.textLightest, BlendMode.srcIn),
              ),
              textColor: controller.isDirectCallAvailable
                  ? context.theme.appColors.textDarkest
                  : context.theme.appColors.textLightest,
              onTap: !controller.isDirectCallAvailable
                  ? () {}
                  : () async {
                      final param = StartCallParam(
                        callData: RoomCallModel.generateDirectCall(controller.room()!, CallType.voice),
                      );

                      GetIt.I<TaxonomyService>().sendEvent(EventName.clickVoiceCall,
                          eventProperties: EventProperty.clickVoiceCall('chat room'));
                      await GetIt.I<StartCallUseCase>().call(param);
                    },
            ),
            ActionButtonRoomDetail(
              text: 'Video call'.tr,
              icon: Assets.vectors.videoCamera.svg(
                colorFilter: controller.isDirectCallAvailable
                    ? ColorFilter.mode(context.theme.appColors.textDarkest, BlendMode.srcIn)
                    : ColorFilter.mode(context.theme.appColors.textLightest, BlendMode.srcIn),
              ),
              textColor: controller.isDirectCallAvailable
                  ? context.theme.appColors.textDarkest
                  : context.theme.appColors.textLightest,
              onTap: !controller.isDirectCallAvailable
                  ? () {}
                  : () async {
                      final param = StartCallParam(
                        callData: RoomCallModel.generateDirectCall(controller.room()!, CallType.video),
                      );
                      GetIt.I<TaxonomyService>().sendEvent(EventName.clickVideoCall,
                          eventProperties: EventProperty.clickVideoCall('chat room'));
                      await GetIt.I<StartCallUseCase>().call(param);
                    },
            ),
            Obx(() {
              return ActionButtonRoomDetail(
                text: controller.isMuted.value == true ? 'Unmute'.tr : 'Mute'.tr,
                icon: controller.isMuted.value == true
                    ? Assets.vectors.bellmute.svg(
                        colorFilter: isBlock == false
                            ? ColorFilter.mode(context.theme.appColors.textDarkest, BlendMode.srcIn)
                            : ColorFilter.mode(context.theme.appColors.textLightest, BlendMode.srcIn),
                      )
                    : Assets.vectors.bell.svg(
                        colorFilter: isBlock == false
                            ? ColorFilter.mode(context.theme.appColors.textDarkest, BlendMode.srcIn)
                            : ColorFilter.mode(context.theme.appColors.textLightest, BlendMode.srcIn),
                      ),
                textColor:
                    isBlock == false ? context.theme.appColors.textDarkest : context.theme.appColors.textLightest,
                onTap: isBlock == false ? controller.handleToggleMuteChat : () {},
              );
            }),
          ],
        ),
      );
    });
  }
}
