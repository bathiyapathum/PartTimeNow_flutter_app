import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parttimenow_flutter/Widgets/custome_text_field.dart';
import 'package:parttimenow_flutter/models/post_model.dart';

class JobPostingPage extends StatefulWidget {
  const JobPostingPage({super.key});
  @override
  _JobPostingPageState createState() => _JobPostingPageState();
}

class _JobPostingPageState extends State<JobPostingPage> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Initialize Firebase Authentication

  Future<User?> getUser() async {
    return _auth.currentUser; // Get the currently authenticated user
  }

  CollectionReference jobs = FirebaseFirestore.instance.collection('posts');

  Future<void> _postJob() async {
    try {
      final User? user = await getUser();

      if (user != null) {
        DocumentReference users =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot userSnapshot = await users.get();
        final job = PostModel(
          postId: UniqueKey().toString(),
          userName: userSnapshot['username'] ??
              'User Name', // Replace with user's name if available
          gender: 'Gender', // Replace with user's gender if available
          startDate: startDateController.text,
          endDate: endDateController.text,
          startTime: startTimeController.text,
          salary: salaryController.text,
          location: locationController.text,
          description: descriptionController.text,
          endTime: endTimeController.text,
          uid: user.uid,
          photoUrl: userSnapshot['photoUrl'] ??
              'photo', // Replace with user's photo URL if available
          feedbacksId: [], // Initialize with an empty list of feedbacks
        );

        await jobs.add(job.toJson());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Job posted successfully!'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to post job. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Job'),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.deepOrange.shade50,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle close button press here
                    },
                    icon: Icon(Icons.close),
                    color: Colors.black,
                    // Replace with your close icon
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _postJob,
                      child: const Text('Post Job'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      hint: 'Start Date',
                      label: 'Start Date',
                      controller: startDateController,
                      rightIcon: Icons.calendar_today,
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(
                      width: 16.0), // Add some spacing between the text fields
                  Flexible(
                    child: CustomTextField(
                      hint: 'Start Time',
                      label: 'Start Time',
                      controller: startTimeController,
                      rightIcon: Icons.access_time,
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      hint: 'End Date',
                      label: 'End Date',
                      controller: endDateController,
                      rightIcon: Icons.calendar_today,
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(
                      width: 16.0), // Add some spacing between the text fields
                  Flexible(
                    child: CustomTextField(
                      hint: 'End Time',
                      label: 'End Time',
                      controller: endTimeController,
                      rightIcon: Icons.access_time,
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                hint: 'Salary',
                label: 'Salary',
                controller: salaryController,
                rightIcon: Icons.attach_money,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                hint: 'Location',
                label: 'Location',
                controller: locationController,
                rightIcon: Icons.location_on,
                textInputType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                hint: 'Description',
                label: 'Description',
                controller: descriptionController,
                rightIcon: Icons.description,
                textInputType: TextInputType.multiline,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
