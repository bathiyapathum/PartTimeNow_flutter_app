import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final String type;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.type,
    required this.timestamp,
  });
  Message.fromMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        senderEmail = map['senderEmail'],
        recieverId = map['recieverId'],
        message = map['message'],
        type = map['type'],
        timestamp = map['timestamp'];

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'type': type,
      'timestamp': timestamp,
    };
  }
}
