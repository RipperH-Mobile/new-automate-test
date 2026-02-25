import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/chat_room/data/models/models/link_metadata_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/utils/fix_url.dart';
import 'package:uchat/utils/link_preview_wrapper.dart';

extension LinkPreviewExtension on String? {
  Future<List<MessageLinkModel>?> toMessageLinks() async {
    final text = this;

    if (text == null || text.isEmpty) return null;

    final urls = _extractAllUrls(text);
    if (urls.isEmpty) return null;

    final linkPreviewWrapper = GetIt.I<LinkPreviewWrapper>();
    final messageLinks = <MessageLinkModel>[];

    for (final url in urls) {
      try {
        final metadata = await linkPreviewWrapper.getMetadata(link: url);

        if (metadata != null) {
          final linkMetadata = LinkMetadataModel.fromAnyLinkPreview(metadata: metadata, url: url);
          messageLinks.add(linkMetadata.toMessageLinkModel());
        }
      } catch (_) {
        // continue processing other URLs
        continue;
      }
    }

    return messageLinks.isEmpty ? null : messageLinks;
  }

  List<String> _extractAllUrls(String text) {
    if (text.isEmpty) return [];

    return RegExp(UChatConstant.urlRegexPattern)
        .allMatches(text)
        .map((match) => match.group(0)?.trim() ?? '')
        .where((match) => match.isNotEmpty)
        .map((match) => ensureUrlHasScheme(match))
        .toSet()
        .toList();
  }
}
