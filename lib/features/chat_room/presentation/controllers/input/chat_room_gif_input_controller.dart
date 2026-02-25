import 'dart:convert';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/giphy/client.dart';
import 'package:uchat/api/giphy/models/collection.dart';
import 'package:uchat/api/giphy/models/gif.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sample_gif_config_dialog.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();
const searchGifDebounceTag = 'searchGIF';
const giphyTrendingKey = 'giphyTrending';

class ChatRoomGifInputController extends GetxController {
  final String tag;

  ChatRoomGifInputController({required this.tag});

  final TextEditingController searchInputController = TextEditingController();
  // TODO: refactor this code to match (GiphyRepository)
  final GiphyClient client = GiphyClient(apiKey: AppEnv.giphyApiKey);
  final FocusNode focusNode = FocusNode();

  final gifList = <GiphyGif>[].obs;
  final isSearching = false.obs;
  final searchingText = ''.obs;
  final lastSearchKeyword = ''.obs;

  final configGeneral = ConfigDb().general;

  @override
  void onInit() {
    searchInputController.addListener(handleSearch);
    initGifData();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        chatRoomInputCtl.swipeKeyboardHeight.value = chatRoomInputCtl.customInputHeightExpanded;
      } else {
        chatRoomInputCtl.swipeKeyboardHeight.value = 0;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    searchInputController.dispose();
    super.onClose();
  }

  void initGifData() async {
    try {
      final collection = await client.trending();
      final giphyGifs = collection.data;

      await configGeneral.saveConfig(
        key: giphyTrendingKey,
        value: json.encode(collection.data),
      );

      gifList(giphyGifs);
    } catch (e, stackTrace) {
      final cachedGifs = await _loadCachedGifs();
      gifList(cachedGifs);
      _log.w('Failed to load trending GIFs, using cached data', e, stackTrace);
    }
  }

  Future<List<GiphyGif>> _loadCachedGifs() async {
    final cachedDataString = await configGeneral.getString(key: giphyTrendingKey);

    if (cachedDataString == null) {
      return [];
    }

    try {
      final decodedData = json.decode(cachedDataString) as List;
      return decodedData.map((item) => GiphyGif.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      _log.w('Failed to parse cached GIF data', e, stackTrace);
      return [];
    }
  }

  void handleSearch() {
    searchingText(searchInputController.text);
    EasyDebounce.debounce(
      searchGifDebounceTag,
      const Duration(milliseconds: 800),
      () => searchGif(),
    );
  }

  void searchGif() async {
    if (searchingText().isEmpty) return;
    if (isSearching()) return;
    if (searchingText() == lastSearchKeyword()) return;

    isSearching(true);

    try {
      GiphyCollection collection = await client.search(searchingText());
      gifList(collection.data ?? <GiphyGif>[]);
    } catch (e, stackTrace) {
      _log.w('Call searchGif error.', e, stackTrace);
    }

    isSearching(false);
    lastSearchKeyword(searchingText());
  }

  Future<void> handleCancelSearchGif() async {
    chatRoomInputCtl.onCustomInputTrigger();
    focusNode.unfocus();
  }

  Future<void> selectGif(
    GiphyGif giphyGif,
    Function(GifSendingEntity) onSendGif,
  ) async {
    try {
      await handleCancelSearchGif();

      chatRoomInputCtl.sendGif(
        GifSendingEntity.fromGiphyGif(giphyGif),
        onSendGif,
      );
    } catch (e, stackTrace) {
      // Todo: Handle when cannot send gif.
      _log.e('Cannot send gif', e, stackTrace);
    }
  }

  ChatRoomInputController get chatRoomInputCtl {
    return Get.find<ChatRoomInputController>(tag: tag);
  }

  void onSendSampleGif({
    required GiphyGif gif,
    required Function(GifSendingEntity, {int loopCount}) onSendGif,
  }) async {
    await Get.dialog(
      DebugSendSampleGifConfigDialog(
        gif: GifSendingEntity.fromGiphyGif(gif),
        onSendGif: onSendGif,
        onCancel: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );

    Get.back();
  }
}
