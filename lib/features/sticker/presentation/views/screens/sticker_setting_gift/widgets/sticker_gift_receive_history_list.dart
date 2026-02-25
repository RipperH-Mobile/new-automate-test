import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_received_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerGiftReceiveHistoryList extends StatelessWidget {
  final List<StickerGiftReceivedEntity> receivedHistoryList;
  final ScrollController scrollController;
  final Function(String) onPressed;

  const StickerGiftReceiveHistoryList({
    super.key,
    required this.receivedHistoryList,
    required this.scrollController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: receivedHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        final gift = receivedHistoryList[index];
        return StickerPackListItem(
          title: gift.packName,
          customSubtitle: Row(
            children: [
              Flexible(
                child: AppText.body3(
                  'From @name'.trParams({
                    'name': gift.giftBy,
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
