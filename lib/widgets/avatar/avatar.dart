import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/uchat_image.dart';

// final _log = useLogger();

class Avatar extends StatelessWidget {
  final String? url;
  final ImageProvider? image;

  // hasAvatar is unused in this widget but keep it for now just in case ?
  final bool hasAvatar;

  // Show text on top of avatar image if not null or not empty
  final String? avatarText;
  final Color borderColor;
  final Color backgroundColor;
  final Color innerBackgroundColor;
  final Color textColor;
  final Color groupBackgroundColor;
  final double radius;
  final double borderWidth;
  final String? id;

  factory Avatar({
    Key? key,
    String? url,
    ImageProvider? image,
    String? avatarText,
    Color? borderColor,
    Color? backgroundColor,
    Color? innerBackgroundColor,
    Color? groupBackgroundColor,
    Color? textColor,
    double? radius,
    double? borderWidth,
    bool? hasAvatar,
    String? id,
  }) {
    borderColor ??= UTheme.color.avatarBorder;
    backgroundColor ??= UTheme.color.avatarBackground;
    innerBackgroundColor ??= UTheme.color.avatarInnerBackground;
    groupBackgroundColor ??= UTheme.color.avatarGroupBackground;
    textColor ??= UTheme.color.avatarText;
    radius ??= 50;
    borderWidth ??= 1;
    hasAvatar ??= false;

    return Avatar.raw(
      key: key,
      url: url,
      image: image,
      avatarText: avatarText,
      borderColor: borderColor,
      textColor: textColor,
      radius: radius,
      borderWidth: borderWidth,
      hasAvatar: hasAvatar,
      backgroundColor: backgroundColor,
      innerBackgroundColor: innerBackgroundColor,
      groupBackgroundColor: groupBackgroundColor,
      id: id,
    );
  }

  const Avatar.raw({
    super.key,
    this.url,
    this.image,
    this.avatarText,
    required this.borderColor,
    required this.backgroundColor,
    required this.innerBackgroundColor,
    required this.textColor,
    required this.groupBackgroundColor,
    required this.radius,
    required this.borderWidth,
    required this.hasAvatar,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundColor: groupBackgroundColor,
          backgroundImage: image != null
              ? ResizeImage(
                  image!,
                  width: 100,
                )
              : null,
          child: (url != null) ? _buildAvatar(context) : SizedBox.expand(child: _buildForeground(context)),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (url == null) return _customImageWidgetError();
    final useUChatHeader = url!.contains('uchat');

    return ClipOval(
      child: Stack(
        children: [
          _buildNetworkImage(useUChatHeader),
          Positioned.fill(child: _buildForeground(context)),
        ],
      ),
    );
  }

  Widget _buildNetworkImage(bool useUChatHeader) {
    if (url?.isNotEmpty != true) {
      return _customImageWidgetError();
    }
    return UChatImage.network(
      url!,
      key: key,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      useUChatHeader: useUChatHeader,
      customLoadingWidget: (state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitRing(
          color: textColor.withAlpha(50),
          lineWidth: 1,
        ),
      ),
      cache: true,
      maxBytes: UChatConstant.maxAvatarCacheSize,
      customErrorWidget: (state) => _customImageWidgetError(),
      cacheMaxAge: const Duration(days: 365),
    );
  }

  Widget _customImageWidgetError() {
    // TODO (improve) Update to use no avatar image here.
    return Assets.vectors.iconNoAvatar.svg();
  }

  Widget _buildForeground(BuildContext context) {
    if (avatarText == null || avatarText!.isEmpty) {
      // placeholder icon if there is no url or image
      if (url == null && image == null) {
        // TODO (improve) Update to use no avatar image here.
        return Assets.vectors.accountCircle2.svg();
      } else {
        // if there is no avatarText show nothing
        return const SizedBox.shrink();
      }
    }

    const int startFontSize = 18;

    return CircleAvatar(
      radius: radius,
      backgroundColor: innerBackgroundColor.withAlpha(128),
      child: Text(
        avatarText!,
        style: TextStyle(
          color: textColor,
          fontSize: startFontSize * (radius / startFontSize * 0.8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
