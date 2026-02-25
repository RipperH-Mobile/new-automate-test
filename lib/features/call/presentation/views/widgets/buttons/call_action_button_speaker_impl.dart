import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_base.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/speaker_action_button.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/app_text.dart';

class CallActionSpeakerButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isActive;
  final bool isEnable;
  final List<MediaDevice> audioOutputs;
  final void Function(MediaDevice)? onDeviceSelected;
  final Offset sheetOffset;
  final PopupMenuPosition sheetPosition;
  final bool small;
  final MediaDevice? selectedDevice;

  const CallActionSpeakerButton({
    super.key,
    required this.onPressed,
    required this.isActive,
    this.isEnable = true,
    this.small = false,
    this.audioOutputs = const [],
    this.onDeviceSelected,
    this.sheetOffset = Offset.zero,
    this.sheetPosition = PopupMenuPosition.under,
    this.selectedDevice,
  });

  @override
  State<CallActionSpeakerButton> createState() => _CallActionSpeakerButtonState();
}

class _CallActionSpeakerButtonState extends State<CallActionSpeakerButton> {
  /// Helper method to check if a device group ID indicates Bluetooth
  bool _isBluetoothDevice(String? groupId) {
    return groupId?.toLowerCase().contains('bluetooth') == true;
  }

  bool get isBluetoothDeviceConnected {
    return widget.audioOutputs.any((device) => _isBluetoothDevice(device.groupId));
  }

  bool get isSelectedDeviceBluetooth {
    if (GetPlatform.isIOS) {
      return isBluetoothDeviceConnected;
    }
    return _isBluetoothDevice(widget.selectedDevice?.groupId);
  }

  bool get isEnable => widget.isEnable;

  bool get isActive {
    return widget.isActive || Hardware.instance.forceSpeakerOutput;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSpeakerSelectorPopup(
      context,
      widget.small ? _buildOutputDeviceIcon() : _buildOutputDeviceButton(),
    );
  }

  Widget _buildSpeakerSelectorPopup(
    BuildContext context,
    Widget? child,
  ) {
    return Builder(
      builder: (c) {
        if (!isBluetoothDeviceConnected) {
          return child ?? const SizedBox();
        }
        return Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: PopupMenuButton<int>(
            popUpAnimationStyle: AnimationStyle.noAnimation,
            constraints: const BoxConstraints(minWidth: AppSpace.space50),
            useRootNavigator: true,
            offset: widget.sheetOffset,
            position: widget.sheetPosition,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpace.space3),
            ),
            child: IgnorePointer(child: child ?? Assets.vectors.iconHambergerBar.svg()),
            onSelected: (value) {},
            itemBuilder: (context) => [
              for (var i = 0; i < widget.audioOutputs.length; i++) ...[
                PopupMenuItem(
                  value: i,
                  child: GestureDetector(
                    onTap: () {
                      GetIt.I<VibrateUtil>().vibrateSelection();

                      Get.back();
                      final d = widget.audioOutputs.elementAtOrNull(i);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (d != null) {
                          widget.onDeviceSelected?.call(d);
                        }
                      });
                    },
                    child: ListTile(
                      title: AppText.body1(
                        widget.audioOutputs[i].label,
                        context: context,
                      ),
                    ),
                  ),
                ),
                if (i != widget.audioOutputs.length - 1)
                  PopupMenuItem(
                    padding: const EdgeInsets.all(AppSpace.space0),
                    height: AppSpace.space0,
                    value: i,
                    child: const Divider(
                      thickness: AppSpace.spacePx,
                      height: AppSpace.space0,
                    ),
                  ),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildOutputDeviceButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Builder(
          builder: (context) {
            if (isSelectedDeviceBluetooth && GetPlatform.isIOS) {
              return CallActionButtonBase(
                label: 'Bluetooth',
                svgPath: Assets.vectors.callBluetoothOnButton.path,
                isEnable: widget.isEnable,
                onPressed: widget.onPressed,
              );
            }
            if (GetPlatform.isAndroid && widget.selectedDevice != null) {
              String path = Assets.vectors.callSpeakerButton.path;
              final type = widget.selectedDevice?.groupId?.toLowerCase();
              if (type?.contains('speaker') == true) {
                path = Assets.vectors.callSpeakerOnButton.path;
              } else if (type?.contains('bluetooth') == true) {
                path = Assets.vectors.callBluetoothOnButton.path;
              }
              return CallActionButtonBase(
                label: widget.selectedDevice?.label ?? 'Unknown'.tr,
                svgPath: path,
                isEnable: isEnable,
                onPressed: widget.onPressed,
              );
            }
            return CallActionButtonBase(
              label: 'Speaker'.tr,
              svgPath: isActive ? Assets.vectors.callSpeakerOnButton.path : Assets.vectors.callSpeakerButton.path,
              isEnable: isEnable,
              onPressed: widget.onPressed,
            );
          },
        ),
        // if (isThereBluetoothDevice && GetPlatform.isIOS)
        //   AirPlayRoutePickerView(
        //     width: 200,
        //     height: 200,
        //     tintColor: Colors.red,
        //     activeTintColor: Colors.red,
        //     backgroundColor: Colors.red,
        //     onClosePickerView: (_) {},
        //   )
      ],
    );
  }

  Widget _buildOutputDeviceIcon() {
    if (isSelectedDeviceBluetooth) {
      return SpeakerActionButton(
        svgPath: Assets.vectors.callBluetoothOnButton.path,
        isEnable: isEnable,
        onPressed: widget.onPressed,
      );
    }
    return SpeakerActionButton(
      svgPath: isActive ? Assets.vectors.callSpeakerOnButton.path : Assets.vectors.callSpeakerButton.path,
      isEnable: isEnable,
      onPressed: widget.onPressed,
    );
  }
}
