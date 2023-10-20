import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String label;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.label,
    required this.textInputType,
  });

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: signInBtn),
    gapPadding: 10,
  );
  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: inputField),
    gapPadding: 10,
  );

  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 8, // Blur radius
            offset: Offset(2, 6),
            // Offset
          ),
        ],
      ),
      child: TextField(
        controller: widget.textEditingController,
        focusNode: _focusNode,
        style: GoogleFonts.lato(
          color: Colors.black,
          letterSpacing: 1,
        ),
        decoration: InputDecoration(
          fillColor: inputField,
          labelText: widget.label,
          focusedBorder: inputBorder,
          enabledBorder: enableBorder,
          labelStyle: GoogleFonts.lato(
            color: isFocused ? signInBtn : Colors.grey.shade500,
            fontSize: 18,
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: GoogleFonts.lato(
            color: hintColor,
          ),
        ),
        keyboardType: widget.textInputType,
        obscureText: widget.isPass,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
