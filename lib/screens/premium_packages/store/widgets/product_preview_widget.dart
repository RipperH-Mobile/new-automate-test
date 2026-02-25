import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';

class ContentPreview {
  final String name;
  final String description;
  final String value;
  final String unit;

  const ContentPreview({
    required this.name,
    required this.description,
    required this.value,
    required this.unit,
  });
}

class ProductPreviewWidget extends StatelessWidget {
  final double? actualYearlyPrice;
  final double? actualMonthlyPrice;
  final String? actualCurrency;
  final StoreThemeModel theme;
  final PremiumPackageCollection product;
  final AlignmentGeometry bgIconStart;
  final AlignmentGeometry bgIconEnd;
  final void Function()? onTap;

  const ProductPreviewWidget({
    super.key,
    required this.theme,
    required this.product,
    this.actualYearlyPrice,
    this.actualMonthlyPrice,
    this.actualCurrency,
    this.bgIconStart = Alignment.topCenter,
    this.bgIconEnd = Alignment.bottomCenter,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20.spMin);
    return BouncingGesture(
      onTap: onTap,
      bouncingDurationMilliseconds: 150,
      upperBound: 0.02,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 390.spMin,
            height: 268.spMin,
            margin: EdgeInsets.only(top: 16.spMin),
            decoration: mainBoxDec(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                10.verticalSpace,
                Padding(
                  padding: padding,
                  child: buildHeader(),
                ),
                buildAbilitiesList(padding),
                buildTailText(),
              ],
            ),
          ),
          if (theme.advertisementText != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 35.0.spMin),
                child: buildLabel(),
              ),
            )
        ],
      ),
    );
  }

  Widget buildLabel() {
    return Container(
      margin: EdgeInsets.all(10.spMin),
      padding: EdgeInsets.symmetric(horizontal: 10.spMin, vertical: 6.spMin),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.shadowChipHeaderColor?.hexToColor ?? Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1.spMin,
            blurRadius: 1.spMin,
            offset: const Offset(0, 0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: theme.bgChipHeaderColor?.map((e) => e.hexToColor).toList() ??
              [
                Colors.white,
                Colors.white,
              ],
        ),
        borderRadius: BorderRadius.circular(15.spMin),
      ),
      child: Text(
        theme.advertisementText!,
        style: TextStyle(
          color: theme.textChipHeaderColor?.hexToColor ?? Colors.black, // TODO: Added this key
          fontSize: 12.spMin,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // iconFancyVersion(),
        Container(
          width: 72.spMin,
          height: 72.spMin,
          decoration: BoxDecoration(
            color: theme.textParamColor?.hexToColor ?? Colors.red,
            borderRadius: BorderRadius.circular(25.spMin),
          ),
          child: UChatImage.network(
            product.linkUrl!,
            fit: BoxFit.cover,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? 'Product Name',
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.bold,
                  color: theme.textPrimaryColor?.hexToColor ?? Colors.black,
                ),
              ),
              4.verticalSpace,
              if (actualYearlyPrice! > 0)
                AutoSizeText(
                  '\u2022 @currency @price/year (@currency @monthlyPrice/month)'.trParams(
                    {
                      'price': actualYearlyPrice!.toString().pricingFormat,
                      'currency': actualCurrency ?? '',
                      'monthlyPrice': (actualYearlyPrice! / 12).floor().toString().pricingFormat,
                    },
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textParamColor?.hexToColor ?? Colors.red,
                  ),
                ),
              2.verticalSpace,
              if (actualMonthlyPrice! > 0)
                AutoSizeText(
                  '\u2022 @currency @price/month'.trParams({
                    'price': (actualMonthlyPrice!).toString().pricingFormat,
                    'currency': actualCurrency ?? '',
                  }),
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textPrimaryColor?.hexToColor ?? Colors.black,
                  ),
                ),
              if (actualYearlyPrice! <= 0 && actualMonthlyPrice! <= 0)
                AutoSizeText(
                  'Not available'.tr,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textPrimaryColor?.hexToColor ?? Colors.black,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildAbilitiesList(padding) {
    return Column(
      children: List.generate(
        contents.length,
        (int index) {
          Color? color = index.isEven
              ? (theme.bgItemColor1?.hexToColor ?? Colors.white)
              : (theme.bgItemColor2?.hexToColor ?? Colors.grey);
          final content = contents[index];
          return Container(
            height: 40.spMin,
            decoration: BoxDecoration(
              color: color,
            ),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.check, color: theme.textPrimaryColor?.hexToColor ?? Colors.black),
                  15.horizontalSpace,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: content.name,
                            style: TextStyle(
                              color: theme.textPrimaryColor?.hexToColor ?? Colors.black,
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: content.description,
                            style: TextStyle(
                              color: theme.textSecondaryColor?.hexToColor ?? Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${content.value} ',
                                style: TextStyle(
                                  color: theme.textParamColor?.hexToColor ?? Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: content.unit,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTailText() {
    return Center(
        child: Text(
      'Tap to see more details'.tr,
      style: TextStyle(
        color: '#999999'.hexToColor,
      ),
    ));
  }

  Widget iconFancyVersion() {
    return const SizedBox.shrink();
    // return  FancyContainer(
    //   bgIconStart: bgIconStart,
    //   bgIconEnd: bgIconEnd,
    //   borderRadius: BorderRadius.circular(25.spMin),
    //   size: const Size(72, 72),
    //   cycle: const Duration(seconds: 15),
    //   // colors: theme.bgIcon?.map((e) => e.hexToColor ?? Colors.white).toList() ??
    //   // [
    //   //   Colors.white,
    //   //   Colors.white,
    //   // ],
    //   colors: const [],
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CustomPaint(
    //       painter: RoundPolygonPainter(),
    //     ),
    //   ),
    // );
    // Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: bgIconStart,
    //       end: bgIconEnd,
    //       colors: theme.bgIcon?.map((e) => e.hexToColor ?? Colors.white).toList() ??
    //           [
    //             Colors.white,
    //             Colors.white,
    //           ],
    //     ),
    //     // color: theme.textParamColor?.hexToColor ?? Colors.red,
    //     borderRadius: BorderRadius.circular(25.spMin),
    //   ),
    //   width: 72.spMin,
    //   height: 72.spMin,
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CustomPaint(
    //       painter: RoundPolygonPainter(),
    //     ),
    //   ),
    // );
  }

  List<ContentPreview> get contents {
    return [
      ContentPreview(
        name: 'Multiple Account',
        description: 'Up to'.tr,
        value: (product.features?.multipleAccountFeature?.maxMultipleAccount ?? 0).toString(),
        unit: (product.features?.multipleAccountFeature?.maxMultipleAccount ?? 0) > 1 ? 'accounts'.tr : 'account'.tr,
      ),
      ContentPreview(
        name: 'Secret Chat',
        description: 'Time up to'.tr,
        value: (Duration(seconds: (product.features?.secretRoomFeature?.maxSecond ?? 0)).inDays / 7).floor().toString(),
        unit: (product.features?.secretRoomFeature?.maxSecond ?? 1) > 1 ? 'weeks'.tr : 'week'.tr,
      ),
      ContentPreview(
        name: 'Manage Folders',
        description: 'Up to'.tr,
        value: (product.features?.chatFolderFeature?.maxChatFolder ?? 0).toString(),
        unit: (product.features?.chatFolderFeature?.maxChatFolder ?? 0) > 1 ? 'folders'.tr : 'folder'.tr,
      ),
    ];
  }

  BoxDecoration mainBoxDec() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor?.hexToColor ?? Colors.black.withValues(alpha: 0.2),
          spreadRadius: 2.spMin,
          blurRadius: 4.spMin,
          offset: const Offset(0, 2),
        ),
      ],
      color: theme.bgColor?.hexToColor ?? Colors.white,
      borderRadius: BorderRadius.circular(20.spMin),
      border: Border.all(
        color: theme.borderColor?.hexToColor ?? Colors.blueAccent,
        width: 4.spMin,
      ),
    );
  }
}

class RoundedStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    double dx = 0.15; // Control point offset
    double dy = 0.1; // Control point offset
    double radius = 10.0; // Radius for rounded points

    Path path = Path()
      ..moveTo(sw / 2, radius) // Start at the top point with rounded tip
      ..cubicTo(sw * (0.5 + dx), sh * (0.5 - dy) + radius, sw * (0.5 + dy), sh * (0.5 - dx) + radius, sw,
          sh / 2) // Right point
      ..cubicTo(sw * (0.5 + dy), sh * (0.5 + dx) - radius, sw * (0.5 + dx), sh * (0.5 + dy) - radius, sw / 2,
          sh - radius) // Bottom right point
      ..cubicTo(sw * (0.5 - dx), sh * (0.5 + dy) - radius, sw * (0.5 - dy), sh * (0.5 + dx) - radius, 0,
          sh / 2) // Bottom left point
      ..cubicTo(sw * (0.5 - dy), sh * (0.5 - dx) + radius, sw * (0.5 - dx), sh * (0.5 - dy) + radius, sw / 2,
          radius) // Left point
      ..close(); // Close the path

    // Create rounded corners
    Path roundedPath = Path.combine(PathOperation.union, path, _createRoundedCorners(size, radius));

    Paint paint = Paint()
      ..color = Colors.yellow // Change color as needed
      ..style = PaintingStyle.fill; // Fill the star

    // Draw the star with rounded points
    canvas.drawPath(roundedPath, paint);
  }

  Path _createRoundedCorners(Size size, double radius) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    Path roundedCorners = Path();

    // Define rounded corners at each point of the star
    roundedCorners.addOval(Rect.fromCircle(center: Offset(centerX, radius), radius: radius)); // Top
    roundedCorners.addOval(Rect.fromCircle(center: Offset(size.width, centerY), radius: radius)); // Right
    roundedCorners.addOval(Rect.fromCircle(center: Offset(centerX, size.height - radius), radius: radius)); // Bottom
    roundedCorners.addOval(Rect.fromCircle(center: Offset(0, centerY), radius: radius)); // Left

    return roundedCorners;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for the star shadow (gradient effect)
    final shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withValues(alpha: 0.1), // Start with a soft black
          Colors.transparent, // Fade to transparent
        ],
        radius: 1.0,
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width));

    // Paint object for the star itself
    final starPaint = Paint()
      ..color = Colors.white // Star color
      ..style = PaintingStyle.fill;

    // Path for 4-point star shape
    var path = Path();

    // Define points for the 4-point star
    double sh = size.height;
    double sw = size.width;
    double dx = 0.2;
    double dy = 0.15;

    path.moveTo(sw / 2, 0);
    path.cubicTo(sw * (0.5 + dx), sh * (0.5 - dy), sw * (0.5 + dy), sh * (0.5 - dx), sw, sh / 2);
    path.cubicTo(sw * (0.5 + dy), sh * (0.5 + dx), sw * (0.5 + dx), sh * (0.5 + dy), sw / 2, sh);
    path.cubicTo(sw * (0.5 - dx), sh * (0.5 + dy), sw * (0.5 - dy), sh * (0.5 + dx), 0, sh / 2);
    path.cubicTo(sw * (0.5 - dy), sh * (0.5 - dx), sw * (0.5 - dx), sh * (0.5 - dy), sw / 2, 0);
    path.close();
    // path.moveTo(w * 0.5, h * 0.0); // Top center
    // path.lineTo(w * 0.7, h * 0.35); // Right upper
    // path.lineTo(w * 1.0, h * 0.5); // Far right
    // path.lineTo(w * 0.7, h * 0.65); // Right lower
    // path.lineTo(w * 0.5, h * 1.0); // Bottom center
    // path.lineTo(w * 0.3, h * 0.65); // Left lower
    // path.lineTo(w * 0.0, h * 0.5); // Far left
    // path.lineTo(w * 0.3, h * 0.35); // Left upper
    // path.close(); // Close the path to create the 4-pointed star

    // Draw the gradient shadow first (under the star)
    canvas.drawPath(path.shift(const Offset(5, 5)), shadowPaint); // Adjust the offset for shadow placement
    // Path roundedPath = Path.combine(PathOperation.union, path, _createRoundedCorners(size, radius));

    // Draw the star itself on top
    canvas.drawPath(path, starPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
