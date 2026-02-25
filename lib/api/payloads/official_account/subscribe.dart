class SubscribeRequest {
  String officialAccountId;

  SubscribeRequest({
    required this.officialAccountId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'officialAccountId': officialAccountId,
    };

    return json;
  }
}
