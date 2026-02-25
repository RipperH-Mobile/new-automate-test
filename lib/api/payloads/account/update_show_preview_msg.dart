class UpdateShowPreviewRequest {
  final bool hiddenMessageNotification;

  UpdateShowPreviewRequest({
    required this.hiddenMessageNotification,
  });

  Map<String, dynamic> toJson() {
    return {'hiddenMessageNotification': hiddenMessageNotification};
  }
}
