import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

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
}
