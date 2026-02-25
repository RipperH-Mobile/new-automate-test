import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/image/uchat_image.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final String? avatar;
  final String? blurHash;

  const AvatarWidget({
    super.key,
    this.avatar,
    this.radius = 30,
    this.blurHash,
  });

  Widget buildAvatar(
    double radius,
    String? image,
  ) {
    if (image == null) {
      return const SizedBox();
    }
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: UChatImage.network(
            image,
            width: radius * 2,
            height: radius * 2,
            customLoadingWidget: (s) {
              return ClipOval(
                child: BlurHash(
                  decodingWidth: radius.toInt() * 2,
                  decodingHeight: radius.toInt() * 2,
                  hash: blurhashDefault(blurHash),
                  imageFit: BoxFit.cover,
                ),
              );
            },
            customErrorWidget: (state) => Assets.vectors.iconNoAvatar.svg(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAvatar(radius, avatar);
  }
}
