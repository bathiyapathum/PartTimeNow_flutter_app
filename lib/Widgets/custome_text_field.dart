// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hint;
  final String label;
  final TextInputType textInputType;
  final IconData rightIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.isPass = false,
    required this.hint,
    required this.label,
    required this.textInputType,
    required this.rightIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Future<void> _selectDate(BuildContext context) async {
    if (widget.textInputType == TextInputType.datetime) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light(), // Ensure a light theme for date picker
            child: child!,
          );
        },
      );

      if (picked != null) {
        // Format the selected date without the time
        final formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        widget.controller.text = formattedDate;
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final formattedTime = picked.format(context); // Format the selected time
      widget.controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(
        color: Colors.black,
        letterSpacing: 1,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        border: const OutlineInputBorder(
          // Use OutlineInputBorder for border
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Customize border radius as needed
          borderSide: BorderSide(color: Colors.black), // Customize border color
        ),
        focusedBorder: const OutlineInputBorder(
          // Customize focused border
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Customize border radius as needed
          borderSide: BorderSide(
              color: Colors.blue), // Customize border color for focus
        ),
        enabledBorder: OutlineInputBorder(
          // Customize enabled border
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0)), // Customize border radius as needed
          borderSide: BorderSide(
              color: Colors.grey[300]!), // Customize border color when enabled
        ),
        suffixIcon: widget.textInputType == TextInputType.datetime &&
                (widget.label == 'Start Date' || widget.label == 'End Date')
            ? GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Icon(
                  widget.rightIcon,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              )
            : widget.textInputType == TextInputType.datetime &&
                    (widget.label == 'Start Time' || widget.label == 'End Time')
                ? GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Icon(
                      widget.rightIcon,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  )
                : Icon(
                    widget.rightIcon,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass,
    );
  }
}
