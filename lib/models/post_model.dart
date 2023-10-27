import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userId;
  final String postId;
  final String userName;
  final String gender;
  final String startTime;
  final String location;
  final String description;
  final String endTime;
  final String uid;
  final String photoUrl;
  final List feedbacksId;
  final List saved;
  final List requests;
  final DateTime startDate;
  final DateTime endDate;
  final double salary;
  final int rating;

  PostModel({
    required this.userId,
    required this.startDate,
    required this.startTime,
    required this.userName,
    required this.endDate,
    required this.salary,
    required this.requests,
    required this.location,
    required this.description,
    required this.endTime,
    required this.uid,
    required this.photoUrl,
    required this.feedbacksId,
    required this.saved,
    required this.postId,
    required this.gender,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'userName': userName,
        'gender': gender,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'salary': salary.toDouble(),
        'location': location,
        'requests': requests,
        'description': description,
        'endTime': endTime,
        'uid': uid,
        'photoUrl': photoUrl,
        'feedbacksId': feedbacksId,
        'saved': saved,
        'rating': rating,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      userId: snapshot['userId'],
      userName: snapshot['userName'],
      gender: snapshot['gender'],
      startDate: snapshot['startDate'],
      endDate: snapshot['endDate'],
      startTime: snapshot['startTime'],
      requests: snapshot['requests'],
      salary: snapshot['salary'],
      location: snapshot['location'],
      description: snapshot['description'],
      endTime: snapshot['endTime'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      feedbacksId: snapshot['feedbacksId'],
      saved: snapshot['saved'],
      rating: snapshot['rating'],
    );
  }
}
