import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final logger = Logger();

pickImage(ImageSource source) async {

  final ImagePicker picker = ImagePicker();

  XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    return await image.readAsBytes();
  }
  logger.d('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
