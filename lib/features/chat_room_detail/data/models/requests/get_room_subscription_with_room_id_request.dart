class GetRoomSubscriptionWithRoomIdRequest {
  final String id;

  GetRoomSubscriptionWithRoomIdRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}