import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateNicknameUseCase extends SimpleUseCase<void, UpdateNicknameRequest> {
  ContactServerRepository get contactServerRepository {
    return GetIt.I<ContactServerRepository>();
  }

  @override
  Future<void> call(UpdateNicknameRequest params) async {
    return await contactServerRepository.updateNickname(params);
  }
}
