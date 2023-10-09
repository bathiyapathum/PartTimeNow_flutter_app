
class PostModel {
  final String userId; // This field represents the user ID
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
  final DateTime startDate;
  final DateTime endDate;
  final double salary;

  JobPostModel({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.salary,
    required this.location,
    required this.description,
    required this.endTime,
    required this.uid,
    required this.photoUrl,
    required this.feedbacksId,
    required this.saved,
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
        'description': description,
        'endTime': endTime,
        'uid': uid,
        'photoUrl': photoUrl,
        'feedbacksId': feedbacksId,
        'saved': saved,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      userName: snapshot['userName'],
      gender: snapshot['gender'],
      startDate: snapshot['startDate'],
      endDate: snapshot['endDate'],
      startTime: snapshot['startTime'],
      salary: snapshot['salary'],
      location: snapshot['location'],
      description: snapshot['description'],
      endTime: snapshot['endTime'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      feedbacksId: snapshot['feedbacksId'],
      saved: snapshot['saved'],
    );
  });

//   // Convert the model to a JSON format
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'startDate': startDate.toUtc().toIso8601String(),
//       'endDate': endDate.toUtc().toIso8601String(),
//       'salary': salary,
//       'location': location,
//       'description': description,
//     };
// >>>>>>> main
  }
}
