import 'dart:math' as math;

import 'package:animated_background/animated_background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/screens/premium_packages/premium_icon/round_polygon_painter.dart';
import 'package:uchat/utils/extension/extension.dart';

class SubscriptionPeriodButton extends StatefulWidget {
  final double? width;
  final double? height;
  final bool available;
  final SubscriptionPeriodType period;
  final double price;
  final String currency;
  final String? chipLabel;
  final Color? chipBackgroundColor;
  final List<Color>? backgroundInnerColor;
  final Color? backgroundOuterColor;
  final Color? shadowRect;

  const SubscriptionPeriodButton({
    super.key,
    this.width,
    this.height,
    this.available = true,
    required this.period,
    required this.price,
    required this.currency,
    this.chipLabel,
    this.chipBackgroundColor,
    this.backgroundOuterColor,
    this.backgroundInnerColor,
    this.shadowRect,
  });

  @override
  State<SubscriptionPeriodButton> createState() => _SubscriptionPeriodButtonState();
}

class _SubscriptionPeriodButtonState extends State<SubscriptionPeriodButton> with TickerProviderStateMixin {
  String get periodLabel {
    if (widget.period == SubscriptionPeriodType.year) {
      return SubscriptionPeriodType.year.value.toUpperCase().tr;
    } else {
      return SubscriptionPeriodType.month.value.toUpperCase().tr;
    }
  }

  String get priceLabel {
    String periodUnit;
    if (widget.price <= 0) {
      return 'Not Available'.tr;
    }
    if (widget.period == SubscriptionPeriodType.year) {
      periodUnit = 'year'.tr;
    } else {
      periodUnit = 'month'.tr;
    }

    return '${widget.currency} ${widget.price.toString().pricingFormat}/$periodUnit';
  }

  static List<Color> defaultGradient = ['#000000'.hexToColor, '#FFFFFF'.hexToColor];

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      width: widget.width,
      height: widget.height ?? 140.spMin,
      child: Stack(
        children: [
          // Main button
          Opacity(
            opacity: widget.available ? 1 : .7,
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: ['#FFFFFF'.hexToColor, widget.backgroundOuterColor ?? '#D7E6F3'.hexToColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: '#FFFFFF'.hexToColor.withValues(alpha: 0.4),
                    spreadRadius: 0,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: widget.available ? 1 : .8,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            // color: available ? null : '#D42547'.hexToColor,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: widget.backgroundInnerColor ?? defaultGradient,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: widget.available
                                ? [
                                    BoxShadow(
                                      color: widget.shadowRect ?? Colors.black12,
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: buildBackgroundAnimation(
                            enableAnimation: false,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.spMin),
                    Text(
                      priceLabel,
                      style: TextStyle(
                        fontSize: 13.spMin,
                        fontWeight: FontWeight.w700,
                        color: '#272727'.hexToColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Chip on top of the button
          if (widget.chipLabel != null)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 24.spMin,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: widget.chipBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.available ? Colors.white : Colors.white.withValues(alpha: .8),
                    width: 3.spMin,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: Text(
                  widget.chipLabel!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.spMin,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.55,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.width != null) {
      return child;
    }

    return child;
  }

  List<Widget> buildBgMonogramSelector(double sizeFactor) {
    if (sizeFactor < 0) {
      sizeFactor = 0;
    }
    if (sizeFactor > 1) {
      sizeFactor = 1;
    }
    if (widget.period == SubscriptionPeriodType.year) {
      return List.generate(
        20,
        (index) => Padding(
          padding: EdgeInsets.only(top: index * 30),
          child: Stack(
            fit: StackFit.loose,
            children: [
              ...List.generate(
                20,
                (index) {
                  double fixedFactor = 1.0;
                  return Container(
                    margin: EdgeInsets.only(left: index * 30),
                    width: 25,
                    height: 25,
                    child: Center(
                      child: SizedBox(
                        width: 25 * sizeFactor * fixedFactor,
                        height: 25 * sizeFactor * fixedFactor,
                        child: CustomPaint(
                          painter: RoundPolygonPainter(
                            color: Colors.white12,
                            hasShadow: false,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }

    int maxnumber = 30;
    int indexChecker = (30 * sizeFactor).floor();
    return List.generate(
      maxnumber,
      (index) => Padding(
        padding: EdgeInsets.only(top: index * 13),
        child: Stack(
          children: [
            ...List.generate(
              maxnumber,
              (index) {
                double fixedFactor = 1.0;
                if (indexChecker == index) {
                  fixedFactor = 0.2;
                }
                return Container(
                  margin: EdgeInsets.only(left: index * 13),
                  width: 13,
                  height: 13,
                  child: Center(
                    child: Container(
                      width: 6 * sizeFactor * fixedFactor,
                      height: 6 * sizeFactor * fixedFactor,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white12,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundAnimation({bool enableAnimation = false}) {
    if (enableAnimation == false) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            widget.period == SubscriptionPeriodType.year
                ? UChatAssetPath.premiumPackageYearlyBackground
                : UChatAssetPath.premiumPackageMonthlyBackground,
            color: Colors.white.withValues(alpha: 0.5),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AutoSizeText(
                periodLabel,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBackground(
        vsync: this,
        behaviour: widget.period == SubscriptionPeriodType.year
            ? RandomParticleBehaviour(
                options: ParticleOptions(
                  image: Image.asset(
                    UChatAssetPath.premiumPackageIconWithoutBorder,
                  ),
                  baseColor: Colors.yellow.withValues(alpha: 0.5),
                  particleCount: 15,
                  spawnMaxSpeed: widget.available ? 10 : 0.5,
                  spawnMinSpeed: widget.available ? 5 : 0.5,
                  spawnMaxRadius: 15,
                  spawnMinRadius: 2,
                  maxOpacity: 0.35,
                  minOpacity: 0.05,
                ),
              )
            : RainParticleBehaviour(
                options: ParticleOptions(
                  baseColor: Colors.white,
                  particleCount: 20,
                  spawnMaxSpeed: widget.available ? 15 : 0.5,
                  spawnMinSpeed: widget.available ? 10 : 0.5,
                  spawnMaxRadius: 5,
                  spawnMinRadius: 2,
                  maxOpacity: 0.5,
                  minOpacity: 0.1,
                ),
                enabled: false,
              ),
        child: Stack(
          children: [
            Center(
              child: AutoSizeText(
                periodLabel,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RainParticleBehaviour extends RandomParticleBehaviour {
  static math.Random random = math.Random();

  bool enabled;

  RainParticleBehaviour({
    super.options,
    super.paint,
    this.enabled = true,
  });

  @override
  void initPosition(Particle p) {
    p.cx = random.nextDouble() * size!.width;
    if (p.cy == 0.0) {
      p.cy = random.nextDouble() * size!.height;
    } else {
      p.cy = random.nextDouble() * size!.width * 0.2;
    }
  }

  @override
  void initDirection(Particle p, double speed) {
    double dirX = (random.nextDouble() - 0.5);
    double dirY = random.nextDouble() * 0.5 + 0.5;
    double magSq = dirX * dirX + dirY * dirY;
    double mag = magSq <= 0 ? 1 : math.sqrt(magSq);

    p.dx = dirX / mag * speed;
    p.dy = dirY / mag * speed;
  }

  @override
  Widget builder(BuildContext context, BoxConstraints constraints, Widget child) {
    return GestureDetector(
      onPanUpdate: enabled ? (details) => _updateParticles(context, details.globalPosition) : null,
      onTapDown: enabled ? (details) => _updateParticles(context, details.globalPosition) : null,
      child: ConstrainedBox(
        // necessary to force gesture detector to cover screen
        constraints: const BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
        child: super.builder(context, constraints, child),
      ),
    );
  }

  void _updateParticles(BuildContext context, Offset offsetGlobal) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.globalToLocal(offsetGlobal);
    for (var particle in particles!) {
      var delta = (Offset(particle.cx, particle.cy) - offset);
      if (delta.distanceSquared < 70 * 70) {
        var speed = particle.speed;
        var mag = delta.distance;
        speed *= (70 - mag) / 70.0 * 2.0 + 0.5;
        speed = math.max(options.spawnMinSpeed, math.min(options.spawnMaxSpeed, speed));
        particle.dx = delta.dx / mag * speed;
        particle.dy = delta.dy / mag * speed;
      }
    }
  }
}
