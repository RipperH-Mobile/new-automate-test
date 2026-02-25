import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_select_screen_controller.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_item.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_item_shimmer.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/button_for_edit_screen.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/offline_badge/offline_badge.dart';

class CallLogSelectScreen extends GetView<CallLogSelectScreenController> {
  const CallLogSelectScreen({super.key});

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarDefault(
        title: 'Edit call list'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () => Get.back(),
        ),
        actionButton: AppControlButton.forward(
          context: context,
          label: 'Clear All'.tr,
          onTap: () {
            controller.handleClearAllCallLogs(context);
          },
          isBold: true,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8E8E8),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: AppSize.size4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpace.space2,
                    AppSpace.space3,
                    AppSpace.space2,
                    AppSpace.space4,
                  ),
                  child: Obx(() {
                    final hasSelection = controller.selectedCallLogs.isNotEmpty;

                    return ButtonForEditScreen(
                      width: 382.spMin,
                      height: 52.spMin,
                      onPressed: hasSelection ? () => controller.handleDeleteAllSelectedCallLogs(context) : () {},
                      text: hasSelection
                          ? 'Delete (@count)'.trParams({
                              'count': controller.selectedCallLogs.length.toString(),
                            })
                          : 'Delete'.tr,
                      textColor: hasSelection ? context.theme.appColors.textError : context.theme.appColors.textDisable,
                      borderColor: context.theme.appColors.borderDisable,
                    );
                  })),
            ],
          ),
        ),
      ),
      // TODO: check offline mode again
      /// Main body
      child: Column(
        children: [
          _buildSearchBar(context),
          _buildOfflineBadge(context),
          Expanded(
            child: Obx(() {
              // If there's a search keyword
              if (controller.keyword.isNotEmpty) {
                // If offline, show offline message
                if (ConnectivityController.instance.isOffline) {
                  return _buildOfflineMode(context);
                }
                // If searching but no results
                if (controller.callLogs.isEmpty && controller.isLoading.isFalse) {
                  return _buildNoSearchResults(context);
                }
                // else show results
                return _buildCallLogsList(context);
              } else {
                if (controller.isLoading.value && controller.callLogs.isEmpty) {
                  return ListView.builder(
                    itemCount: 15, // number of displayed shimmer items
                    itemBuilder: (context, index) => const CallLogListItemShimmer(),
                  );
                }
                // No keyword => normal listing
                if (controller.callLogs.isEmpty) {
                  return _buildCallLogEmpty(context);
                }
                return _buildCallLogsList(context);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLighter,
      padding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space4,
      ),
      child: SizedBox(
        height: AppSpace.space10,
        child: AppSearchBox(
          focusNode: controller.searchInputFocus,
          controller: controller.searchController,
          onChanged: controller.handleSearch,
        ),
      ),
    );
  }

  Widget _buildOfflineBadge(BuildContext context) {
    return Obx(() {
      return ConnectivityController.instance.isOffline
          ? OfflineBadge(
              isConnecting: SocketCaller.instance.isConnecting,
              onPressed: SocketCaller.instance.reconnect,
            )
          : const SizedBox.shrink();
    });
  }

  Widget _buildCallLogEmpty(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLighter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Assets.vectors.iconNoCalls.svg(
              width: AppSize.size24,
              height: AppSize.size24,
            ),
          ),
          const SizedBox(height: AppSpace.space4),
          AppText.body1Bold(
            'Start your first call'.tr,
            context: context,
          ),
          const SizedBox(height: AppSpace.space1),
          AppText.body3(
            'Make your first call and connect \nwith friends instantly.'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          // Because this column center is not equal to center of the screen
          // Add an empty box to push other widgets in column up a little to
          // make it center of the screen.
          const SizedBox(
            // kToolbarHeight is used because there is appbar at the top of this screen
            // by adding the same space here should make children in this column
            // position in the center of the screen.
            // * 1.5 is because column use center and just * 1 will not push
            // other children enough to make it look more center. TLDR: It's magic.
            height: kToolbarHeight * 1.5,
            // Set width to force this column to use all screen width
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No results found'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          const SizedBox(height: AppSpace.space2),
          AppText.body4(
            'Please try searching again with different \nkeywords or check your spelling'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildOfflineMode(BuildContext context) {
    return Obx(
      () {
        return ConnectivityController.instance.isOffline
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.body2Bold(
                    'A network error occurred.'.tr,
                    context: context,
                    color: context.theme.appColors.textDark,
                  ),
                  const SizedBox(height: AppSpace.space05),
                  AppText.body4(
                    'Connection issue. \nPlease check and try again.'.tr,
                    context: context,
                    color: context.theme.appColors.textLight,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpace.space4),
                  AppFilledButton.dark(
                    context: context,
                    onTap: SocketCaller.instance.reconnect,
                    icon: Assets.vectors.iconRetry.svg(),
                    label: 'Retry'.tr,
                    isExpanded: false,
                    size: AppButtonSize.medium,
                  ),
                  const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildCallLogsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.space2),
      child: ListView.separated(
          controller: controller.scrollController,
          itemCount: controller.callLogs.length,
          separatorBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(left: Get.width * 0.32),
                child: const Divider(
                  height: AppSpace.spacePx,
                  thickness: AppSize.sizePx,
                ),
              ),
          itemBuilder: (context, index) {
            final log = controller.callLogs[index];
            return Obx(() {
              final isSelected = controller.selectedCallLogs.any((sel) => sel.id == log.id);
              return GestureDetector(
                onTap: () => controller.handleSelectItem(log),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.space4,
                  ),
                  child: CallLogListItem(
                    data: log,
                    isShowCheckBox: true,
                    isSelected: isSelected,
                    onTap: () => controller.handleSelectItem(log),
                  ),
                ),
              );
            });
          }),
    );
  }
}
