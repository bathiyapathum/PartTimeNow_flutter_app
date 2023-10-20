import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String color;
  const ChatBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color == 'sender'
            ? Colors.deepOrange
            : const Color.fromRGBO(255, 205, 189, 0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 228, 228, 228).withOpacity(0.5),
            spreadRadius: 0.8,
            blurRadius: 0.5,
            offset: const Offset(0, 0.4), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Text(
          message,
          style: TextStyle(
            color: color == 'sender' ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
