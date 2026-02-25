import 'dart:async';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:share_handler/share_handler.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/extension/extension_link_preview.dart';

import '../../analytics/logger_service.dart';

class ShareHandler {
  StreamSubscription? _shareMediaSubscription;

  SharedMedia? _initialShareMedia;

  SharedMedia? get initialShareMedia => _initialShareMedia;

  static final _urlRegExp = RegExp(UChatConstant.urlRegexPattern);

  Future<void> initialize() async {
    try {
      final handler = ShareHandlerPlatform.instance;
      final media = await handler.getInitialSharedMedia();

      if (media != null) {
        useLogger().d(
          'File or text is shared to uchat on startup.\n'
          'file count is ${media.attachments?.length}.\n'
          'text is ${media.content}.',
        );
        _initialShareMedia = media;
      }

      _shareMediaSubscription = handler.sharedMediaStream.listen(
        (SharedMedia media) async {
          useLogger().d(
            'File or text is shared to uchat. \n'
            'File count is ${media.attachments?.length} \n'
            'Next is ${media.content}',
          );

          handleShare(media);
        },
        onError: (e, stackTrace) {
          useLogger().e('Media stream error.', e, stackTrace);
        },
      );
    } catch (e, stackTrace) {
      useLogger().e('Error in initShareHandler.', e, stackTrace);
    }
  }

  void dispose() {
    _shareMediaSubscription?.cancel();
  }

  Future<void> handleShare(SharedMedia media) async {
    try {
      final attachments = media.attachments ?? [];
      final content = media.content;
      final fileList = <File>[];
      if (attachments.isNotEmpty && content?.startsWith('https://apps.apple.com/') != true) {
        for (final attachment in media.attachments!) {
          if (attachment != null) {
            fileList.add(File(attachment.path));
          }
        }
      }

      MessageCollection? newMessage;
      // handle text share only
      if (content != null && content.isNotEmpty) {
        List<MessageLinkModel>? messageLinks;

        if (_ignoreAppLink(content)) {
          useLogger().d('Ignore share content: $content');
        } else {
          messageLinks = await content.toMessageLinks();
        }
        newMessage = MessageCollection(
          type: MessageType.text,
          message: content,
          links: messageLinks,
        );
      }

      if (fileList.isNotEmpty || newMessage != null) {
        await GetIt.I<SharingService>().share(
          data: ShareBottomSheetDataEntity(
            fileList: fileList,
            newMessage: newMessage,
          ),
        );
      }
    } catch (e, stackTrace) {
      useLogger().e('HandleShareToUChat error.', e, stackTrace);
    }
  }

  bool _ignoreAppLink(String content) {
    if (content.isEmpty) return true;

    // ignore share if content contains url that is uchat deep link, add friend link, reset password link, or room invite link
    if (_urlRegExp.hasMatch(content)) {
      final contentUri = Uri.tryParse(content);

      // if cannot parse uri, do not ignore
      if (contentUri == null) {
        return false;
      }

      // ignore if scheme is deep link scheme
      final scheme = contentUri.scheme;
      if (scheme.startsWith(AppEnv.schemeDeepLink)) {
        // ignore share if it is deep link
        return true;
      }

      // ignore share if it is https scheme with host name matching uchat host name, but with out www
      content = content.replaceFirst('www.', '');
      if (content.startsWith(AppEnv.addFriendPrefix) ||
          content.startsWith(AppEnv.resetPasswordPrefix) ||
          content.startsWith(AppEnv.stickerSharingPrefix) ||
          content.startsWith(AppEnv.roomInviteLinkPrefix)) {
        return true;
      }
    }

    return false;
  }
}
