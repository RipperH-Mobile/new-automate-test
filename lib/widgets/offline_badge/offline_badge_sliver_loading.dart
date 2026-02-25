import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

class OfflineBadgeSliverLoading extends StatelessWidget {
  final ConnectivityStatus status;

  const OfflineBadgeSliverLoading({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxPersistentHeader(
      scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
      child: Container(
        color: context.theme.appColors.backgroundNeutralLighter,
        padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(
              width: AppSpace.space2,
            ),
            AppText.body3Bold(
              statusText,
              context: context,
              color: context.theme.appColors.textLighter,
            ),
          ],
        ),
      ),
    );
  }

  String get statusText {
    if (status == ConnectivityStatus.unstable) {
      return 'Unstable network connection'.tr;
    } else if (status == ConnectivityStatus.slow) {
      return 'Slow network connection'.tr;
    } else if (status == ConnectivityStatus.offline) {
      return 'Waiting for network'.tr;
    } else {
      return 'Online'.tr;
    }
  }
}
