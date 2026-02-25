class LeaveGroupWithMeAsAnOwnerRequest {
  final String actionToken;

  LeaveGroupWithMeAsAnOwnerRequest({
    required this.actionToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionToken': actionToken,
    };
  }
}
