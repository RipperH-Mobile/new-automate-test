import 'package:flutter/material.dart';
import 'package:uchat/widgets/offline_badge/offline_badge.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

class OfflineBadgeSliver extends StatelessWidget {
  final bool isConnecting;
  final void Function() onPressed;

  const OfflineBadgeSliver({
    super.key,
    required this.isConnecting,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxPersistentHeader(
      scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
      child: Center(
        child: OfflineBadge(
          isConnecting: isConnecting,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
