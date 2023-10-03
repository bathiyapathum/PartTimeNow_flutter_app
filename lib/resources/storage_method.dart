// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
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
            .whenComplete(() => print("Image uploaded to storage"))
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

//adding image to firebase storage

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
