import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String userId;
  final String feedback;
  final int rating;
  final Timestamp timestamp;

  const FeedbackModel({
    required this.userId,
    required this.feedback,
    required this.rating,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'feedback': feedback,
        'rating': rating,
        'timestamp': timestamp,
      };

  static FeedbackModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return FeedbackModel(
      userId: snapshot['userId'],
      feedback: snapshot['feedback'],
      rating: snapshot['rating'],
      timestamp: snapshot['timestamp'],
    );
  }
}
