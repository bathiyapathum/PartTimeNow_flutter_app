// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parttimenow_flutter/models/feeback_model.dart';
import 'package:parttimenow_flutter/models/post_model.dart';
import 'package:parttimenow_flutter/models/user_model.dart';
import 'package:parttimenow_flutter/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
          file != null) {
        //Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid);

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
  }) async {
    try {
      // Check if the user is authenticated
      if (_auth.currentUser != null) {
        final feedbackData = FeedbackModel(
          userId: _auth.currentUser!.uid,
          rating: rating,
          feedback: feedback,
        );

        final firebaseFeedback = _firestore.collection('feedback');

        await firebaseFeedback.add(feedbackData.toJson());

        // Handle successful submission
      } else {
        // Handle the case where the user is not logged in
        throw Exception('User not logged in');
      }
    } catch (e) {
      // Handle the error
      print('Feedback submission error: $e');
    }
  }

// Post job
  Future<void> postJob({
    required DateTime startDate,
    required DateTime endDate,
    required double salary,
    required String location,
    required String description,
  }) async {
    try {
      () async {
        if (_auth.currentUser != null) {
          final jobData = JobPostModel(
            userId: _auth.currentUser!.uid,
            startDate: startDate,
            endDate: endDate,
            salary: salary,
            location: location,
            description: description,
          );

          final firebaseJobs = _firestore.collection('jobs');
          await firebaseJobs.add(jobData.toJson());

          // Handle successful job posting
          print('Job posted successfully');
        }
      }();
    } catch (e) {
      // Handle the error and print it for debugging
      print('Job posting error: $e');
      throw Exception(
          'Job posting error: $e'); // Rethrow the exception with the error message
    }
  }
}
