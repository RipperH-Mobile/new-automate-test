
class IosCheckReceiptResponse {
  final String? originalAccountIdentifier;
  final String? username;
  final bool? isActiveSubscription;

  IosCheckReceiptResponse({
    required this.originalAccountIdentifier,
    required this.username,
    required this.isActiveSubscription,
  });

  factory IosCheckReceiptResponse.fromMap(Map<String, dynamic> json) {
    return IosCheckReceiptResponse(
      originalAccountIdentifier: json['originalAccountIdentifier'],
      username: json['username'],
      isActiveSubscription: json['isActiveSubscription'],
    );
  }

  @override
  String toString() {
    return 'originalAccountIdentifier: $originalAccountIdentifier, username: $username, isActiveSubscription: $isActiveSubscription';
  }


}
