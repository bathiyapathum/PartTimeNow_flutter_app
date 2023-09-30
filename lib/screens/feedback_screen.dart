import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20), // Add left padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Rate Us: ',
                      style: TextStyle(fontSize: 1),
                    ),
                    _buildStarRating(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildFeedbackField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle feedback submission here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Button background color
                onPrimary: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                minimumSize: Size(150, 40), // Set the button size
              ),
              child: Text('Submit', style: TextStyle(fontSize: 16)),
            ),
          ],
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
            iconSize: 30, // Increase the star size
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
      width: 300, // Adjust the field width
      child: TextField(
        controller: feedbackController,
        style: TextStyle(color: Colors.black, fontSize: 18), // Adjust font size
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Feedback',
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 18), // Adjust font size
          hintText: 'Enter your feedback here',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10), // Adjust field size
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 206, 124, 0)),
            borderRadius: BorderRadius.circular(10), // Adjust field size
          ),
        ),
      ),
    );
  }
}
