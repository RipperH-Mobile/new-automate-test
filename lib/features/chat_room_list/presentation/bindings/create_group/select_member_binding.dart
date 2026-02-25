import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';

import '../../controllers/create_group/select_member_controller.dart';

class SelectMemberBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as SelectMemberArguments?;
    Get.put<SelectMemberController>(
      SelectMemberController(
        arguments: args,
      ),
    );
  }
}
