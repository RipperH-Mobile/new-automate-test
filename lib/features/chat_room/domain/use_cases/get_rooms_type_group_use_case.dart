import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomsTypeGroupUseCase extends SimpleUseCase<List<RoomCollection>?, NoParams> {
  @override
  Future<List<RoomCollection>?> call(NoParams params) async {
    return await GetIt.I<RoomDb>().getRoomTypeGroup();
  }
}
