import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_invited_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_invite_model.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/online_status_util.dart';

import 'avatar.dart';

class AvatarWrapper<M> extends StatelessWidget {
  static Color onlineColor = UTheme.color.isOnlineStatus;
  static Color busyColor = UTheme.color.isBusyStatus;
  static Color doNotDisturbColor = UTheme.color.isDoNotDisturbStatus;

  // required either room or contact
  final M? data;
  final double radius; // radius of a single circle avatar
  final Color? borderColor;
  final bool hasBorder;
  final double groupWidth; // width of box when showing group avatar
  final double groupHeight; // height of box when showing group avatar
  /// Whether to use default avatar from [defaultRoomAvatar] from [RoomInterface] or not
  /// has no effect when data is [ContactInterface], [RoomInviteModel] or room type is direct
  final bool useGravatar;

  /// [imageFile] it will be used as avatar from local file
  final File? imageFile;

  /// [imageUrl] it will be used as avatar from url server
  final String? imageUrl;

  /// [imageAvatarId] it will be used as avatar from url server by using avatarId
  final String? imageAvatarId;

  final String? roomType;

  final String? id;

  /// Radius size of online status dot.
  final double? onlineStatusSize;

  /// If false, Hide online status dot.
  final bool showOnlineStatus;

  final double? borderWidth;

  factory AvatarWrapper({
    Key? key,
    M? data,
    double? radius,
    Color? borderColor,
    double? groupWidth,
    double? groupHeight,
    bool useGravatar = false,
    bool hasBorder = true,
    File? imageFile,
    String? imageUrl,
    String? imageAvatarId,
    String? roomType,
    String? id,
    double? onlineStatusSize,
    bool showOnlineStatus = true,
    double? borderWidth,
  }) {
    radius ??= 24;
    groupWidth ??= 48;
    groupHeight ??= 48;
    onlineStatusSize ??= radius * 0.35;
    if (hasBorder) {
      borderColor ??= UTheme.color.avatarBorder;
    }

    return AvatarWrapper.raw(
      key: key,
      data: data,
      borderColor: borderColor,
      radius: radius,
      groupWidth: groupWidth,
      groupHeight: groupHeight,
      useGravatar: useGravatar,
      hasBorder: hasBorder,
      imageFile: imageFile,
      imageUrl: imageUrl,
      imageAvatarId: imageAvatarId,
      roomType: roomType,
      id: id,
      onlineStatusSize: onlineStatusSize,
      showOnlineStatus: showOnlineStatus,
      borderWidth: borderWidth,
    );
  }

  const AvatarWrapper.raw({
    super.key,
    required this.data,
    required this.radius,
    required this.groupWidth,
    required this.groupHeight,
    this.borderColor,
    this.useGravatar = false,
    this.hasBorder = true,
    this.imageFile,
    this.imageUrl,
    this.imageAvatarId,
    this.roomType,
    this.id,
    this.onlineStatusSize,
    this.showOnlineStatus = true,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: [
          Center(
            child: _buildAvatar(context),
          ),
          _buildOnlineStatus(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      if (contact.isDeleted == true) {
        return Assets.vectors.iconNoAvatar.svg();
      }
      return Avatar(
        key: ValueKey(contact.widgetKey),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: contact.hasAvatar,
        url: contact.avatarUrl,
        id: contact.avatarId,
      );
    } else if (data is RoomCollection) {
      final room = data as RoomCollection;
      if (!room.hasFirstOtherInRoom && room.isDirect) {
        return Assets.vectors.iconNoAvatar.svg();
      } else if (room.isDirect || room.hasAvatar || room.roomAvatarUrl.isNotEmpty) {
        return Avatar(
          key: ValueKey(room.widgetKey),
          radius: radius,
          borderColor: borderColor,
          borderWidth: hasBorder ? null : 0,
          hasAvatar: room.hasAvatar,
          url: room.roomAvatarUrl,
          id: room.photoId,
        );
      } else {
        return _buildGroupAvatar(context);
      }
    } else if (data is RoomInviteModel) {
      final room = data as RoomInviteModel;

      return Avatar(
        key: ValueKey(room.widgetKey),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: room.photoId != null,
        url: room.photoId == null
            ? 'https://www.gravatar.com/avatar/${room.id}?s=80&d=identicon&r=g'
            : FileService().getFileUrl(room.photoId!),
        id: room.id,
      );
    } else if (data is AddContactInvitedEntity) {
      final room = data as AddContactInvitedEntity;

      if (room.avatarId == null || room.avatarId?.isEmpty == true) {
        return Assets.vectors.iconNoAvatar.svg();
      }

      return Avatar(
        key: ValueKey(room.avatarId),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: room.avatarId != null,
        url: room.isFriendRequest == true
            ? FileService.instance.getAvatarUrl(room.avatarId!)
            : FileService.instance.getFileUrl(room.avatarId!),
        id: room.id,
      );
    } else if (data is RoomDataModel) {
      final model = data as RoomDataModel;
      final room = model.room()!;
      if (!room.hasFirstOtherInRoom && room.isDirect) {
        return Assets.vectors.iconNoAvatar.svg();
      } else if (room.isDirect || room.hasAvatar) {
        return Avatar(
          key: ValueKey(room.widgetKey),
          radius: radius,
          borderColor: borderColor,
          borderWidth: hasBorder ? null : 0,
          hasAvatar: room.hasAvatar,
          url: room.roomAvatarUrl,
          id: room.id,
        );
      } else {
        return _buildGroupAvatar(context);
      }
    } else if (data is RecentSearchCollection) {
      return Assets.vectors.recentSearchAvatar.svg();
    } else if (imageFile != null) {
      /// [imageFile] it will be used as avatar from local file
      return Avatar(
        key: ValueKey(imageFile!.path),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: false,
        image: FileImage(imageFile!),
        id: id,
      );
    } else if (imageUrl != null) {
      /// [imageUrl] it will be used as avatar from url server
      return Avatar(
        key: ValueKey(imageUrl),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? borderWidth : 0,
        hasAvatar: false,
        image: CachedNetworkImageProvider(imageUrl!),
        id: id,
      );
    } else if (imageAvatarId != null && imageAvatarId?.isNotEmpty == true) {
      /// [imageUrl] it will be used as avatar from url server
      return Avatar(
        key: ValueKey(imageAvatarId),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: false,
        url: roomType == 'GROUP'
            ? FileService.instance.getFileUrl(imageAvatarId!)
            : FileService.instance.getAvatarUrl(imageAvatarId!),
        id: id,
      );
    } else {
      return Assets.vectors.iconNoAvatar.svg();
    }
  }

  Widget _buildGroupAvatar(BuildContext context) {
    if (data is! RoomCollection) {
      return SizedBox(
        width: groupWidth,
        height: groupHeight,
      );
    }

    final room = data as RoomCollection;
    List<Widget> widgetList = [];
    if (useGravatar) {
      return Avatar(
        key: ValueKey(room.widgetKey),
        radius: radius,
        borderColor: borderColor,
        borderWidth: hasBorder ? null : 0,
        hasAvatar: room.hasAvatar,
        url: room.roomAvatarUrl,
      );
    }

    return SizedBox(
      width: groupWidth,
      height: groupHeight,
      child: Stack(
        children: widgetList,
      ),
    );
  }

  Widget _buildOnlineStatus(BuildContext context) {
    if (data == null || !showOnlineStatus) return const SizedBox.shrink();
    return Obx(() {
      final onlineStatus = OnlineStatusUtil.getRxOnlineStatus(data);
      if (onlineStatus.value == OnlineStatus.offline || !showOnlineStatus) {
        return const SizedBox.shrink();
      }
      Color color;
      switch (onlineStatus.value) {
        case OnlineStatus.online:
          color = context.theme.appColors.backgroundSuccess;
        case OnlineStatus.busy:
          color = context.theme.appColors.backgroundWarning;
        case OnlineStatus.doNotDisturb:
          color = context.theme.appColors.backgroundError;
        default:
          color = Colors.transparent;
      }

      return Positioned(
        right: 0,
        bottom: 0,
        child: CircleAvatar(
          radius: onlineStatusSize ?? radius * 0.35,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: (onlineStatusSize ?? radius) * 0.7,
            backgroundColor: color,
          ),
        ),
      );
    });
  }
}
