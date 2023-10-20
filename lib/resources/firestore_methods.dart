import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FireStoreMethods {
  final logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePost(String postId, String uId, List saved) async {
    try {
      if (saved.contains(uId)) {
        await _firestore.collection('posts').doc(postId).update({
          'saved': FieldValue.arrayRemove([uId]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'saved': FieldValue.arrayUnion([uId]),
        });
      }
    } catch (e) {
      logger.e('heheheeh $e');
    }
  }

  Future<void> updateUserPref(
      String uId, String location, List categories) async {
    try {
      await _firestore.collection('users').doc(uId).update({
        'location': location,
        'categories': categories,
      });
    } catch (e) {
      logger.e('heheheeh $e');
    }
  }
}
