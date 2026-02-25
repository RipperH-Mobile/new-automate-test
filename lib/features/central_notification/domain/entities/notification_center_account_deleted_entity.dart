class NotificationCenterAccountDeletedEntity {
  final String accountId;

  NotificationCenterAccountDeletedEntity({
    required this.accountId,
  });

  factory NotificationCenterAccountDeletedEntity.fromJson(Map<String, dynamic> json) {
    return NotificationCenterAccountDeletedEntity(
      accountId: json['accountId'],
    );
  }
}
