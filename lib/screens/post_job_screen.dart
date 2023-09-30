import 'package:flutter/material.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    salaryController.dispose();
    locationController.dispose();
    descriptionController.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = picked.toString();
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Job'),
        backgroundColor: Color.fromARGB(255, 206, 124, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            right:
                                8), // Add gap between Start Date and Start Time
                        child:
                            buildTextField('Start Date', startDateController),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left:
                                8), // Add gap between Start Date and Start Time
                        child:
                            buildTextField('Start Time', startTimeController),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 8), // Add gap between End Date and End Time
                        child: buildTextField('End Date', endDateController),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 8), // Add gap between End Date and End Time
                        child: buildTextField('End Time', endTimeController),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            buildTextField('Salary', salaryController),
            SizedBox(height: 10),
            buildTextField('Location', locationController),
            SizedBox(height: 10),
            buildDescriptionField(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle the form submission here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Button background color
                onPrimary: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                minimumSize: Size(150, 40), // Set the button size
              ),
              child: Text('Post Job', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black, fontSize: 14), // Adjust font size
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            TextStyle(color: Colors.black, fontSize: 14), // Adjust font size
        hintText: 'Enter a value',
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
      onTap: () {
        if (labelText.contains('Date')) {
          _selectDate(context, controller);
        } else if (labelText.contains('Time')) {
          _selectTime(context, controller);
        }
      },
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      controller: descriptionController,
      style: TextStyle(color: Colors.black, fontSize: 14), // Adjust font size
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle:
            TextStyle(color: Colors.black, fontSize: 14), // Adjust font size
        hintText: 'Enter a description',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10), // Adjust field size
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10), // Adjust field size
        ),
      ),
    );
  }
}
