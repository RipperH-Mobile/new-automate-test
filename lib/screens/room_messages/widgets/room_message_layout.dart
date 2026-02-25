import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:uchat/themes/themes.dart';

class RoomMessagesLayout extends StatelessWidget {
  final List<Widget> children;
  final RxBool? isLoading;
  final bool isSecretRoom;

  const RoomMessagesLayout({
    super.key,
    required this.children,
    this.isLoading,
    this.isSecretRoom = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: _buildContainerDecoration(),
        ),
        ...children,
        Obx(() {
          if (isLoading?.value == false) return const SizedBox.shrink();
          return const Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: rive.RiveAnimation.asset(
                'assets/riv/loading.riv',
              ),
            ),
          );
        }),
      ],
    );
  }

  BoxDecoration _buildContainerDecoration() {
    final gradientColors = isSecretRoom
        ? <Color>[UTheme.color.secretRoomGradientTop, UTheme.color.secretRoomGradientBottom]
        : <Color>[
            UTheme.color.messageListBackgroundGradientTop,
            UTheme.color.messageListBackgroundGradientBottom,
          ];
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ),
    );
  }
}
