import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/app_env.dart';

class MyQrCode extends StatefulWidget {
  final String qrCodeData;
  final double width;
  final double height;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const MyQrCode({
    super.key,
    required this.qrCodeData,
    required this.width,
    required this.height,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<MyQrCode> createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  PrettyQrDecorationImage? _appIcon;

  @override
  void initState() {
    super.initState();
    final icon = getAppIcon(context);
    _appIcon = PrettyQrDecorationImage(
      image: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.width,
      width: widget.height,
      padding: widget.padding,
      color: widget.backgroundColor,
      child: Align(
        alignment: Alignment.center,
        child: PrettyQrView.data(
          errorCorrectLevel: QrErrorCorrectLevel.H,
          data: widget.qrCodeData,
          decoration: PrettyQrDecoration(
            shape: const PrettyQrSmoothSymbol(roundFactor: 0),
            image: _appIcon,
          ),
        ),
      ),
    );
  }

  ImageProvider getAppIcon(BuildContext context) {
    if (AppEnv.isDev) {
      return Assets.appIcons.devIcon.provider();
    } else if (AppEnv.isSit) {
      return Assets.appIcons.sitIcon.provider();
    } else if (AppEnv.isUat) {
      return Assets.appIcons.uatIcon.provider();
    }

    return Assets.images.uchatQrIcon.provider();
  }
}
