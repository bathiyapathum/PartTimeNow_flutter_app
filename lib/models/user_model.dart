import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String bio;
  final String uid;
  final String photoUrl;
  final List followers;
  final List following;
  final List categories;

  const UserModel({
    required this.username,
    required this.email,
    required this.bio,
    required this.uid,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.categories,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'bio': bio,
        'uid': uid,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'categories': categories,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      categories: snapshot['categories'],
    );
  }
}
