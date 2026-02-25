import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/room_detail_edit_controller.dart';

class ChatRoomDetailGroupEditNameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RoomDetailEditController>(RoomDetailEditController(
      changeGroupAccessTypeUseCase: GetIt.I<ChangeGroupAccessTypeUseCase>(),
      changeRoomNameUseCase: GetIt.I<ChangeRoomNameUseCase>(),
      changeRoomPhotoUseCase: GetIt.I<ChangeRoomPhotoUseCase>(),
      setDefaultGroupAvatarUseCase: GetIt.I<SetDefaultGroupAvatarUseCase>(),
    ));
  }
}
