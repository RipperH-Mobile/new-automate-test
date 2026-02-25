import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemoveFriendUseCase extends SimpleUseCase<bool, RemoveFriendRequest> {
  final ContactServerRepository contactServerRepository;

  RemoveFriendUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<bool> call(RemoveFriendRequest params) async {
    return await contactServerRepository.removeFriend(params);
  }
}
