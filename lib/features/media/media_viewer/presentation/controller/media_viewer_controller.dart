import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:open_file/open_file.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/share_message_selection_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/entities/share_album_image_entity.dart';
import 'package:uchat/features/album/domain/params/delete_images_in_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/delete_images_in_album_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_media_argument.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/features/image_edit/uchat_edit_image.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/confirm_bookmark_dialog.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/photo_previewer_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/image/uchat_network_image_provider.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../../../../../core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'video_previewer_controller.dart';

class MediaViewerController extends GetxController {
  final _log = useLogger();
  final httpCaller = HttpCaller();

  final roomMemberDb = RoomMemberDb();
  final roomDb = GetIt.I<RoomDb>();
  final messageDb = GetIt.I<MessageDb>();
  final roomFileDb = GetIt.I<RoomFileDb>();
  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;

  MediaViewerController({
    required this.initialMediaIndex,
    required this.initialMedia,
    required this.medias,
    required this.openFrom,
    this.isSecretRoom = false,
    this.isBookmark = false,
    this.onFetchMore,
  });

  int initialMediaIndex;

  // The initial media to show
  MediaFileModel initialMedia;

  // The list of media to show, use only on init, allMedias will be used after init
  List<MediaFileModel> medias;

  // The screen that open media viewer
  final MediaViewerOpenFrom openFrom;

  // Used to check if open in secret room
  final bool isSecretRoom;

  // Used to check if open in Bookmark room
  final bool isBookmark;

  // The list of media to show after init (use to load more media) and current media index
  final allMedias = <MediaFileModel>[].obs;
  final currentMediaIndex = 0.obs;

  // The current media file
  late Rx<MediaFileModel> currentMediaFile = Rx<MediaFileModel>(initialMedia);

  // The map of video previewer controller with index as key and controller as value
  RxMap<int, VideoPreviewerController> videoPreviewerCtlMap = <int, VideoPreviewerController>{}.obs;

  // The list of cached media index (use to preload media) and show media menu
  final List<int> cachedIndexes = <int>[];
  final showMediaMenu = true.obs;

  // The page controller and extended page controller for media viewer screen
  late ExtendedPageController extendedPageController;
  final GlobalKey<ExtendedImageSlidePageState> slidePageKey = GlobalKey<ExtendedImageSlidePageState>();

  // The final isHovering is used to check if user is hovering on media viewer screen
  final isHovering = false.obs;
  final isFullScreen = false.obs;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollGridController = ScrollController();
  final ListController listController = ListController();
  final Future<List<MediaFileModel>> Function()? onFetchMore;

  // progress for downloading media
  final downloadProgress = 0.0.obs;
  final isDownloading = false.obs;
  final totalLoadingSizeBytes = 0.obs;
  final currentLoadingSizeBytes = 0.obs;
  CancelToken? downloadCancelToken;

  String get downloadProgressFileSize {
    if (totalLoadingSizeBytes.value == 0) return '';
    final downloaded = FileService.instance.fileSizeStr(currentLoadingSizeBytes.value);
    final total = FileService.instance.fileSizeStr(totalLoadingSizeBytes.value);
    return '$downloaded / $total';
  }

  PhotoPreviewerController get currentPhotoPreviewerCtl {
    return Get.find<PhotoPreviewerController>(
      tag: currentMediaFile().controllerTag,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _log.d('Init media viewer controller, open from: $openFrom');
    // Set initial media index to true
    showMediaMenu(true);
    _loadWarModeConfig();
    if (openFrom == MediaViewerOpenFrom.roomMessage) {
      // Reverse medias if open from room message
      allMedias.addAll(medias.reversed.toList());
    } else {
      allMedias.addAll(medias);
    }

    final int index = allMedias.indexOf(initialMedia);
    currentMediaIndex(index);
    initMediaPreviewerController(index);

    // Preload media before and after initial media
    preloadMedia(index - 1);
    preloadMedia(index + 1);

    extendedPageController = ExtendedPageController(
      initialPage: allMedias.indexOf(
        initialMedia,
      ),
      shouldIgnorePointerWhenScrolling: true,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        int totalLength = allMedias.length;
        double amountImageCanShow = (Get.width - 200) / 104;

        if (totalLength > amountImageCanShow && !UChatScreenUtil.instance.isMobilePlatform) {
          double rangeFirstImage = totalLength - amountImageCanShow;
          double position = 104 * index.toDouble();

          if (index > rangeFirstImage) {
            //NOTE.If range around first image
            position = 104 * (totalLength - amountImageCanShow);
          }

          scrollGridController.jumpTo(position);
        }

        scrollToCurrentIndex();
      },
    );
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
  }

  @override
  void onClose() {
    // dispose all video previewer controller
    videoPreviewerCtlMap.forEach((key, value) {
      value.dispose();
    });
    extendedPageController.dispose();
    super.onClose();
  }

  ChatRoomController get chatRoomDirectCtl {
    return Get.find<ChatRoomController>(
      tag: currentMediaFile().roomId,
    );
  }

  UserController get userCtl {
    return Get.find<UserController>();
  }

  VideoPreviewerController? get currentVideoPreviewerCtl {
    return videoPreviewerCtlMap[currentMediaIndex.value];
  }

  /// Check if media viewer should reverse
  bool get shouldReverse {
    return openFrom == MediaViewerOpenFrom.roomMessage;
  }

  void handleCopyImageClipboard() async {
    if (currentMediaFile().isImage) {
      final imageData = await UChatNetworkImageProvider(
        currentMediaFile().url,
        headers: HttpCaller().apiHeader,
        cache: true,
        retries: 2,
      ).getNetworkImageData();
      final clipboard = SystemClipboard.instance;
      if (clipboard != null) {
        final image = imageData;
        final item = DataWriterItem(suggestedName: currentMediaFile().fileName);
        item.add(Formats.png(image!));
        await clipboard.write([item]);
      } else {
        // showMessage(_notAvailableMessage);
      }
    }
  }

  void initMediaPreviewerController(int index) {
    if (index < 0 || index >= allMedias.length) {
      return;
    }

    final media = allMedias[index];

    if (media.fileType == MessageFileType.image || media.fileType == MessageFileType.gif) {
      initPhotoPreviewerController(index);
    }

    if (media.fileType == MessageFileType.video) {
      initVideoPreviewerController(index);
    }
  }

  void initPhotoPreviewerController(int index) {
    if (UChatScreenUtil.instance.isMobilePlatform) {
      return;
    }

    if (index < 0 || index >= allMedias.length) {
      return;
    }

    final media = allMedias[index];

    if (media.fileType == MessageFileType.image || media.fileType == MessageFileType.gif) {
      if (!Get.isRegistered<PhotoPreviewerController>(
        tag: media.controllerTag,
      )) {
        Get.put<PhotoPreviewerController>(
          PhotoPreviewerController(),
          tag: media.controllerTag,
        );

        _log.d('Init photo previewer controller: $index');
      }
    }
  }

  /// Initialize video previewer controller if not exist and pause the video if exist
  /// - [index] the index of the media
  void initVideoPreviewerController(int index) {
    // Check if index is valid
    if (index < 0 || index >= allMedias.length) {
      return;
    }

    final media = allMedias[index];

    if (media.fileType == MessageFileType.video) {
      if (!Get.isRegistered<VideoPreviewerController>(
        tag: media.heroTag!,
      )) {
        final controller = Get.put<VideoPreviewerController>(
          VideoPreviewerController(
            tag: media.heroTag!,
            media: media,
          ),
          tag: media.heroTag,
        );

        // Add video previewer controller to map
        videoPreviewerCtlMap[index] = controller;
        videoPreviewerCtlMap.refresh();
        _log.d('Init video previewer controller: $index');
      } else {
        _log.d('Video previewer controller already exist: $index');
        videoPreviewerCtlMap[index]?.playerController?.pause();
      }
    }
  }

  /// Preload media to cache if not exist
  /// - [index] the index of the media
  void preloadMedia(int index) {
    try {
      final cached = cachedIndexes.contains(index);

      if (0 <= index && index < allMedias.length) {
        final media = allMedias.elementAtOrNull(index);
        if (media == null) {
          return;
        }
        initMediaPreviewerController(index);

        if (media.fileType == MessageFileType.video) {
          // Preload video thumbnail if not cached
          if (!cached) {
            final thumbnailPath = media.thumbnailPath;
            if (thumbnailPath != null) {
              final isNetworkPath = thumbnailPath.startsWith('https:');
              if (isNetworkPath) {
                precacheImage(
                  ExtendedNetworkImageProvider(
                    thumbnailPath,
                    cache: true,
                    headers: httpCaller.apiHeader,
                  ),
                  Get.context!,
                  onError: (exception, stackTrace) => _log.w(
                    'Error on precache video thumbnail',
                    exception,
                    stackTrace,
                  ),
                );
              } else {
                if (File(thumbnailPath).existsSync()) {
                  precacheImage(
                    ExtendedFileImageProvider(File(thumbnailPath)),
                    Get.context!,
                    onError: (exception, stackTrace) => _log.w(
                      'Error on precache video thumbnail',
                      exception,
                      stackTrace,
                    ),
                  );
                }
              }
            } else {
              _log.w('Video thumbnail path is null for media fileId: ${media.fileId}');
            }
          }
        } else {
          // Preload image if not cached
          if (!cached) {
            final thumbnailPath = media.thumbnailPath;
            if (thumbnailPath != null) {
              final isNetworkPath = thumbnailPath.startsWith('https:');
              if (isNetworkPath) {
                precacheImage(
                  ExtendedNetworkImageProvider(
                    thumbnailPath,
                    cache: true,
                    headers: httpCaller.apiHeader,
                  ),
                  Get.context!,
                  onError: (exception, stackTrace) => _log.w(
                    'Error on precache image',
                    exception,
                    stackTrace,
                  ),
                );
              } else {
                if (File(thumbnailPath).existsSync()) {
                  precacheImage(
                    ExtendedFileImageProvider(File(thumbnailPath)),
                    Get.context!,
                    onError: (exception, stackTrace) => _log.w(
                      'Error on precache image',
                      exception,
                      stackTrace,
                    ),
                  );
                }
              }
            } else {
              _log.w('Image thumbnail path is null for media fileId: ${media.fileId}');
            }
          }
        }

        cachedIndexes.add(index);
      }
    } catch (error, stackTrace) {
      _log.w('Error on preload media:', error, stackTrace);
    }
  }

  /// Show or hide media menu
  void onPressedMediaScreen() {
    showMediaMenu(!showMediaMenu.value);
  }

  void onHoveringMediaScreen(bool hovering) {
    isHovering(hovering);
  }

  /// Close media viewer screen
  void onClosePage() {
    showMediaMenu(false);
    slidePageKey.currentState!.popPage();

    Get.back();
  }

  /// Set the background color of the page
  /// - [offset] the offset of the page
  /// - [pageSize] the size of the page
  /// - return the color of the page
  Color slidePageBackgroundHandler(Offset offset, Size pageSize) {
    double opacity = offset.dy.abs() / (pageSize.height / 2.0);
    return Colors.black.withValues(alpha: min(1.0, max(1.0 - opacity, 0.0)));
  }

  /// On sliding page
  /// - [state] the state of sliding page
  void onSlidingPage(ExtendedImageSlidePageState state) {
    // Hide media menu if user is sliding and offset is more than 20 (sliding down) or less than -20 (sliding up)
    if (state.isSliding == true && (state.offset.dy > 10 || state.offset.dy < -10) && showMediaMenu.value == true) {
      showMediaMenu(false);
      isHovering(false);
    }

    // Show media menu if user is not sliding and media menu is hidden
    if (state.isSliding == false) {
      isHovering(true);
      if (showMediaMenu.value == false) {
        showMediaMenu(true);
      }
    }
  }

  void onChangeMediaPage(bool moveForward) {
    Future.delayed(const Duration(milliseconds: 300), () {
      currentPhotoPreviewerCtl.onReset();
    });

    if (openFrom == MediaViewerOpenFrom.roomMessage) {
      // Reverse media if open from room message
      // So, if move forward, it should go to previous page
      // And if move backward, it should go to next page
      if (moveForward) {
        extendedPageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        extendedPageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // If open from other screen, it should go to next page if move forward
      // And go to previous page if move backward
      if (moveForward) {
        extendedPageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        extendedPageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  /// On page change
  /// set current media index and current media file
  /// preload media before and after current media
  /// - [page] the index of the page
  void onPageChange(int page) {
    currentMediaIndex(page);
    currentMediaFile(allMedias[page]);

    if (allMedias[page].fileType == MessageFileType.video) {
      final videoPreviewerCtl = videoPreviewerCtlMap[page];
      if (videoPreviewerCtl != null &&
          videoPreviewerCtl.playerController != null &&
          videoPreviewerCtl.playerController!.value.isInitialized) {
        videoPreviewerCtl.playerController?.play();
      }
    }

    preloadMedia(page - 1);
    preloadMedia(page + 1);

    onAddMoreMediaToState();

    if (UChatScreenUtil.instance.isMobilePlatform) {
      scrollToCurrentIndex();
    }
  }

  void onTapMediaItem(int index) {
    preloadMedia(index);
    preloadMedia(index - 1);
    preloadMedia(index + 1);

    extendedPageController.jumpToPage(index);
  }

  void scrollToCurrentIndex() {
    int totalLength = allMedias.length;

    double amountImageCanShow = (Get.width - 200) / 104;

    //NOTE.if have few image not move
    if (totalLength <= amountImageCanShow) {
      return;
    } else {
      //NOTE.If around last image will go to position 0 to not move
      if (currentMediaIndex.value < amountImageCanShow) {
        // TODO: Is this variable still used?
        // double position = 0;

        // scrollController.animateTo(
        //   position,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        listController.animateToItem(
            index: currentMediaIndex.value,
            scrollController: scrollGridController,
            alignment: 1,
            duration: (_) => const Duration(milliseconds: 300),
            curve: (_) => Curves.easeInOut);
      } else if (currentMediaIndex.value > totalLength - amountImageCanShow) {
        //NOTE.If around first image will go to position that can see first image and not move

        // TODO: Is this variable still used?
        // double position = 104 * ((totalLength - amountImageCanShow).toDouble());

        // scrollController.animateTo(
        //   position,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        listController.animateToItem(
            index: currentMediaIndex.value,
            scrollController: scrollGridController,
            alignment: 1,
            duration: (_) => const Duration(milliseconds: 300),
            curve: (_) => Curves.easeInOut);
      } else {
        //NOTE.move to that position
        // TODO: Is this variable still used?
        // double position = 104 * (currentMediaIndex.value.toDouble());

        // scrollController.animateTo(
        //   position,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        listController.animateToItem(
            index: currentMediaIndex.value,
            scrollController: scrollGridController,
            alignment: 1,
            duration: (_) => const Duration(milliseconds: 300),
            curve: (_) => Curves.easeInOut);
      }
    }
  }

  /// On add more media to state (load more media)
  /// - [openFrom] the screen that open media viewer
  /// - [allMedias] the list of all media
  /// - [currentMediaIndex] the index of current media
  Future<void> onAddMoreMediaToState() async {
    // Don't fetch more item if open from profile avatar, album detail
    // because it will fetch all media
    if ([
      MediaViewerOpenFrom.profileAvatar,
    ].contains(openFrom)) {
      return;
    }

    // fetch more item if index is almost reach to 80% of total items
    final shouldFetchMore = (currentMediaIndex() / allMedias.length) >= 0.8;
    List<MediaFileModel> newMediaFiles = [];

    // fetch more item if open from room message
    if (openFrom == MediaViewerOpenFrom.roomMessage && shouldFetchMore) {
      newMediaFiles = await loadMoreOnChatRoomDirectScreen();
    }

    if (openFrom == MediaViewerOpenFrom.albumDetail && shouldFetchMore) {
      newMediaFiles = await loadMoreOnAlbumScreen();
    }

    // add new media to all media list
    if (newMediaFiles.isNotEmpty) {
      for (final file in newMediaFiles) {
        // check if media is already exist in all media list
        if (allMedias.any((element) => element == file)) {
          continue;
        }
        allMedias.add(file);
      }
      allMedias.refresh();
    }
  }

  /// Load more media on album image list screen
  /// - return the list of media
  /// - return empty list if error
  Future<List<MediaFileModel>> loadMoreOnAlbumScreen() async {
    if (onFetchMore != null) {
      return await onFetchMore!();
    } else {
      return [];
    }
  }

  /// Load more media on room message screen
  /// - return the list of media
  /// - return empty list if error
  Future<List<MediaFileModel>> loadMoreOnChatRoomDirectScreen() async {
    // TODO: fix load more on room message when there are many other messages (not media) more than 100
    try {
      _log.d('loadMoreOnChatRoomDirectScreen');

      // load more item from room messages controller
      final newMediaMessageCollections = await loadMoreMessage();

      final newMediaFiles = <MediaFileModel>[];
      // convert message collection to media file
      for (final messageCollection in newMediaMessageCollections) {
        final messageSeq = messageCollection.sequence;
        if (messageSeq == null) {
          continue;
        }

        final messageFiles = messageCollection.files
            ?.map(
              (e) => MediaFileModel.fromMessageFileModel(
                e,
                messageSeq: messageSeq,
              ),
            )
            .toList();
        if (messageFiles != null && messageFiles.isNotEmpty) {
          for (final newMsg in messageFiles) {
            if (allMedias.any((element) => element == newMsg)) {
              continue;
            } else {
              newMediaFiles.add(newMsg);
            }
          }
        }
      }

      //   if (newMediaFiles.isEmpty) {
      //     await loadMoreOnChatRoomDirectScreen();
      //   }

      return newMediaFiles;
    } catch (e, stackTrace) {
      _log.e('loadMoreOnChatRoomDirectScreen error', e, stackTrace);
      return [];
    }
  }

  /// Load more message from room message controller
  /// - [time] the time to load more message if the first load is not enough
  /// - return the list of message collection
  /// - return empty list if error
  Future<List<MessageCollection>> loadMoreMessage({
    int time = 1,
  }) async {
    // amount of message to load more (100 * time)
    int loadMoreAmount = 100 * time;

    // get last message sequence from room message controller
    final lastMessageSeq = chatRoomDirectCtl.messageListCtl.messages.last.sequence ?? 0;
    // get last message sequence from last media file in all media list
    final leftFileSeq = allMedias.last.messageSeq;
    // get the lowest sequence between last message sequence and last media file sequence
    final sequenceLessThan = lastMessageSeq < leftFileSeq! ? lastMessageSeq : leftFileSeq;

    // get message collection from room message controller
    await chatRoomDirectCtl.messageListCtl.getMoreMessageToState();
    // get message collection from message db with sequence less than sequenceLessThan
    final newMessageFile = await GetIt.I<MessageDb>().getAllSentMessageMediaFiles(
      roomId: chatRoomDirectCtl.roomId,
      sequenceLessThan: sequenceLessThan,
    );

    final sequenceNotLessThanLoadMoreMessageAmount = lastMessageSeq - loadMoreAmount > 0;

    if (newMessageFile.isEmpty && sequenceNotLessThanLoadMoreMessageAmount) {
      return await loadMoreMessage(time: time + 1);
    } else {
      return newMessageFile;
    }
  }

  Future<void> onPressedGrid() async {
    try {
      if (openFrom == MediaViewerOpenFrom.roomDetailPhotoAndVideo) {
        // if open from room detail photo and video, it should do nothing.
        // just close the page
        onClosePage();
        return;
      } else if (openFrom == MediaViewerOpenFrom.albumDetail ||
          openFrom == MediaViewerOpenFrom.profileAvatar ||
          openFrom == MediaViewerOpenFrom.roomDetail) {
        // if open from those screen, it should do nothing.
        // because there is no grid view in those screen
        return;
      } else {
        if (Get.context == null && currentMediaFile().roomId == null) {
          return;
        }

        onClosePage();

        Get.toNamed(
          Routes.roomDetailMedia.replaceAll(':id', currentMediaFile().roomId!),
          arguments: ChatRoomDetailMediaArgument(
            roomId: currentMediaFile().roomId!,
          ),
        );
      }
    } catch (e, stackTrace) {
      _log.e('Error on onPressedGrid:', e, stackTrace);
    }
  }

  void _resetDownloadProgress() {
    isDownloading(false);
    downloadProgress(0.0);
    currentLoadingSizeBytes(0);
    totalLoadingSizeBytes(0);
  }

  void _startDownloadProgress() {
    downloadCancelToken = CancelToken();
    isDownloading(true);
    downloadProgress(0.0);
    currentLoadingSizeBytes(0);
    totalLoadingSizeBytes(0);
  }

  void _setDownloadProgress(int received, int total) {
    if (!isDownloading.value) {
      isDownloading(true);
    }

    final progress = total != 0 ? received / total : 0.0;
    downloadProgress(progress);
    currentLoadingSizeBytes(received);
    totalLoadingSizeBytes(total);
  }

  void onCancelDownload() {
    downloadCancelToken?.cancel();
    _resetDownloadProgress();
  }

  Future<void> handleDownloadAndSaveMedia(MediaFileModel mediaFile) async {
    _startDownloadProgress();
    if (currentVideoPreviewerCtl?.isError.value == true) {
      if (currentMediaFile.value.fileId == null || currentMediaFile.value.roomId == null) {
        return;
      }

      try {
        final savedFile = await FileService.instance.downloadMessageFile(
          currentMediaFile.value.fileId!,
          roomId: currentMediaFile.value.roomId!,
          fileName: currentMediaFile.value.fileName,
          cancelToken: downloadCancelToken,
          onReceiveProgress: (recv, total) {
            if (total != 0) {
              _setDownloadProgress(recv, total);
            }
          },
        );
        OpenFile.open(savedFile.path);
        AppToast.hideToast(Get.context!);
        AppToast.showDownloadToast(context: Get.context!, title: 'Downloaded'.tr);
      } catch (e, stackTrace) {
        _log.e('Error on download and save media:', e, stackTrace);
        // await UChatLoading.hide();
        handleException(e);
        AppToast.hideToast(Get.context!);
      } finally {
        _resetDownloadProgress();
      }
    } else {
      // print('eeeeeeeee');
      // AppToast.showDownloadToast(context: context, title: 'Downloaded'.tr);
      await FileService.instance.download([mediaFile],
          cancelToken: downloadCancelToken,
          showWaitingLoading: false,
          showSuccessDialogDuration: const Duration(seconds: 3),
          successMessage: 'Downloaded'.tr, onProgress: (recv, total) {
        if (total != 0) {
          _setDownloadProgress(recv, total);
        }
      });
      _resetDownloadProgress();
    }
  }

  Future<void> handleShareMediaFile(MediaFileModel mediaFile) async {
    ShareBottomSheetDataEntity shareData;
    if (openFrom == MediaViewerOpenFrom.albumDetail) {
      final albumId = mediaFile.albumId;
      if (albumId == null) return;
      shareData = ShareBottomSheetDataEntity(
        albumImageList: ShareAlbumImageEntity(albumId: albumId, images: [
          AlbumImageEntity(
            imageId: mediaFile.fileId,
          ),
        ]),
      );
    } else {
      MessageType messageType = MessageType.image;
      if (mediaFile.fileType == MessageFileType.video) {
        messageType = MessageType.video;
      }
      final fileId = mediaFile.fileId;
      if (fileId == null) return;
      shareData = ShareBottomSheetDataEntity(
        messageList: [
          ShareMessageSelectionEntity(
            message: MessageCollection(
              type: messageType,
              id: mediaFile.messageId,
              roomId: mediaFile.roomId,
            ),
            fileIdList: [fileId],
          )
        ],
      );
    }

    GetIt.I<SharingService>().share(data: shareData);
  }

  /// Currently this function is used when media viewer is open from album image only.
  void handleDeleteFromAlbum(MediaFileModel media, BuildContext context) async {
    await UChatNewDialog.showDialog(
      context: context,
      title: 'Delete items'.tr,
      description: 'Do you want to delete this image?'.tr,
      confirmText: 'Delete'.tr,
      confirmTextColor: context.theme.appColors.textError,
      cancelText: 'Cancel'.tr,
      cancelTextColor: context.theme.appColors.textLight,
      onConfirm: () async {
        try {
          await GetIt.I<DeleteImagesInAlbumUseCase>().call(
            DeleteImagesInAlbumParam(
              albumId: media.albumId!,
              roomId: media.roomId!,
              imageIds: [media.fileId!],
            ),
          );

          allMedias.remove(media);

          /// If album is empty after deleting, Close media viewer.
          if (allMedias.isEmpty) {
            Get.back();
            return;
          }

          /// Update current media index when deleting last media.
          if (currentMediaIndex.value >= allMedias.length) {
            currentMediaIndex.value = allMedias.length - 1;
          }

          /// Update current media file.
          currentMediaFile.value = allMedias[currentMediaIndex.value];
        } catch (e, stackTrace) {
          _log.e('deleteImagesInAlbum error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
        }
      },
    );
  }

  void handlePlayPauseVideo() {
    eventBus.fire(VideoPlayPauseEvent(currentMediaFile.value.heroTag ?? ''));
  }

  Future<void> jumpToMediaMessageInRoomMessage() async {
    if (openFrom == MediaViewerOpenFrom.roomMessage) {
      // TODO: handle jump to that message
      onClosePage();
    } else {
      final roomId = currentMediaFile().roomId;
      final messageId = currentMediaFile().messageId;

      if (roomId == null) {
        UChatDialog.showAlertDialog(
          title: 'C',
          description: 'Room ID is null',
        );
        return;
      }

      RoomCollection? room;
      room = await roomDb.getRoom(roomId);

      if (room == null) {
        return;
      }

      MessageCollection? message;
      if (messageId != null) {
        message = await messageDb.getMessageById(id: messageId);
      }

      onClosePage();
      HomeController.instance.onNavigationTapped(1);
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.id!),
        arguments: ChatRoomArguments(room: room, targetMessage: message, fromPage: 'media'),
      );
    }
  }

  Future<void> handleDeleteMedia() async {
    try {
      final media = currentMediaFile();
      final roomId = media.roomId;
      final messageId = media.messageId;

      if (roomId == null || messageId == null) {
        return;
      }

      final roomFileCollection = await roomFileDb.getRoomFileCollectionOne(roomId, messageId);

      if (roomFileCollection == null) {
        return;
      }

      final result = await UChatDialog.showConfirmDialog(
        title: 'Delete photos & videos'.tr,
        description: 'Do you want to delete all\nselected photos & videos?'.tr,
        confirmText: 'Delete'.tr,
      );

      if (result != true) {
        return;
      }

      final file = roomFileCollection.file;
      if (file == null) {
        return;
      }

      UChatLoading.show(status: 'Deleting...'.tr);
      // ! New request changed, old service incompatible with new api.
      // final req = UnsentMessageRequest(
      //   messageId: roomFileCollection.messageId!,
      //   roomId: roomFileCollection.roomId!,
      //   groupFileIds: [file.id!],
      // );
      // await messageService.removeMessage(req);

      allMedias.removeAt(currentMediaIndex.value);
      if (allMedias.isEmpty) {
        onClosePage();
      }

      UChatLoading.success(duration: 3.seconds);
    } catch (e, stackTrace) {
      _log.e('Error on handleDeleteMedia:', e, stackTrace);
      UChatLoading.hide();
    }
  }

  Future<MessageCollection?> getMessageFromMediaFile(MediaFileModel mediaFile) async {
    return GetIt.I<MessageDb>().getMessageById(
      id: mediaFile.messageId ?? '',
    );
  }

  Future<void> handleOpenChat(MessageCollection message) async {
    final jumpMessage = await GetIt.I<MessageDb>().getMessageById(
      id: message.originalMessageId ?? '',
    );
    RoomCollection? room = await GetIt.I<RoomDb>().getRoom(
      message.originalRoomId ?? '',
    );
    if (room != null) {
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.id!),
        arguments: ChatRoomArguments(
          room: room,
          targetMessage: jumpMessage,
          fromPage: 'media',
        ),
      );
    }
  }

  void bookmark() async {
    bool canBookmark = false;
    final message = await getMessageFromMediaFile(currentMediaFile());
    if (message == null) {
      return;
    }
    if (message.bookmarkMessageId == null) {
      canBookmark = true;
    } else {
      final bookMarkMsgs = await messageDb.getMessageById(id: message.bookmarkMessageId!);
      final result = bookMarkMsgs?.files?.firstWhereOrNull((element) => element.id == currentMediaFile().fileId);
      if (result == null) {
        canBookmark = true;
      }
    }
    if (canBookmark) {
      try {
        await UChatLoading.show(status: 'Saving...'.tr);
        final req = SaveBookmarkRequest(
          dataList: [
            BookmarkRequestDataModel(
              msgId: message.id!,
              fileIds: [currentMediaFile().fileId!],
            )
          ],
          roomId: currentMediaFile().roomId,
        );
        await MessageService().saveToBookmark(req);
        await UChatLoading.hide();
        if (UChatScreenUtil.instance.isMobilePlatform) {
          showUpdateBookmarkSnackbar(
            title: 'Save as Bookmark'.tr,
            onPressed: handleOpenBookmark,
          );
        } else {
          showUpdateBookmarkSnackbar(
            title: 'Save as Bookmark'.tr,
            onPressed: handleOpenBookmark,
            snackPosition: SnackPosition.TOP,
            maxWidth: Get.width / 2,
          );
        }
      } catch (e, stackTrace) {
        _log.e('handleUpdateBookmark error.', e, stackTrace);
        await UChatLoading.hide();
      }
    } else {
      final confirm = await ConfirmUnBookmarkDialog.show();
      if (confirm) {
        try {
          await UChatLoading.show(status: 'Loading...'.tr);
          final req = RemoveBookmarkRequest(
            dataList: [
              BookmarkRequestDataModel(
                msgId: message.bookmarkMessageId!,
                fileIds: [currentMediaFile().fileId!],
              )
            ],
          );
          await MessageService().removeFromBookmark(req);
          await UChatLoading.hide();
          if (UChatScreenUtil.instance.isMobilePlatform) {
            showUpdateBookmarkSnackbar(
              title: 'Delete from Bookmark'.tr,
              onPressed: handleOpenBookmark,
            );
          } else {
            showUpdateBookmarkSnackbar(
              title: 'Delete from Bookmark'.tr,
              onPressed: handleOpenBookmark,
              snackPosition: SnackPosition.TOP,
              maxWidth: Get.width / 2,
            );
          }
        } catch (e, stackTrace) {
          _log.e('handleUnBookmark error.', e, stackTrace);
          await UChatLoading.hide();
        }
      }
    }
  }

  void handleOpenBookmark() async {
    RoomCollection? room = await roomDb.getBookmarkRoom();

    if (room != null) {
      Get.back(closeOverlays: true);
      Get.offAndToNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.id!),
        arguments: ChatRoomArguments(room: room, fromPage: 'media'),
      );
    }
  }

  void handleEditImage(BuildContext context, MediaFileModel media) async {
    final data = await getNetworkImageData(media.url, useCache: true);
    final UChatEditImage imageEdit = UChatEditImage(
      editorFactory: (file, configs, callbacks) => ProImageEditor.memory(
        file,
        configs: configs,
        callbacks: callbacks,
      ),
      doneIcon: buildDefaultDoneButton(context.theme.appColors.backgroundPrimary),
    );
    await imageEdit.handleEditImage(
      file: data,
      context: context,
      onEditComplete: (image) async {
        Get.back();
        chatRoomDirectCtl.onEditImageComplete(image);
      },
    );
  }

  Widget buildDefaultDoneButton(Color backgroundColor) {
    return Container(
      width: 55.spMin,
      height: 35.spMin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space3,
          vertical: AppSpace.space1,
        ),
        child: Assets.vectors.send.svg(),
      ),
    );
  }
}
