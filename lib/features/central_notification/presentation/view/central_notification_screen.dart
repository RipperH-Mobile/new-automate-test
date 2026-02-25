import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/central_notification/presentation/controller/central_notification_controller.dart';
import 'package:uchat/features/central_notification/presentation/view/widgets/central_notification_list_item_slidable.dart';
import 'package:uchat/features/central_notification/presentation/view/widgets/empty_notification_screen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_main.dart';
import 'package:uchat/widgets/banner/banner_offline.dart';

// final _log = useLogger();

class CentralNotificationScreen extends GetView<CentralNotificationController> {
  const CentralNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarMain<AppBar>(
        title: 'Notifications'.tr,
      ),
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      child: Column(
        children: [
          _buildOfflineBanner(),
          Expanded(
            child: CustomScrollView(
              slivers: [_buildList()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineBanner() {
    return Obx(() {
      return ConnectivityController.instance.isOffline
          ? BannerOffline(onPressed: SocketCaller.instance.reconnect)
          : const SizedBox.shrink();
    });
  }

  Widget _buildList() {
    return SlidableAutoCloseBehavior(
      child: Obx(() {
        if (controller.isLoadingInit.value) {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
              ),
            ),
          );
        }

        if (controller.isLoadingInit.value == false && controller.centralNotificationList.isEmpty) {
          return const SliverFillRemaining(
            child: EmptyNotificationScreen(),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final key = controller.centralNotificationList[index].data?.widgetKey;

              return Obx(() {
                final centralNoti = controller.centralNotificationList.elementAtOrNull(index);
                if (centralNoti == null) {
                  return const SizedBox.shrink();
                }

                final notiIndex = controller.centralNotificationList.elementAt(index);

                final notiType = notiIndex.notiType ?? CentralNotiType.unknown;

                if (index == controller.centralNotificationList().length - controller.nextPageTrigger &&
                    controller.currentPage() < controller.totalPage()) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.fetchNotificationListFromServer(page: controller.currentPage() + 1);
                  });
                }

                final roomId = notiIndex.data?.roomId.toString();
                final accountId = notiIndex.data?.accountId.toString();
                final requestId = notiIndex.data?.groupRequestedId.toString();

                return CentralNotificationListItemSlidable(
                  key: ValueKey('CONTAINER-$key'),
                  centralNoti: notiIndex,
                  notiType: notiType,
                  isOffline: ConnectivityController.instance.isOffline,
                  onJoinGroupInvite: () => controller.onJoinGroupInvite(roomId),
                  onAcceptFriendReq: () => controller.onAcceptFriendReq(accountId),
                  onApproveGroupReq: () => controller.handleApproveGroupRequest(requestId),
                  // onDeleteNoti: controller.deleteNoti,
                  onSelectNoti: (notiIndex) => controller.onSelectNoti(notiIndex),
                );
              });
            },
            childCount: controller.centralNotificationList.length,
          ),
        );
      }),
    );
  }
}
