import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/utills.dart';
import 'package:intl/intl.dart';
// Import your AuthMethod class

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

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
        controller.text = formatDate(picked);
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

  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  String formatTime(DateTime time) {
    final formatter = DateFormat('h:mm a');
    return formatter.format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: mobileBackgroundColor,
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
                        margin: const EdgeInsets.only(
                            right:
                                8), // Add gap between Start Date and Start Time
                        child:
                            buildTextField('Start Date', startDateController),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
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
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8), // Add gap between End Date and End Time
                        child: buildTextField('End Date', endDateController),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8), // Add gap between End Date and End Time
                        child: buildTextField('End Time', endTimeController),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildTextField('Salary', salaryController),
            const SizedBox(height: 10),
            buildTextField('Location', locationController),
            const SizedBox(height: 10),
            buildDescriptionField(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Add a print statement to check if this code block is executed
                logger.d("Post Job button pressed");

                final startDate = DateTime.parse(startDateController.text);
                final endDate = DateTime.parse(endDateController.text);
                final salary = double.parse(salaryController.text);
                final location = locationController.text;
                final description = descriptionController.text;

                await AuthMethod().postJob(
                  startDate: startDate,
                  endDate: endDate,
                  salary: salary,
                  location: location,
                  description: description,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                );

                // Handle successful job posting
                // Clear text controllers or navigate to another screen as needed
                startDateController.clear();
                startTimeController.clear();
                endDateController.clear();
                endTimeController.clear();
                salaryController.clear();
                locationController.clear();
                descriptionController.clear();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Button background color
                backgroundColor: mobileBackgroundColor, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                minimumSize: const Size(150, 40), // Set the button size
              ),
              child: const Text('Post Job', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          color: Colors.black, fontSize: 14), // Adjust font size
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 14), // Adjust font size
        hintText: 'Enter a value',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10), // Adjust field size
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 206, 124, 0)),
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
      style: const TextStyle(
          color: Colors.black, fontSize: 14), // Adjust font size
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 14), // Adjust font size
        hintText: 'Enter a description',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10), // Adjust field size
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 255, 162, 22)),
          borderRadius: BorderRadius.circular(10), // Adjust field size
        ),
      ),
    );
  }
}
