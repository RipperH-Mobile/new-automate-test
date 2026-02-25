import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/message_interface.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/get_name.dart';

mixin MessageMixin implements MessageInterface {
  @override
  void update(MessageInterface updateMessage, {bool saveLocalFileUrl = true}) {
    final forceRequireChange = id != updateMessage.id;
    if (updateMessage.id != null) {
      id = updateMessage.id;
    }

    if (updateMessage.roomId != null) {
      roomId = updateMessage.roomId;
    }

    if (updateMessage.ref != null || forceRequireChange) {
      ref = updateMessage.ref;
    } else {
      ref = updateMessage.id;
    }

    if (updateMessage.accountId != null || forceRequireChange) {
      accountId = updateMessage.accountId;
    }

    if (updateMessage.message != null || forceRequireChange) {
      message = updateMessage.message;
    }

    if (updateMessage.isLocked != null) {
      isLocked = updateMessage.isLocked;
    }

    if (updateMessage.isCurrentlyUnlock != null) {
      isCurrentlyUnlock = updateMessage.isCurrentlyUnlock;
    }

    if (updateMessage.type != null || forceRequireChange) {
      type = updateMessage.type;
    }

    if (updateMessage.createdAt != null || forceRequireChange) {
      createdAt = updateMessage.createdAt;
    }

    final updateMessageFiles = updateMessage.files;
    if (updateMessageFiles != null || forceRequireChange) {
      if (type == MessageType.image && files != null && saveLocalFileUrl) {
        /// When sending image, update url from local before replacing the whole
        /// files with data from server to prevent local file path in file.url from
        /// being replaced.
        /// To delete local url set saveLocalFileUrl to false.
        final updatedFiles = updateMessageFiles?.map((file) {
          final index = files!.indexWhere((element) => element.refFile == file.refFile);
          if (index != -1) {
            file.url = files![index].url;
          }
          return file;
        }).toList();

        if (updatedFiles != null) {
          files = updatedFiles;
        }
      } else {
        files = updateMessageFiles;
      }
    }

    if (updateMessage.links != null || forceRequireChange) {
      links = updateMessage.links;
    }

    if (updateMessage.meta != null || forceRequireChange) {
      meta = updateMessage.meta;
    }

    if (updateMessage.account != null || forceRequireChange) {
      account = updateMessage.account;
    }

    if (updateMessage.systemMessage != null || forceRequireChange) {
      systemMessage = updateMessage.systemMessage;
    }

    if (updateMessage.sequence != null || forceRequireChange) {
      sequence = updateMessage.sequence;
    }

    if (updateMessage.sequence != null || forceRequireChange) {
      sequence = updateMessage.sequence;
    }

    if (updateMessage.callMessage != null || forceRequireChange) {
      callMessage = updateMessage.callMessage;
    }

    if (updateMessage.replyMessage != null) {
      replyMessage = updateMessage.replyMessage;
    }

    if (updateMessage.contact != null) {
      contact = updateMessage.contact;
    }

    if (updateMessage.mobileContact != null) {
      mobileContact = updateMessage.mobileContact;
    }

    if (updateMessage.isParentDeleted != null) {
      isParentDeleted = updateMessage.isParentDeleted;
    }

    if (updateMessage.isAlreadyShowAnimatedAndSound != null) {
      isAlreadyShowAnimatedAndSound = updateMessage.isAlreadyShowAnimatedAndSound;
    }

    if (updateMessage.isEncrypted != null) {
      isEncrypted = updateMessage.isEncrypted;
    }

    if (updateMessage.lastEmojis != null) {
      lastEmojis = updateMessage.lastEmojis;
    }

    if (updateMessage.selectedReactionList != null) {
      selectedReactionList = updateMessage.selectedReactionList;
    }

    if (updateMessage.mentionList != null) {
      mentionList = updateMessage.mentionList;
    }

    if (updateMessage.emojiAmount != null) {
      emojiAmount = updateMessage.emojiAmount;
    }

    if (updateMessage.isMyNote != null) {
      isMyNote = updateMessage.isMyNote;
    }

    if (updateMessage.bookmarkEmojiTags != null) {
      bookmarkEmojiTags = updateMessage.bookmarkEmojiTags;
    }

    if (updateMessage.isDecryptFailed != null) {
      isDecryptFailed = updateMessage.isDecryptFailed;
    }

    shareContactId = updateMessage.shareContactId;
    if (updateMessage.isSending != null) {
      isSending = updateMessage.isSending;
    }

    if (updateMessage.isSendFailed != null) {
      isSendFailed = updateMessage.isSendFailed;
    }

    if (updateMessage.bookmarkMessageId != null) {
      if (updateMessage.bookmarkMessageId!.isEmpty) {
        bookmarkMessageId = null;
      } else {
        bookmarkMessageId = updateMessage.bookmarkMessageId;
      }
    }

    if (updateMessage.originalMessageId != null) {
      if (updateMessage.originalMessageId!.isEmpty) {
        originalMessageId = null;
      } else {
        originalMessageId = updateMessage.originalMessageId;
      }
    }

    if (updateMessage.originalRoomId != null) {
      if (updateMessage.originalRoomId!.isEmpty) {
        originalRoomId = null;
      } else {
        originalRoomId = updateMessage.originalRoomId;
      }
    }

    originalIsHidden = updateMessage.isHidden;
    originalIsEdited = updateMessage.isEdited;
  }

  @override
  MessageFileModel? get file {
    if (files != null && files!.isNotEmpty) {
      return files!.first;
    }

    return null;
  }

  @override
  @ignore
  String get displayName {
    return getNameHelper(
      id: accountId,
      fallback: account?.showName ?? 'UNKNOWN'.tr,
      roomId: roomId,
    );
  }

  @ignore
  String get shortDisplayName {
    final characters = displayName.characters;
    if (characters.length > 10) {
      final frontName = displayName.characters.take(5);

      return '$frontName...';
    } else {
      return displayName;
    }
  }

  @override
  String get dateKey {
    if (createdAt != null) {
      return createdAt!.toLocal().format('yyyy-MM-dd');
    }

    return DateTime.now().toLocal().format('yyyy-MM-dd');
  }

  /// Get the date header for the list of messages
  ///
  /// The date header is used to display the date of the messages in the list.
  ///
  /// If the date is today, the header will be 'Today'.
  ///
  /// If the date is yesterday, the header will be 'Yesterday'.
  ///
  /// Otherwise, the header will be the date in the format 'MMM dd, yyyy'.
  @ignore
  String get dateHeader {
    final date = createdAt?.toLocal() ?? DateTime.now();

    if (date.isToday) {
      return 'Today'.tr;
    } else if (date.isYesterday) {
      return 'Yesterday'.tr;
    } else {
      return date.format('MMM dd, yyyy');
    }
  }

  String get sentTime {
    if (createdAt != null) {
      return createdAt!.toLocal().format('HH:mm');
    }

    return DateTime.now().toLocal().format('HH:mm');
  }

  @override
  String? get timeString {
    if (sequence != null) {
      final sentAt = DateTime.fromMillisecondsSinceEpoch(sequence!).toLocal();
      return DateFormat(DateFormat.HOUR24_MINUTE).format(sentAt);
    }
    return DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now());
  }

  @override
  bool get isSent {
    return isSending != true && isSendFailed != true;
  }

  @ignore
  String get systemCallText {
    MessageCallType? type = callMessage?.type;
    MessageCallPayloadModel? payload = callMessage?.payload;
    switch (type) {
      case MessageCallType.join:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@name joined the group call'.trParams({'name': name});
        }
      case MessageCallType.leave:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@name left the group call'.trParams({'name': name});
        }

      case MessageCallType.end:
        if (payload != null) {
          return '@duration\ngroup call ended'.trParams({'duration': payload.durationString});
        }
      case MessageCallType.decline:
      case MessageCallType.timeout:
      case MessageCallType.unreachable:
      case MessageCallType.start:
        return '';
      case MessageCallType.unknown:
      default:
        break;
    }

    return type.toString();
  }

  @override
  @ignore
  String get systemText {
    MessageSystemType? type = systemMessage?.type;
    MessageSystemPayloadModel? payload = systemMessage?.payload;

    switch (type) {
      case MessageSystemType.callEnd:
        String time = formatTime(int.parse(payload?.callEndDuration ?? '0'));
        List<String> timeSplit = time.split(':'); // ex. the string: 00:02:00 (hour:minute:second)
        String durationTemp = '';
        if (timeSplit[0] != '00') {
          // ex.hour 01.08 hours
          durationTemp +=
              '@hour hours'.trParams({'hour': '${timeSplit[0]}${(timeSplit[1] != '00') ? ":${timeSplit[1]}" : ''}'});
        } else if (timeSplit[1] != '00') {
          // ex.minute 08.41 minutes
          durationTemp += '@minute minutes'
              .trParams({'minute': '${timeSplit[1]}${(timeSplit[2] != '00') ? ":${timeSplit[2]}" : ''}'});
        } else {
          // ex.second 50 seconds
          durationTemp += '@second seconds.'.trParams({'second': timeSplit[2]});
        }
        return 'Call ended. @duration'.trParams({'duration': durationTemp});
      case MessageSystemType.callStart:
        return 'Call started.'.tr;
      case MessageSystemType.callDecline:
        return 'Call declined.'.tr;
      case MessageSystemType.capturedScreen:
        if (payload != null) {
          // Check that who took a screen shot in secret chat
          String name = payload.accountId == (UserController.instance.currentUser()?.id ?? '')
              ? 'You'.tr
              : getNameHelper(
                  id: payload.accountId,
                  fallback: payload.displayName ?? displayName,
                );
          return '@name took a screenshot'.trParams({'name': '&[__1__](__${name}__)'});
        }
        return 'Someone took a screenshot'.tr;
      case MessageSystemType.createdSecretRoom:
        return 'Secret room created.'.tr;
      case MessageSystemType.destroyedSecretRoom:
        if (payload == null) {
          return 'Secret chat was ended.'.tr;
        }
        // Check that who ended the secret chat
        String name = payload.accountId == (UserController.instance.currentUser()?.id ?? '')
            ? 'You'.tr
            : getNameHelper(
                id: payload.accountId,
                fallback: payload.displayName ?? displayName,
              );

        return '@displayName ended the secret chat.'.trParams({'displayName': '&[__1__](__${name}__)'});
      case MessageSystemType.changedSecretRoomExp:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );
          return '@name edited secret chat duration'.trParams({'name': '&[__1__](__${name}__)'});
        }
        return 'Someone edited secret chat duration'.tr;

      case MessageSystemType.unknown:
        // TODO: Handle this case.
        // _log.w('MessageSystemType is unknown');
        break;
      case MessageSystemType.createGroup:
        if (payload?.createByName != null && payload?.createByName != '') {
          String name = getNameHelper(id: payload?.createBy, fallback: payload?.createByName);
          if (UserController.instance.currentUser()?.id == payload?.createBy) {
            name = 'You'.tr;
          }
          return '@createBy created the group “@groupName”'.trParams({
            'createBy': '&[__1__](__${name}__)',
            'groupName': '&[__1__](__${payload?.roomName}__)',
          });
        }
        return 'Someone created the group'.tr;
      case MessageSystemType.inviteToGroup:
        if (payload?.newMemberList != null && payload?.newMemberList!.isNotEmpty == true) {
          List<MessageSystemPayloadMemberModel> newMemberNameList = [];
          for (final newMember in payload!.newMemberList!) {
            String? name = getNameHelper(id: newMember.id, fallback: newMember.displayName);

            if (name.characters.length >= 15) {
              name = '${name.characters.take(15)}\u2026';
            }
            newMemberNameList.add(MessageSystemPayloadMemberModel(
              id: newMember.id,
              displayName: name,
            ));
          }

          if (payload.invitedByName != null && payload.invitedBy != null) {
            String invitedByName = payload.invitedByName!;
            String invitedById = payload.invitedBy!;
            if (UserController.instance.currentUser()?.id == payload.invitedBy) {
              invitedByName = 'You'.tr;
            }

            if (newMemberNameList.length <= 3) {
              final memberNames =
                  newMemberNameList.map((e) => getMentionNameHelper(id: e.id, fallback: e.displayName)).join(', ');
              final inviteByName = getMentionNameHelper(id: invitedById, fallback: invitedByName);

              return '@invitedByName added @name to the group'.trParams({
                'name': memberNames,
                'invitedByName': inviteByName,
              });
            } else if (newMemberNameList.length > 3) {
              final memberNames = newMemberNameList
                  .getRange(0, 3)
                  .map((e) => getMentionNameHelper(id: e.id, fallback: e.displayName))
                  .join(', ');
              final totalOtherNames = newMemberNameList.length - 3;
              final inviteByName = getMentionNameHelper(id: invitedById, fallback: invitedByName);

              return '@invitedByName added @name others to the group'.trParams(
                {
                  'name': '$memberNames and $totalOtherNames',
                  'invitedByName': inviteByName,
                },
              );
            }
          }
        }
        return 'New member is invited to group'.tr;
      case MessageSystemType.joinToGroup:
        if (payload != null && payload.displayName != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          if (payload.isViaLink == true) {
            return '@name has joined the group via invite link'.trParams(
              {'name': '&[__1__](__${name}__)'},
            );
          }

          return '@name has joined the group'.trParams(
            {'name': '&[__1__](__${name}__)'},
          );
        }

        return 'New member has joined the group'.tr;
      case MessageSystemType.removeFromGroup:
        if (payload != null && payload.removeMemberList != null && payload.removeMemberList!.isNotEmpty) {
          List<dynamic> removeMemberNameList = [];
          for (MessageSystemPayloadMemberModel removeMember in payload.removeMemberList!) {
            if (removeMember.id != null && removeMember.id != '') {
              String name = getNameHelper(id: removeMember.id, fallback: removeMember.displayName);
              removeMemberNameList.add(name);
              continue;
            }
          }

          if (payload.removedByName != null) {
            String removedByName = getNameHelper(
              id: payload.removedBy,
              fallback: payload.removedByName!,
            );

            if (UserController.instance.currentUser()?.id == payload.removedBy) {
              removedByName = 'You'.tr;
            }

            if (removeMemberNameList.length <= 3) {
              return '@removedByName removed @member from the group'.trParams({
                'member': removeMemberNameList.join(', '),
                'removedByName': '&[__1__](__${removedByName}__)',
              });
            } else if (removeMemberNameList.length > 3) {
              return '@removedByName removed @member others from the group'.trParams({
                'member': '${removeMemberNameList.getRange(0, 2).join(', ')} and ${removeMemberNameList.length - 3}',
                'removedByName': '&[__1__](__${removedByName}__)',
              });
            }
          }
        }

        return 'Member has been removed'.tr;
      case MessageSystemType.leaveGroup:
        String name = getNameHelper(id: payload?.accountId, fallback: payload?.displayName);
        if (UserController.instance.currentUser()?.id == payload?.accountId) {
          name = 'You'.tr;
        }
        if (payload != null) {
          return '@displayName left the group'.trParams({'displayName': '&[__1__](__${name}__)'});
        }

        return 'Member left the group'.tr;
      case MessageSystemType.leaveDirectChat:
        String name = getNameHelper(id: payload?.accountId, fallback: payload?.displayName);
        if (UserController.instance.currentUser()?.id == payload?.accountId) {
          name = 'You'.tr;
        }
        if (payload != null) {
          return '@displayName left the chat'.trParams({'displayName': '&[__1__](__${name}__)'});
        }

        return 'Member left the chat'.tr;
      //NOTE.WAIT P'POR
      case MessageSystemType.changeGroupPhoto:
        if (payload != null && displayName != '') {
          String name = getNameHelper(id: payload.accountId, fallback: payload.displayName);

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }
          return '@displayName changed group profile picture'.trParams({'displayName': '&[__1__](__${name}__)'});
        }

        return 'Group Photo has been changed'.tr;
      case MessageSystemType.changeGroupName:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName,
          );
          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }
          return '@displayName edit the group name to “@newRoomName”'.trParams({
            'displayName': '&[__1__](__${name}__)',
            'newRoomName': payload.newRoomName ?? '',
          });
        }

        return 'Group name has been changed'.tr;
      case MessageSystemType.changeAlbumName:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );
          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName changed name of the album @oldAlbumName to @newAlbumName'.trParams({
            'displayName': '&[__1__](__${name}__)',
            'oldAlbumName': payload.oldAlbumName ?? '',
            'newAlbumName': payload.newAlbumName ?? '',
          });
        }
        return 'Album name has been changed'.tr;
      case MessageSystemType.createdAlbum:
        if (payload == null) {
          return 'Album created'.tr;
        }

        String name = getNameHelper(
          id: payload.accountId,
          fallback: payload.displayName ?? displayName,
        );

        if (UserController.instance.currentUser()?.id == payload.accountId) {
          name = 'You'.tr;
        }

        return '@displayName created album'.trParams({
          'displayName': '&[__1__](__${name}__)',
        });
      case MessageSystemType.removeAlbum:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName deleted @albumName album'.trParams({
            'displayName': '&[__1__](__${name}__)',
            'albumName': payload.albumName ?? '',
          });
        }

        return 'Someone have been removed an album'.tr;
      case MessageSystemType.removeImageAlbum:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName removed a photo from the @albumName album'.trParams({
            'displayName': '&[__1__](__${name}__)',
            'albumName': payload.albumName ?? '',
          });
        }
        return 'someone have been removed image in album';
      case MessageSystemType.changeOwner:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName has been assigned the role of “Group owner”'.trParams({
            'displayName': '&[__1__](__${name}__)',
          });
        }
        return 'Owner has been changed'.tr;
      case MessageSystemType.unSentMessage:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName unsend a message'.trParams({
            'displayName': '&[__1__](__${name}__)',
          });
        }
        return 'Someone unsend a message'.tr;
      case MessageSystemType.pinMessage:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName pinned a message'.trParams({
            'displayName': '&[__1__](__${name}__)',
          });
        }

        return 'Someone pinned a message'.tr;

      case MessageSystemType.unPinMessage:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName unpinned a message'.trParams({
            'displayName': '&[__1__](__${name}__)',
          });
        }
        return 'Someone unpinned a message'.tr;

      case MessageSystemType.unPinAllMessage:
        if (payload != null) {
          String name = getNameHelper(
            id: payload.accountId,
            fallback: payload.displayName ?? displayName,
          );

          if (UserController.instance.currentUser()?.id == payload.accountId) {
            name = 'You'.tr;
          }

          return '@displayName unpinned all messages'.trParams({
            'displayName': '&[__1__](__${name}__)',
          });
        }
        return 'Someone unpinned all messages'.tr;
      default:
        break;
    }

    return type.toString();
  }

  @override
  bool get isSystemMessage {
    return type == MessageType.system;
  }

  @override
  bool get isCallMessage {
    return type == MessageType.callMsg;
  }

  @override
  bool get isUnsentMessage {
    return type == MessageType.unsent;
  }

  @override
  bool get isRemoveMessage {
    return type == MessageType.remove;
  }

  @override
  bool get isMediaMessage {
    return type == MessageType.file ||
        type == MessageType.image ||
        type == MessageType.audio ||
        type == MessageType.video;
  }

  @override
  bool get canCopyMessage {
    return (type == MessageType.text || type == MessageType.edit) && (isLocked != true || isCurrentlyUnlock == true);
  }

  @override
  bool get canEditMessage {
    if (isLocked == true && isCurrentlyUnlock != true) return false;
    if (createdAt == null) return false;
    if (isHidden) return false;
    //? This condition should check on server as well !
    if (createdAt!.addDays(1).isAfter(DateTime.now())) {
      return (type == MessageType.text || type == MessageType.edit) && mine && isSent;
    }
    return false;
  }

  @override
  bool get canShare {
    final includingList = [
      MessageType.text,
      MessageType.edit,
      MessageType.image,
      MessageType.location,
      MessageType.file,
      MessageType.video,
      MessageType.audio,
    ];
    return includingList.contains(type) && isSent && (isLocked != true || isCurrentlyUnlock == true);
  }

  @override
  bool get canBookmark {
    return type != MessageType.unsent &&
        isSent &&
        type != MessageType.album &&
        type != MessageType.callMsg &&
        type != MessageType.system;
  }

  @override
  bool get canReportMessage {
    return !mine && !isSystemMessage;
  }

  @Deprecated('Hide message function is removed')
  @override
  bool get canHideMessage {
    return !isUnsentMessage && !isHidden && !isSystemMessage;
  }

  @Deprecated('Hide message function is removed')
  @override
  bool get canUnHideMessage {
    return !isUnsentMessage && isHidden && !isSystemMessage;
  }

  @override
  bool get canDeleteMessage {
    return mine &&
        type != MessageType.unsent &&
        isSent &&
        type != MessageType.album &&
        type != MessageType.callMsg &&
        type != MessageType.system;
  }

  @override
  bool get canDeleteOthersMessage {
    return !mine &&
        type != MessageType.unsent &&
        isSent &&
        type != MessageType.album &&
        type != MessageType.callMsg &&
        type != MessageType.system;
  }

  @override
  bool get canReply {
    return type != MessageType.system &&
        type != MessageType.unsent &&
        type != MessageType.remove &&
        type != MessageType.removeOthers &&
        type != MessageType.mobileContact &&
        type != MessageType.contact &&
        type != MessageType.stickerGift &&
        isSent &&
        //NOTE.if report and hidden == true but for now doesn't have
        // isHidden != true &&
        callMessage == null &&
        isDecryptFailed != true;
  }

  @override
  bool get canReact {
    // Can not react to these type.
    return ![
      MessageType.system,
      MessageType.callMsg,
      MessageType.remove,
      MessageType.removeOthers,
      MessageType.album,
    ].contains(type);
  }

  @override
  bool get mine {
    return UserController.instance.currentUser()?.id == accountId;
  }

  @override
  bool get canAddToAlbum {
    return type == MessageType.image && isSent && isLocked != true;
  }
}
