import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_item_shimmer.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_section.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_main.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/offline_badge/offline_badge.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

class CallLogScreen extends GetView<CallLogScreenController> {
  const CallLogScreen({super.key});

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarMain<AppBar>(
        title: 'Calls'.tr,
        actions: _buildActions(context),
      ),
      child: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildSearchBar(context),
          ];
        },
        body: Obx(() {
          return CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: Column(
                  children: [
                    _buildOfflineBadge(context),
                    if (isMobile && controller.listTabController != null) _buildTabBar(context),
                    Expanded(child: _buildTabBarView(context)),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      Obx(
        () {
          return Center(
            child: GestureDetector(
              onTap: () {
                isMobile && controller.callLogs.isNotEmpty ? controller.handleCallLogsSelectScreen() : null;
              },
              child: AppText.button1Bold(
                'Select'.tr,
                context: context,
                color: isMobile && controller.callLogs.isNotEmpty
                    ? context.theme.appColors.textPrimary
                    : context.theme.appColors.textLightest,
              ),
            ),
          );
        },
      )
    ];
  }

  Widget _buildSearchBar(BuildContext context) {
    return SliverToBoxPersistentHeader(
      scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
      child: Container(
        color: context.theme.appColors.backgroundNeutralLighter,
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          bottom: AppSpace.space3,
        ),
        child: SizedBox(
          height: AppSpace.space10,
          child: GestureDetector(
            onTap: () => controller.handleSearch(),
            child: const AppSearchBox(
              enabled: false,
            ),
          ),
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

  Widget _buildTabBar(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, GetPlatform.isAndroid ? -2 : AppSpace.space0),
      child: SizedBox(
        height: AppSpace.space8,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.05),
              height: AppSpace.spacePx,
              color: context.theme.appColors.borderDisable,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: controller.listTabController,
                  isScrollable: true,
                  labelColor: context.theme.appColors.textDarkest,
                  indicatorColor: context.theme.appColors.textDarkest,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.only(right: AppSpace.space4),
                  unselectedLabelColor: context.theme.appColors.textLighter,
                  indicatorWeight: 1.5,
                  tabs: [
                    Tab(
                      child: Text(
                        'All'.tr,
                        style: context.theme.appTexts.button2Bold,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Missed'.tr,
                        style: context.theme.appTexts.button2Bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                height: AppSpace.spacePx,
                thickness: 0.5,
                color: context.theme.appColors.border,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    // If it's loading and there are no call logs yet.
    if ((controller.isLoadingAll.value && controller.callLogs.isEmpty) || controller.listTabController == null) {
      return ListView.builder(
        itemCount: 15, // number of displayed shimmer items
        itemBuilder: (context, index) => const CallLogListItemShimmer(),
      );
    }
    // If not loading and still no call logs, show the empty state.
    if (controller.callLogs.isEmpty) {
      return _buildCallLogEmpty(context);
    }
    // Otherwise, display the call logs list.
    return TabBarView(
      controller: controller.listTabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SlidableAutoCloseBehavior(
          child: CustomScrollView(
            controller: controller.allScrollController,
            slivers: <Widget>[
              ..._buildAllList(context),
            ],
          ),
        ),
        controller.isLoadingMissed.value && controller.missedCallLogs.isEmpty
            ? ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) => const CallLogListItemShimmer(),
              )
            : SlidableAutoCloseBehavior(
                child: CustomScrollView(
                  controller: controller.missedScrollController,
                  slivers: <Widget>[
                    ..._buildMissedList(context),
                  ],
                ),
              ),
      ],
    );
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

  List<Widget> _buildAllList(BuildContext context) {
    return [
      CallLogListSection(
        callLogs: controller.callLogs,
        secondaryActionsBuilder: (dataModel) {
          return [
            _buildActionButton(
              text: 'Delete'.tr,
              backgroundColor: context.theme.appColors.backgroundError,
              foregroundColor: context.theme.appColors.textErrorInverse,
              imageIcon: Assets.vectors.iconTrash.svg(),
              onTap: () {
                controller.deleteCallLog(context, dataModel.id);
              },
            ),
          ];
        },
        handleItemPressed: (context, currentData) {
          controller.handleCall(context, currentData);
        },
      ),
      _buildBottomLoadingIndicator(
        context,
        isLoading: controller.isLoadingAll.value,
        hasData: controller.callLogs.isNotEmpty,
      ),
    ];
  }

  List<Widget> _buildMissedList(BuildContext context) {
    return [
      CallLogListSection(
        callLogs: controller.missedCallLogs,
        secondaryActionsBuilder: (dataModel) {
          return [
            _buildActionButton(
              text: 'Delete'.tr,
              backgroundColor: context.theme.appColors.backgroundError,
              foregroundColor: context.theme.appColors.textErrorInverse,
              imageIcon: Assets.vectors.iconTrash.svg(),
              onTap: () {
                controller.deleteCallLog(context, dataModel.id);
              },
            ),
          ];
        },
        handleItemPressed: (context, currentData) {
          controller.handleCall(context, currentData);
        },
      ),
      _buildBottomLoadingIndicator(
        context,
        isLoading: controller.isLoadingMissed.value,
        hasData: controller.missedCallLogs.isNotEmpty,
      ),
    ];
  }

  Widget _buildBottomLoadingIndicator(
    BuildContext context, {
    required bool isLoading,
    required bool hasData,
  }) {
    if (!isLoading || !hasData) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
        child: Center(
          child: SizedBox(
            width: AppSpace.space4,
            height: AppSpace.space4,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: context.theme.appColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required GestureTapCallback onTap,
    required Color backgroundColor,
    required Color foregroundColor,
    required SvgPicture imageIcon,
  }) {
    return CustomSlidableAction(
      autoClose: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: (BuildContext context) {
        onTap.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageIcon,
          const SizedBox(
            height: AppSpace.space2,
          ),
          AppText.body3Bold(
            text,
            context: Get.context!,
            color: foregroundColor,
          ),
        ],
      ),
    );
  }
}
