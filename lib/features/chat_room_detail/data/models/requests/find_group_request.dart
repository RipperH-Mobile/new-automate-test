class FindGroupRequest {
  final String? roomId;
  final String? ref;

  FindGroupRequest({
    this.roomId,
    this.ref,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (roomId != null) {
      json['roomId'] = roomId;
    }

    if (ref != null) {
      json['ref'] = ref;
    }

    return json;
  }
}
