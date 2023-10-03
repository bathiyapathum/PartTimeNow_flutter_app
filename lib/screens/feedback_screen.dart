import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/models/feeback_model.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int? _rating;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Feedback'),
        backgroundColor: Color.fromARGB(255, 206, 124, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Rate Your Experience',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildStarRating(),
              SizedBox(height: 30),
              Text(
                'Please Share Your Opinion\nAbout This Job!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildFeedbackField(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_rating != null) {
                    final feedback = feedbackController.text;

                    await AuthMethod().submitFeedback(
                      rating: _rating!,
                      feedback: feedback,
                    );

                    // Handle successful submission
                    feedbackController.clear();
                    setState(() {
                      _rating = null;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(150, 40),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return IconButton(
            iconSize: 40,
            onPressed: () {
              setState(() {
                _rating = index + 1;
              });
            },
            icon: Icon(
              _rating != null && index < _rating!
                  ? Icons.star
                  : Icons.star_border,
              color: Colors.orange,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFeedbackField() {
    return Container(
      width: 300,
      child: TextField(
        controller: feedbackController,
        style: TextStyle(color: Colors.black, fontSize: 18),
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Feedback',
          labelStyle: TextStyle(color: Colors.black, fontSize: 18),
          hintText: 'Enter your feedback here',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 206, 124, 0)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
