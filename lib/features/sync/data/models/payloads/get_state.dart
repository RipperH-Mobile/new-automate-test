import '../entities/update_state_model.dart';
import '../enum/state_group.dart';

class GetStateRequest {
  int? startSeq;
  int? endSeq;
  StateGroup? group;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};

    if (startSeq != null) {
      json['startSeq'] = startSeq;
    }

    if (endSeq != null) {
      json['endSeq'] = endSeq;
    }

    if (group != null) {
      json['group'] = group!.value;
    }

    return json;
  }
}

class GetStateResponse {
  List<UpdateStateModel>? states;

  GetStateResponse({
    this.states,
  });

  factory GetStateResponse.fromMap(Map<String, dynamic> json) {
    final List<dynamic> stateResp = json['data'];

    final states = stateResp.map((e) => UpdateStateModel.fromMap(e)).toList();

    return GetStateResponse(states: states);
  }
}
