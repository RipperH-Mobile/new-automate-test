import 'package:uchat/features/chat_room_detail/data/models/requests/get_next_owner_suggestion_list_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/next_owner_suggestion_model.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetNextOwnerSuggestionListUseCase
    extends SimpleUseCase<NextOwnerSuggestionModel, GetNextOwnerSuggestionListRequest> {
  final ChatRoomDetailLocalRepository chatRoomDetailLocalRepository;

  GetNextOwnerSuggestionListUseCase({
    required this.chatRoomDetailLocalRepository,
  });

  @override
  Future<NextOwnerSuggestionModel> call(GetNextOwnerSuggestionListRequest params) async {
    final suggestionMembers = await chatRoomDetailLocalRepository.getNextOwnerSuggestionList(params);
    final countMembers = await chatRoomDetailLocalRepository.getNextOwnerSuggestionListCount(params);

    return NextOwnerSuggestionModel(countMembers: countMembers, suggestionMembers: suggestionMembers);
  }
}
