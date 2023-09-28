// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class StorageMethod {
  final logger = Logger();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// adding images to fireebase storage
  Future<String> uploadImage({
    required String path,
    required bool isPost,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (path.isNotEmpty || file != null) {
        //upload image
        TaskSnapshot snapshot = await _storage
            .ref()
            .child(path)
            .child(_auth.currentUser!.uid)
            .putData(file)
            .whenComplete(() => logger.d("Image uploaded to storage"))
            .catchError((e) => res = e);

        //get image url
        String url = await snapshot.ref.getDownloadURL();
        res = url;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
