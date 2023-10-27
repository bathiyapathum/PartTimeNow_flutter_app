class JobRequestModel {
  final String userId;
  final String postId;
  final String username;
  final String status;
  final String photoUrl;
  final String description;
  final String postOwner;

  JobRequestModel({
    required this.userId,
    required this.postId,
    required this.username,
    this.status = 'pending',
    required this.photoUrl,
    required this.description,
    required this.postOwner,
  });
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'postId': postId,
        'username': username,
        'status': status,
        'photoUrl': photoUrl,
        'description': description,
        'postOwner': postOwner,
      };
}
