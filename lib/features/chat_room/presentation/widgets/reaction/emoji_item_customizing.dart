import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/uchat_image.dart';

class EmojiItemCustomizing extends StatelessWidget {
  const EmojiItemCustomizing({
    super.key,
    this.fileId,
    this.onTap,
    this.active = false,
  });

  final String? fileId;
  final void Function()? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (fileId == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: UChatDimensions.emojiCustomizeItemSize,
        height: UChatDimensions.emojiCustomizeItemSize,
        padding: EdgeInsets.all(
          active ? 12.spMin : 13.spMin,
        ),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  colors: [
                    Color(0xFFBCE2F4),
                    Color(0xFFECF7FC),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: active ? null : const Color(0xFFF2F2F2),
          border: active
              ? Border.all(
                  color: const Color(0xFFADDBF0),
                  width: 1.0,
                )
              : null,
          shape: BoxShape.circle,
        ),
        child: UChatImage.network(
          FileService.instance.getEmojiUrl(
            fileId!,
          ),
        ),
      ),
    );
  }
}
