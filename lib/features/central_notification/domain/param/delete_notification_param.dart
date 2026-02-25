class DeleteNotificationParam {
  String notiId;

  DeleteNotificationParam({
    required this.notiId,
  });

  Map<String, dynamic> toMap() {
    return {
      'notiId': notiId,
    };
  }
}
