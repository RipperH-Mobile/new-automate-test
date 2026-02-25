import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/services/sticker_animation_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/sticker_pack_detail_screen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';

import 'message_type.dart';

class MessageTypeStickerV2Controller extends MessageTypeController {
  MessageTypeStickerV2Controller({
    required super.initMessage,
  }) {
    stickerPackId = initMessage.meta?.stickerPack ?? '';
    stickerFileId = initMessage.meta?.stickerValue ?? '';
  }

  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;
  final animatedDone = false.obs;
  late String stickerPackId;
  late String stickerFileId;

  GlobalKey? _stickerWidgetKey = GlobalKey();

  /// Get the key for the sticker widget
  GlobalKey? get stickerWidgetKey => _stickerWidgetKey;

  @override
  void onInit() {
    super.onInit();
    _loadWarModeConfig();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shouldPlay = config.getBoolSync(key: ConfigDb.getEnableWarModeConfigKey());
      if (shouldPlay == true && initMessage.id == initMessage.ref) {
        enableWarMode.value = true;
        unawaited(_triggerReverseAnimation());
      } else {
        animatedDone.value = true;
      }
    });
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
  }

  @override
  onReady() {
    // Trigger reverse animation when message appears
  }

  /// Trigger reverse animation from sticker selection to message position
  Future<void> _triggerReverseAnimation() async {
    try {
      // Get stored tap position from when user tapped the sticker
      final sourceRect = StickerAnimationService.instance.getTapPosition(
        packId: stickerPackId,
        fileId: stickerFileId,
      );
      if (sourceRect == null) return;

      // Get actual position of this message's StickerItemPreview widget
      final targetRect = _getActualStickerWidgetPosition();
      if (targetRect == null) return;

      // Start reverse animation with dynamic position tracking
      await StickerAnimationService.instance.animateSticker(
        packId: stickerPackId,
        fileId: stickerFileId,
        sourceRect: sourceRect,
        // FROM stored tap position
        targetRect: targetRect,
        // TO actual message widget position
        stickerSize: 96.0,
        // Track message widget position during animation
        targetWidgetKey: _stickerWidgetKey,
      );
    } catch (e) {
      debugPrint('Failed to trigger reverse animation: $e');
    } finally {
      _stickerWidgetKey = null;
      animatedDone.value = true;
    }
  }

  /// Get the actual position of the StickerItemPreview widget in the message
  Rect? _getActualStickerWidgetPosition() {
    try {
      final RenderBox? renderBox = _stickerWidgetKey?.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return null;

      final position = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(
        position.dx,
        position.dy,
        renderBox.size.width,
        renderBox.size.height,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> onOpenStickerDetail() async {
    if (!UChatScreenUtil.instance.isMobile) {
      UChatDialog.showCustomDialog<void, StickerPackDetailController>(
        child: (_) => StickerPackDetailScreen(stickerPackId: stickerPackId),
        tag: stickerPackId,
        init: StickerPackDetailController(
          stickerPackId: stickerPackId,
        ),
      );
    } else {
      await Get.toNamed(
        Routes.stickerDetail.replaceAll(
          ':stickerPackId',
          stickerPackId,
        ),
      );
    }
  }
}
