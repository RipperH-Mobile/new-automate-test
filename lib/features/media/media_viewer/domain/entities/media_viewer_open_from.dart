enum MediaViewerOpenFrom {
  // open from room_messages_screen
  // TODO (improve) Recheck this. Maybe this is not used anymore and use chatRoom instead
  @Deprecated('Recheck this. Maybe this is not used anymore and use chatRoom instead')
  roomMessage('roomMessage'),
  // open from profile_screen
  profileAvatar('profileAvatar'),
  // open from room_detail_screen
  roomDetail('roomDetail'),
  // open from room_detail_photos_and_videos_screen
  // TODO (improve) Recheck this. Maybe this is not used anymore and use roomDetail instead
  @Deprecated('Recheck this. Maybe this is not used anymore and use roomDetail instead')
  roomDetailPhotoAndVideo('roomDetailPhotoAndVideo'),
  // open from album_detail_screen
  albumDetail('albumDetail'),
  // open from bookmark_photos_and_videos_tab
  bookmarkPhotosAndVideosTab('bookmarkPhotosAndVideosTab'),
  // open from chat_room_screen (chat_room_controller)
  chatRoom('chatRoom');

  final String value;
  const MediaViewerOpenFrom(this.value);

  factory MediaViewerOpenFrom.fromString(String screenName) {
    return values.firstWhere((e) => e.value == screenName);
  }
}
