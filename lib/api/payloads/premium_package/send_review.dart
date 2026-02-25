class SendReviewRequest {
  int rating;
  String? description;

  SendReviewRequest({
    required this.rating,
    this.description,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'rating': rating,
      'description': description,
    };
  }
}
