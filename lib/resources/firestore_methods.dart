import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/models/job_request_model.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';

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

  Future<void> makeRequest(String postId, String uId, List req, String desc,
      String postOwner) async {
    final user = await AuthMethod().getUserDetails();
    final requestData = JobRequestModel(
      userId: uId,
      postId: postId,
      username: user.username,
      photoUrl: user.photoUrl,
      description: desc,
      postOwner: postOwner,
    );

    logger.d(requestData.toJson());

    try {
      if (req.contains(uId)) {
        await _firestore.collection('posts').doc(postId).update({
          'requests': FieldValue.arrayRemove([uId]),
        });
        QuerySnapshot querySnapshot = await _firestore
            .collection('jobrequests')
            .where('userId', isEqualTo: uId)
            .where('postId', isEqualTo: postId)
            .get();

        for (var document in querySnapshot.docs) {
          document.reference.delete();
        }
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'requests': FieldValue.arrayUnion([uId]),
        });
        await _firestore
            .collection('jobrequests')
            .doc()
            .set(requestData.toJson());
      }
    } catch (e) {
      logger.e('heheheeh $e');
    }
  }

  Future<void> getRequestById(String uId) async {
    try {
      await _firestore
          .collection('jobrequests')
          .where('userId', isEqualTo: uId)
          .get();
    } catch (e) {
      logger.e('heheheeh $e');
    }
  }
}
