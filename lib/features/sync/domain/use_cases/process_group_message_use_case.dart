import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/update_state_type.dart';
import '../typedefs.dart';
import 'sync_handle_update_message_use_case.dart';

const filesType = [MessageType.image, MessageType.video, MessageType.file];

///
/// For processing sync state of group messages.
/// - Required [SyncHandleUpdateMessageUseCase] to handle message updates.
///
class ProcessGroupMessageUseCase extends SimpleUseCase<EventListCallback, UpdateStateModel> {
  SyncHandleUpdateMessageUseCase get syncHandleUpdateMessageUseCase {
    return GetIt.I<SyncHandleUpdateMessageUseCase>();
  }

  @override
  Future<EventListCallback> call(UpdateStateModel state) async {
    final EventListCallback eventList = [];

    switch (state.type) {
      case UpdateStateType.newMessage:
      case UpdateStateType.updateMessage:
        if (state.message case final message?) {
          final eventCb = await syncHandleUpdateMessageUseCase.call(SyncHandleUpdateMessageParams(
            receiveMessage: message,
          ));
          eventList.addAll(eventCb);
        }
        break;
      default:
        useLogger().w('Skipping state type ${state.type} from ProcessGroupMessageUseCase');
        break;
    }

    return eventList;
  }
}
