import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/chat_search_messages_arguments.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/search_all_message_result_argument.dart';
import 'package:uchat/routes/app_pages.dart';

class SearchAllMessageResultController extends GetxController {
  final keyword = ''.obs;
  final title = 'Search'.obs;
  final allMessageCount = 0.obs;
  final messagePreviewList = <SearchMessagesResultModel>[].obs;

  ChatListSearchUseCase useCase = GetIt.I<ChatListSearchUseCase>();

  @override
  void onInit() async {
    final arg = Get.arguments as SearchAllMessageResultArgument;
    keyword.value = arg.keyword;
    title.value = 'Search "@keyword"'.trParams({'keyword': keyword.value});
    allMessageCount.value = arg.allMessageCount;
    messagePreviewList.addAll(arg.messagePreviewList);

    super.onInit();
  }

  void handleSelectMessage(SearchMessagesResultModel data) {
    Get.toNamed(
      Routes.universalSearchRoomMessages,
      arguments: ChatSearchMessagesArguments(
        keyword: keyword.value,
        searchResult: data,
      ),
    );
  }
}
