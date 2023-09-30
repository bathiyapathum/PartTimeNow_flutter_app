class FeedbackModel {
  final String userId;
  final int rating;
  final String feedback;

  FeedbackModel({
    required this.userId,
    required this.rating,
    required this.feedback,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'rating': rating,
        'feedback': feedback,
      };
}
