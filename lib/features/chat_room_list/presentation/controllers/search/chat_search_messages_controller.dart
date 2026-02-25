import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/params/get_all_message_till_target_message_param.dart';
import 'package:uchat/features/chat_room/domain/params/jump_to_message_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_message_till_target_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/jump_to_message_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/params/find_search_message_param.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/find_search_message_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/chat_search_messages_arguments.dart';

final _log = useLogger();

class ChatSearchMessagesController extends GetxController {
  ChatSearchMessagesController({
    required this.args,
  });

  final ChatSearchMessagesArguments args;

  final messageDb = GetIt.I<MessageDb>();

  final isLoadingMoreMessage = false.obs;

  final PagingController<int, MessageCollection> pagingController = PagingController(firstPageKey: 0);

  int pageSize = 20;

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<MessageCollection> localResult = [];
      try {
        // Attempt to get local messages first
        localResult = await messageDb.searchMessageInRoom(
          roomId: args.searchResult.room.id ?? '',
          keyword: args.keyword,
          page: pageKey + 1,
          pageSize: pageSize,
        );
        final localCount =
            await messageDb.countMessageInRoom(roomId: args.searchResult.room.id ?? '', keyword: args.keyword);
        // pagingController.appendLastPage(localResult);
        if (pagingController.itemList == null ||
            (pagingController.itemList!.length + localResult.length) < localCount) {
          pagingController.appendPage(localResult, pageKey + 1);
        } else {
          pagingController.appendLastPage(localResult);
        }
      } catch (e, stackTrace) {
        _log.e('Local search error', e, stackTrace);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void handleBack() {
    Get.back();
  }

  void handleJumpToMessage(MessageCollection message) async {
    final roomId = args.searchResult.room.id;
    if (roomId == null) {
      return;
    }

    isLoadingMoreMessage.value = true;

    final (isFound, foundMessage) = await GetIt.I<FindSearchMessageUseCase>().call(
      FindSearchMessageParam(message: message.toEntity(), roomId: roomId),
    );

    if (!isFound) {
      await GetIt.I<GetAllMessageTillTargetMessageUseCase>().call(
        GetAllMessageTillTargetMessageParam(
          roomId: roomId,
          message: message,
        ),
      );
    }

    await GetIt.I<JumpToMessageUseCase>().call(JumpToMessageParams(message: message.toEntity(), roomId: roomId));

    isLoadingMoreMessage.value = false;
  }
}
