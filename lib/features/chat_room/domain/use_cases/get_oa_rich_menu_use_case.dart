import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/domain/params/oa_rich_menu_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOaRichMenuUseCase extends SimpleUseCase<RichMenuModel?, OaRichMenuParams> {
  final ChatRoomServerRepository serverRepository;
  final ContactLocalRepository contactLocalRepository;

  GetOaRichMenuUseCase({required this.serverRepository, required this.contactLocalRepository});

  @override
  Future<RichMenuModel?> call(OaRichMenuParams params) async {
    try {
      final richMenu = await serverRepository.getOaRichMenu(params.officialAccountId);
      contactLocalRepository.putContactRichMenu(params.officialAccountId, richMenu);
      return richMenu;
    } catch (e) {
      final localRichMenu = await contactLocalRepository.getContact(params.officialAccountId);
      return localRichMenu?.richMenu;
    }
  }
}
