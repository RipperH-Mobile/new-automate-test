class GetEmojiPackageItemsRequest {
  final String emojiPackageId;

  GetEmojiPackageItemsRequest({
    required this.emojiPackageId,
  });

  factory GetEmojiPackageItemsRequest.fromMap(Map<String, dynamic> json) => GetEmojiPackageItemsRequest(
        emojiPackageId: json['emojiPackageId'],
      );

  Map<String, dynamic> toMap() => {
        'emojiPackageId': emojiPackageId,
      };
}
