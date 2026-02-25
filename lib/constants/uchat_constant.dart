import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/entities/enum/message_type.dart';

class UChatConstant {
  // max bytes image cache size 200KB
  static const int maxImageCacheSize = 200 * 1024;

  // max bytes avatar cache size 100 KB
  static const int maxAvatarCacheSize = 100 * 1024;

  /// Max image per message, default is `10` images
  static const int maxFilePerMessage = 10;

  /// Max message room open number, default is `10` rooms
  /// When user open more than this number, the oldest room will be closed
  static const int maxRoomOpenNumber = 10;

  /// File size limit in byte, default is `104857600` bytes (100MB)
  static const int fileSizeLimit = 104857600;

  /// Batch size for sending message with file, default is `3` files per batch
  static const int sendFileBatchSize = 3;

  /// Max message input length, default is `5120` characters
  static const int maxMessageInputLength = 5120;
  static const int maxGroupNameInputLength = 30;

  /// Default page size for chat messages, default is `100` messages
  /// This is used for fetching chat messages from the server
  static const int defaultPageSize = 100;

  @Deprecated('Using "maxTextCharacter" instead')
  static const maxTextLengthShow = 1051;
  @Deprecated('Using "maxTextCharacter" instead')
  static const maxMinimizeText = 1051;
  @Deprecated('Using "maxTextCharacter" instead')
  static const minMinimizeText = 531;

  static const maxTextCharacter = 512;

  static const messageFetchTimeOut = 5000;

  /// Default message load limit, default is `100` messages (used for local message pagination)
  /// [defaultPageSize % messageLoadLimit] should be 0
  /// for correct jumpTo reply message or search message loop calculation function
  static const int messageLoadLimit = 100;

  // `messageLoadLimitInitial` number should MORE THAN (screen_height / min(any_type_of_message_height))
  // to avoid white space in the top of message list after open room and
  // scrolling doesn't work and unable to load more message
  static const int messageLoadLimitInitial = 50;

  /// RegEx for phone numbers pattern
  static const String regExPhoneNumberPattern = r'\b(\+?\d{1,4}[\s\-]?)?(\(?\d{3}\)?[\s\-]?)?\d{3}[\s\-]?\d{4}\b';

  /// RegEx for email pattern
  static const String regExEmailPattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';

  /// RegEx for mention pattern
  static const String mentionRegexPattern = r'@\[__(\w*)__\]+\(__(.*?)__\)';

  /// RegEx for read more pattern
  static const String lessMoreRegexPattern = r'#\[__(\w*)__\]+\(__(.*?)__\)';

  // static const String urlRegexPattern =
  //     r"(?:(?:https?|ftp|file|data):\/\/(?:(?:[\w\.\-\+!~\*'\(\);&=\$,%]+(?::[\w\.\-\+!~\*'\(\);&=\$,%]*)?@)?(?:(?:\[[0-9a-f]*:[0-9a-f:]+\])|(?:[\w\.\-]+(?:\.[\w\.\-]+)*))(?::[0-9]+)?)|(?:www\.[\w\.\-]+(?:\.[\w\.\-]+)+))(?:\/(?:[\w\.\-\+~!*'\(\);\/\?:@&=\$,%#]|[^\x00-\x7F])*)?";

  /// Regex สำหรับ URL ที่ครอบคลุมกรณีต่างๆ:
  /// 1. URL ที่มี scheme (http, https, ftp, file)
  ///    - ตัวอย่าง: https://example.com, ftp://files.server.com, file:///path/to/file
  /// 2. Data URIs
  ///    - ตัวอย่าง: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==
  /// 3. URL ที่ขึ้นต้นด้วย www.
  ///    - ตัวอย่าง: www.google.com, www.facebook.com
  /// 4. Domain name ทั่วไป (เช่น example.com) โดยไม่รวมอีเมล
  ///    - ตัวอย่าง: example.com, sub.domain.org:8080/path
  /// 5. ที่อยู่ IP (IPv4)
  ///    - ตัวอย่าง: 192.168.1.1, 10.0.0.1:8080/path
  /// 6. ที่อยู่ IP (IPv6)
  ///    - ตัวอย่าง: [2001:db8::1], [::1]:8080/path
  /// 7. Protocol patterns like tel:, v:, x:, a:, b:, abcdef123:, v;, v, (matches number/IP part only)
  ///    - ตัวอย่าง: tel:1.1.1.1 (matches "1.1.1.1"), v:1.1.1.1 (matches "1.1.1.1"), abcdef123:09987654321 (matches "09987654321")
  static const String urlRegexPattern =
      r'''(?:(?:https?|ftp|file)://[^\s<>"']+|data:[^;]+;[^,]+,[^\s<>"']*|(?<=(?:tel|[a-zA-Z0-9]+)[:;,])(?:[0-9]{10,11}|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|www\.[^\s<>"']+|(?<=^|[\s<>"])(?:(?:[a-zA-Z0-9][a-zA-Z0-9-]*(?:[a-zA-Z0-9])?)\.)+(?:co\.uk|co\.jp|co\.th|ac\.th|or\.th|com|net|org|edu|gov|mil|int|co|uk|ca|de|jp|fr|au|us|ru|ch|it|nl|se|no|es|ly|tv|io|me|be|am|fm|ws)(?::[0-9]+)?(?:/[^\s<>"']*)?(?![^\s<>"']*@[^\s<>"']*\.[a-zA-Z]{2,})|(?<![VvA-Za-z0-9])(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?::[0-9]+)?(?:/[^\s<>"']*)?|\[[0-9a-f]*:[0-9a-f:]+\](?::[0-9]+)?(?:/[^\s<>"']*)?)''';

  /// RegEx for system message display name pattern
  static const String systemMessageDisplayNameRegexPattern = r'&\[__(\w*)__\]+\(__(.*?)__\)';

  static const int typingTimeout = 8;

  static const int secondsInOnlineStatus = 600;

  static const String friendStatus = 'FRIEND_STATUS';

  static const String groupStatus = 'GROUP_STATUS';

  static const String groupRequestStatus = 'GROUP_REQUEST_STATUS';

  /// Supported video file type
  static const List<String> supportVideoExtensionList = [
    'mp4',
    'mov',
    'avi',
    'webm',
    '3gp',
    'wmv',
    'mov',
  ];

  static const List<String> supportImageExtensionList = [
    'webp',
    'jpg',
    'jpeg',
    'png',
    'heic',
    'heif',
    'tiff',
    'tif',
    'dng',
  ];

  static const List<String> supportAudioExtensionList = [
    'mp3',
    'wav',
    'aac',
    'flac',
    'm4a',
    'ogg',
  ];

  static const List<String> supportGifExtensionList = [
    'gif',
  ];

  static const List<String> unsupportedAudioMimeList = [
    r'audio/ogg',
  ];

  /// unsupported video file type.
  /// When sending video with these mime. It will be sent as a message type file.
  static const List<String> unsupportedVideoMimeList = [
    r'video/x-ms-wmv',
    r'video/x-ms-asf', // also mime for wmv -> https://stackoverflow.com/a/53676669
    r'video/ogg',
  ];

  /// Supported video file type for iOS.
  /// Any other video file type will be shown as a message type file.
  static const List<String> supportedVideoMimeListIos = [
    r'video/mp4',
    r'video/quicktime', // .mov
  ];

  /// Supported video file type for Android.
  /// Any other video file type will be shown as a message type file.
  static const List<String> supportedVideoMimeListAndroid = [
    r'video/vnd.avi',
    r'video/x-msvideo', // .avi
    r'video/webm',
    r'video/mp4',
    r'video/quicktime', // .mov
  ];

  /// Supported image file type
  /// Any other image file type will be shown as a message type file.
  static const List<String> supportedImageMimeListIos = [
    r'image/jpeg',
    r'image/png',
    r'image/gif',
    r'image/tiff',
    r'image/tif',
    r'image/webp',
    r'image/heif',
    r'image/heic',
    r'image/dng',
    r'image/x-fuji-raf',
    r'image/x-sony-arw',
    r'image/x-adobe-dng',
    r'image/x-canon-cr3',
    r'image/x-panasonic-raw',
    r'image/x-panasonic-rw2',
    r'image/x-nikon-nef',
  ];

  static const List<String> supportedImageMimeListAndroid = [
    r'image/jpeg',
    r'image/png',
    r'image/gif',
    r'image/webp',
    r'image/dng',
    r'image/x-fuji-raf',
    r'image/x-sony-arw',
    r'image/x-adobe-dng',
    r'image/x-canon-cr3',
    r'image/x-panasonic-raw',
    r'image/x-panasonic-rw2',
    r'image/x-nikon-nef',
  ];

  static String msgTagFormat({String? ref, String? sequence, String? roomId}) {
    return 'MSG-${ref ?? sequence}-$roomId';
  }

  static const List<MessageType> canShareToOtherAppTypeList = [
    MessageType.text,
    MessageType.image,
    MessageType.video,
    MessageType.file,
    MessageType.audio,
  ];

  static const List<MessageType> canShareTypeList = [
    MessageType.text,
    MessageType.image,
    MessageType.video,
    MessageType.audio,
    MessageType.file,
    MessageType.location,
    MessageType.contact,
    MessageType.mobileContact,
    MessageType.stickerSharing,
  ];

  static const List<MessageType> canDeleteTypeList = [
    MessageType.text,
    MessageType.gif,
    MessageType.sticker,
    MessageType.album,
    MessageType.image,
    MessageType.video,
    MessageType.audio,
    MessageType.file,
    MessageType.location,
    MessageType.contact,
    MessageType.mobileContact,
    MessageType.stickerSharing,
  ];

  static const List<MessageType> canUnsentTypeList = [
    MessageType.text,
    MessageType.gif,
    MessageType.sticker,
    MessageType.album,
    MessageType.image,
    MessageType.video,
    MessageType.audio,
    MessageType.file,
    MessageType.location,
    MessageType.contact,
    MessageType.mobileContact,
    MessageType.stickerSharing,
  ];

  static const List<MessageType> messageTypeMessageGroupPermission = [
    MessageType.text,
    MessageType.location,
    MessageType.contact,
    MessageType.mobileContact,
    MessageType.stickerSharing,
  ];

  static const List<MessageType> messageTypeMediaGroupPermission = [
    MessageType.sticker,
    MessageType.file,
    MessageType.image,
    MessageType.audio,
    MessageType.video,
    MessageType.gif,
  ];

  static List<String> fallbackStickerPackId = <String>[
    'meme_pack',
    'fomushkina',
    'pusheen',
    'dota_stickers',
  ];

  static const messageSelectionAnimateDuration = Duration(milliseconds: 150);

  static const int roomDetailAlbumPreviewCount = 10;

  /// How many image can be select per upload.
  static const int albumUploadLimit = 50;

  /// How many second to wait before download image timeout.
  static const int albumImageDownloadTimeout = 15;
  static const int albumImageUploadTimeout = 15;

  /// Typing time out, default is `8` seconds
  ///
  /// When user stop typing for this time, the typing status will be removed
  static const int typingTimeOutInSeconds = 8;

  /// Typing debounce time, default is `5` seconds
  ///
  /// When user start typing, the typing status will be sent after this time.
  /// If user stop typing before this time, the typing status will not be sent
  /// and the previous typing status will be removed
  ///
  /// This is used to prevent sending too many typing status
  static const int typingDebounceTimeInSeconds = 5;

  static const int maxSelectedMessage = 50;
  static const int maxShareTargetNumber = 15;

  static const int pageSizeInSearchMessageRoomDetail = 50;

  ///NOTE. need 200(max room member) pageSize bacause need to sort owner and my account first
  ///NOTE. from BE data 200 is not a large data so can fetch in 1 times 200 member
  static const int pageSizeMembersInGroup = 20;
  static const int maxMembersInGroup = 200;
  static const int maxPageSizeMembersInGroup = 500;

  static const int pageSizeInRoomDetailLinks = 20;
  static const int pageSizeInGetSessionsList = 50;

  /// Default mention id for mention all
  /// [__0__](__All__)
  static const String mentionAllId = '0';

  /// Default mention id for less more
  /// [__1__](__LessMore__)
  static const String lessMoreId = '1';

  /// Default limit for number of media that can be selected from gallery
  ///
  /// Default is `50`
  static const int maxSelectableMediaFromGallery = 50;

  /// Default limit for width size of media that can selected from gallery
  static const int maxWidthMedia = 10000;

  /// Default limit for height size of media that can selected from gallery
  static const int maxHeightMedia = 10000;

  /// Default filter option for gallery image
  ///
  /// Default is `10000` for both width and height
  ///
  /// Default is `10` for both min width and min height
  static const galleryImageFilterOption = FilterOption(
    sizeConstraint: SizeConstraint(
      maxWidth: maxWidthMedia,
      maxHeight: maxHeightMedia,
      minWidth: 10,
      minHeight: 10,
    ),
  );

  /// Default filter option for gallery video
  ///
  /// Default is `10000` for both width and height
  ///
  /// Default is `10` for both min width and min height
  static const galleryVideoFilterOption = FilterOption(
    sizeConstraint: SizeConstraint(
      maxWidth: maxWidthMedia,
      maxHeight: maxHeightMedia,
      minWidth: 10,
      minHeight: 10,
    ),
  );

  static const emailUChat = 'support@uchat.social';
  static const refOnlineUsers = 'online_status';
  static const int maxRecentlySearchedStickers = 5;

  static double cameraPreviewPaddingFromTop = .15.sh;

  // Max message width factor from screen width
  static const double maxMessageWidthFactor = 0.72;

  // A WhatsApp user agent for getting a web link preview
  static const String whatsAppAndroidUserAgent = 'WhatsApp/2.21.12.21 A';

  // How many account can be added in accounts center.
  static const int loggedInAccountLimit = 4;

  static const double maxAppBarTitleWidth = 204;

  static const int maxSearchInputLength = 500;

  static const int maxLengthForSearchExecution = 100;

  static const int maxSearchResultShowed = 5;

  static const int maxRecentSearchResultShowed = 30;
}
