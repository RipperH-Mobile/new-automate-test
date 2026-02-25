import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/app_env.dart';

class InviteLinkQrCode extends StatelessWidget {
  final String inviteLink;
  const InviteLinkQrCode({super.key, required this.inviteLink});

  @override
  Widget build(BuildContext context) {
    ImageProvider appIcon = Assets.images.uchatQrIcon.provider();
    if (AppEnv.isDev) {
      appIcon = Assets.appIcons.devIcon.provider();
    } else if (AppEnv.isSit) {
      appIcon = Assets.appIcons.sitIcon.provider();
    } else if (AppEnv.isUat) {
      appIcon = Assets.appIcons.uatIcon.provider();
    }

    return Container(
      width: 260.spMin,
      height: 260.spMin,
      padding: const EdgeInsets.all(AppSpace.space2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.roundedLg),
      ),
      child: PrettyQrView.data(
        data: inviteLink,
        errorCorrectLevel: QrErrorCorrectLevel.H,
        decoration: PrettyQrDecoration(
          shape: const PrettyQrSmoothSymbol(roundFactor: 0),
          image: PrettyQrDecorationImage(image: appIcon),
        ),
      ),
    );
  }
}
