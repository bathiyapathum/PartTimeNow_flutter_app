import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/models/feeback_model.dart';
import 'package:parttimenow_flutter/models/post_model.dart';
import 'package:parttimenow_flutter/models/user_model.dart';
import 'package:parttimenow_flutter/resources/storage_method.dart';

class AuthMethod {
  final logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? get currentUser => _auth.currentUser;

  Future<UserModel> getUserDetails() async {
    //not a model class
    User currentUser = _auth.currentUser!;

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(doc);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          // ignore: unnecessary_null_comparison
          file != null) {
        //Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        logger.d(cred.user!.uid);

        String photoUrl = await StorageMethod().uploadImage(
          path: 'profilePics',
          isPost: false,
          file: file,
        );

        //create user model
        UserModel user = UserModel(
          username: username,
          email: email,
          bio: bio,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        //save user details to db
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "Success";
      } else {
        if (username.isEmpty) {
          res = "Please Enter username";
        } else if (email.isEmpty) {
          res = "Please Enter email";
        } else if (password.isEmpty) {
          res = "Please Enter password";
        } else if (bio.isEmpty) {
          res = "Please Enter bio";
        } else {
          res = "Some error occured";
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        res = "The account already exists for that email";
      } else if (e.code == 'invalid-email') {
        res = "Invalid email";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //Login users
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //Login user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        if (email.isEmpty) {
          res = "Please Enter email";
        } else if (password.isEmpty) {
          res = "Please Enter password";
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password provided for that user";
      } else if (e.code == 'invalid-email') {
        res = "Invalid email";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //feedback
  Future<void> submitFeedback({
    required int rating,
    required String feedback,
    required String feedbackUserId,
  }) async {
    try {
      // Check if the user is authenticated
      if (_auth.currentUser != null) {
        final feedbackData = FeedbackModel(
          userId: _auth.currentUser!.uid,
          rating: rating,
          feedback: feedback,
          photoUrl: (await getUserDetails()).photoUrl,
          username: (await getUserDetails()).username,
          feedbackId: '',
          feedbackReceiverId: feedbackUserId,
        );

        final firebaseFeedback = _firestore.collection('feedback');
        final documentReference =
            await firebaseFeedback.add(feedbackData.toJson());

        feedbackData.feedbackId = documentReference.id;
        await documentReference.update({'feedbackId': feedbackData.feedbackId});
      } else {
        // Handle the case where the user is not logged in
        throw Exception('User not logged in');
      }
    } catch (e) {
      // Handle the error
      logger.d('Feedback submission error: $e');
    }
  }

// Post job
  Future<void> postJob({
    required DateTime startDate,
    required DateTime endDate,
    required double salary,
    required String location,
    required String description,
    required String startTime,
    required String endTime,
    required String gender,
  }) async {
    try {
      if (_auth.currentUser != null) {
        getUserDetails().then((value) async {
          final jobData = PostModel(
            userId: _auth.currentUser!.uid,
            startDate: startDate,
            endDate: endDate,
            salary: salary,
            location: location,
            description: description,
            startTime: startTime,
            endTime: endTime,
            userName: value.username,
            uid: _auth.currentUser!.uid,
            photoUrl: value.photoUrl,
            feedbacksId: [],
            saved: [],
            requests: [],
            postId: await generatePostId(),
            rating: 3,
            gender: gender,
          );

          final firebaseJobs = _firestore.collection('posts');
          await firebaseJobs.doc(jobData.postId).set(jobData.toJson());
        });

        // Handle successful job posting
        logger.d('Job posted successfully');
      } else {
        // Handle the case where the user is not logged in
        throw Exception('User not logged in');
      }
    } catch (e) {
      // Handle the error and print it for debugging
      logger.d('Job posting error: $e');
      throw Exception(
          'Job posting error: $e'); // Rethrow the exception with the error message
    }
  }

  Future<String> generatePostId() async {
    final documentReference = await _firestore.collection('posts').doc();
    return documentReference.id;
  }
}
