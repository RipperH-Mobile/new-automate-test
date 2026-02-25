// #docregion FullAppExample
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  final CameraDescription cameraSelected;

  /// Default Constructor
  const CameraApp({super.key, required this.cameraSelected});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameraSelected, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    final scale = 1 / (controller.value.aspectRatio * MediaQuery.of(context).size.aspectRatio);
    return Transform.scale(
      scale: scale,
      alignment: Alignment.topCenter,
      child: CameraPreview(controller),
    );
  }
}
