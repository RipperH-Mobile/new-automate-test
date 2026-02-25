import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';

class TroubleshootExpandableMenu extends StatefulWidget {
  const TroubleshootExpandableMenu({super.key});

  @override
  State<TroubleshootExpandableMenu> createState() => _TroubleshootExpandableMenuState();
}

class _TroubleshootExpandableMenuState extends State<TroubleshootExpandableMenu>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleMenu() {
    if (_isExpanded) {
      _animationController.reverse().then((_) {
        _removeOverlay();
        setState(() {
          _isExpanded = false;
        });
      });
    } else {
      setState(() {
        _isExpanded = true;
      });
      _showOverlay();
      _animationController.forward();
    }
  }

  void _navigateToPage(String route) {
    // Close menu first
    _animationController.reverse().then((_) {
      _removeOverlay();
      setState(() {
        _isExpanded = false;
      });
      // Then navigate
      Get.toNamed(route);
    });
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Invisible barrier to detect taps outside
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleMenu,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.0),
                ),
              ),
            ),
            // Menu items
            ...List.generate(
              _getMenuItemsData().length,
              (index) {
                final item = _getMenuItemsData()[index];
                final offset = -60.0 - (index * 50.0);
                return Positioned(
                  left: position.dx + (buttonSize.width / 2) - 20,
                  top: position.dy + (buttonSize.height / 2) - 20,
                  child: AnimatedBuilder(
                    animation: _expandAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, offset * _expandAnimation.value),
                        child: Transform.scale(
                          scale: _expandAnimation.value,
                          child: Opacity(
                            opacity: _expandAnimation.value,
                            child: FloatingActionButton(
                              mini: true,
                              heroTag: item['tag'],
                              onPressed: item['onPressed'] as VoidCallback?,
                              backgroundColor: item['color'] as Color,
                              child: Icon(
                                item['icon'] as IconData,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  List<Map<String, dynamic>> _getMenuItemsData() {
    final List<Map<String, dynamic>> items = [];

    // Troubleshoot button - always visible
    items.add({
      'tag': 'troubleshoot_fab',
      'icon': Icons.build,
      'color': Colors.greenAccent,
      'onPressed': () => _navigateToPage(Routes.settingTroubleshoot),
    });

    // Talker button - conditional
    try {
      if (UserController.instance.enableTalker) {
        items.add({
          'tag': 'talker_fab',
          'icon': Icons.bug_report,
          'color': Colors.orangeAccent,
          'onPressed': () => _navigateToPage(Routes.settingTalker),
        });
      }
    } catch (e) {
      // Handle if UserController is not ready
    }

    // Event Monitor button - conditional (based on enableEventBusTracking)
    try {
      if (HomeController.instance.appSettingsController.enableEventBusTracking.value) {
        items.add({
          'tag': 'event_monitor_fab',
          'icon': Icons.monitor_heart,
          'color': Colors.purpleAccent,
          'onPressed': () => _navigateToPage(Routes.troubleshootEventMonitor),
        });
      }
    } catch (e) {
      // Handle if controllers are not ready
    }

    // Settings button - always visible
    items.add({
      'tag': 'settings_fab',
      'icon': Icons.settings,
      'color': Colors.blueAccent,
      'onPressed': () => _navigateToPage(Routes.setting),
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'main_troubleshoot_fab',
      onPressed: _toggleMenu,
      tooltip: 'Troubleshoot easy access',
      backgroundColor: _isExpanded ? Colors.redAccent : Colors.limeAccent,
      child: AnimatedRotation(
        turns: _isExpanded ? 0.125 : 0,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _isExpanded
              ? const Icon(Icons.close, color: Colors.white)
              : Assets.vectors.troubleshootEasyAccess.svg(),
        ),
      ),
    );
  }
}