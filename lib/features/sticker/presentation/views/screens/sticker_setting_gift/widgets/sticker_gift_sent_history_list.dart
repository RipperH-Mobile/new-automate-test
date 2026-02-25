import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_sent_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerGiftSentHistoryList extends StatelessWidget {
  final List<StickerGiftSentEntity> sentHistoryList;
  final ScrollController? scrollController;
  final Function(String) onPressed;

  const StickerGiftSentHistoryList({
    super.key,
    required this.sentHistoryList,
    required this.scrollController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: sentHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        final gift = sentHistoryList[index];
        return StickerPackListItem(
          title: gift.packName,
          customSubtitle: Row(
            children: [
              Flexible(
                child: AppText.body3(
                  'To @name'.trParams({
                    'name': gift.giftTo,
                  }),
                  context: context,
                  color: context.theme.appColors.textLight,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              AppText.body3(
                ' - ${gift.receivedAt.toLocal().format('dd/MM/yyyy')}',
                context: context,
                color: context.theme.appColors.textLight,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          packId: gift.packId,
          fileId: gift.packCoverId,
          hasDivider: true,
          onPressed: () {
            onPressed(gift.packId);
          },
        );
      },
    );
  }
}
