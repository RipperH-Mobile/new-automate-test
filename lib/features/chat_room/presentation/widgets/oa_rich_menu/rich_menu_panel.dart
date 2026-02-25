import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/extension/extension_url.dart';
import 'package:uchat/utils/image/uchat_image.dart';

/// A callback type for handling rich menu function taps
typedef OnRichMenuFunctionTap = void Function(RichMenuFunctionModel function);

/// RichMenuPanel Widget
///
/// Displays a rich menu with clickable areas that scale responsively
/// to fit any screen width while maintaining the original aspect ratio.
///
/// Features:
/// - Responsive scaling based on screen width
/// - Positioned clickable areas based on API response
/// - Background image support
/// - Handles various command types (OPEN_URL, SEND_MESSAGE, etc.)
class RichMenuPanel extends StatelessWidget {
  const RichMenuPanel({
    super.key,
    this.richMenu,
    this.isLoading = false,
    this.onFunctionTap,
    this.onSendMessage,
  });

  /// The rich menu data to display
  final RichMenuModel? richMenu;

  /// Whether the widget is in loading state
  final bool isLoading;

  /// Callback when any function area is tapped
  final OnRichMenuFunctionTap? onFunctionTap;

  /// Callback when SEND_MESSAGE command is triggered
  final void Function(String message)? onSendMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState(context);
    }

    if (richMenu == null || !richMenu!.hasPublishedMenu) {
      return const SizedBox.shrink();
    }

    return _buildRichMenu(context);
  }

  Widget _buildLoadingState(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      child: const AspectRatio(
        aspectRatio: 4 / 3,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildRichMenu(BuildContext context) {
    final publishMenu = richMenu!.publishMenu!;
    final container = publishMenu.container;
    final functions = publishMenu.actions;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 600,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (container == null || functions == null || functions.isEmpty) {
            return const SizedBox.shrink();
          }

          // Calculate scale factor based on available width
          final double availableWidth = constraints.maxWidth;
          final double scaleFactor = _calculateScaleFactor(
            availableWidth: availableWidth,
            availableHeight: constraints.maxHeight,
            originalWidth: container.width.toDouble(),
            originalHeight: container.height.toDouble(),
          );

          // Calculate scaled dimensions
          final double scaledWidth = container.width * scaleFactor;
          final double scaledHeight = container.height * scaleFactor;

          return SizedBox(
            width: scaledWidth,
            height: scaledHeight,
            child: Stack(
              children: [
                // Background image
                _buildBackgroundImage(container, scaledWidth, scaledHeight),

                // Clickable function areas
                ...functions.map(
                  (function) => _buildFunctionArea(
                    context: context,
                    function: function,
                    scaleFactor: scaleFactor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Calculate scale factor to fit the menu within available width
  double _calculateScaleFactor({
    required double availableWidth,
    required double originalWidth,
    required double availableHeight,
    required double originalHeight,
  }) {
    // // Scale to fit the available width
    // return availableWidth / originalWidth;
    // Scale to fit both width and height while maintaining aspect ratio
    final widthScale = availableWidth / originalWidth;
    final heightScale = availableHeight / originalHeight;
    return widthScale < heightScale ? widthScale : heightScale;
  }

  Widget _buildBackgroundImage(
    RichMenuContainerModel container,
    double width,
    double height,
  ) {
    final officialAccountId = richMenu?.officialAccountId;
    final imageId = container.imageId;
    if (imageId == null || imageId.isEmpty || officialAccountId == null || officialAccountId.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
      );
    }
    final imageUrl = FileService.instance.getOfficialRichMenuImage(imageId, officialAccountId);

    return UChatImage.network(
      imageUrl,
      key: key,
      fit: BoxFit.cover,
      width: width,
      height: height,
      customLoadingWidget: (state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitRing(
          color: Colors.grey.withAlpha(50),
          lineWidth: 1,
        ),
      ),
      cache: true,
      maxBytes: UChatConstant.maxImageCacheSize,
      customErrorWidget: (state) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.error_outline, color: Colors.grey),
        ),
      ),
      cacheMaxAge: const Duration(days: 365),
    );
  }

  Widget _buildFunctionArea({
    required BuildContext context,
    required RichMenuFunctionModel function,
    required double scaleFactor,
  }) {
    if (function.x == null || function.y == null || function.width == null || function.height == null) {
      return const SizedBox.shrink();
    }
    // Scale the position and size
    final double scaledX = function.x! * scaleFactor;
    final double scaledY = function.y! * scaleFactor;
    final double scaledWidth = function.width! * scaleFactor;
    final double scaledHeight = function.height! * scaleFactor;

    return Positioned(
      left: scaledX,
      top: scaledY,
      width: scaledWidth,
      height: scaledHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleFunctionTap(context, function),
          splashColor: context.theme.appColors.backgroundGray.withValues(alpha: 0.2),
          highlightColor: context.theme.appColors.backgroundGray.withValues(alpha: 0.1),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  void _handleFunctionTap(BuildContext context, RichMenuFunctionModel function) {
    // Call the generic callback if provided
    onFunctionTap?.call(function);

    // Handle specific command types
    switch (function.command) {
      case RichMenuFunctionModel.commandOpenUrl:
        _handleOpenUrl(function);
        break;
      case RichMenuFunctionModel.commandSendMessage:
        _handleSendMessage(function);
        break;
      default:
        debugPrint('Unknown command: ${function.command}');
    }
  }

  Future<void> _handleOpenUrl(RichMenuFunctionModel function) async {
    final url = function.commandArg?.url;
    if (url == null || url.isEmpty) return;

    url.openInWebBrowser();
  }

  void _handleSendMessage(RichMenuFunctionModel function) {
    final message = function.commandArg?.message;
    if (message == null || message.isEmpty) return;

    onSendMessage?.call(message);
  }
}
