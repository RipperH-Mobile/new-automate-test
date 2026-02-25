import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';

class ParticipantBox extends StatelessWidget {
  const ParticipantBox({
    super.key,
    this.track,
    this.width = 120,
    this.height = 190,
    this.radius = AppRadius.roundedXl,
  });

  final VideoTrack? track;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // TODO: fix shadow
        boxShadow: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: track == null
              ? Center(
                  child: CupertinoActivityIndicator(
                    color: context.theme.appColors.iconPrimaryInverse,
                  ),
                )
              : VideoTrackRenderer(
                  renderMode: VideoRenderMode.auto,
                  track!,
                  fit: VideoViewFit.cover,
                ),
        ),
      ),
    );
  }
}
