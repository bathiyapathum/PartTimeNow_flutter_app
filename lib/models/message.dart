import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final String type;
  final String read;
  final String sent;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.type,
    required this.read,
    required this.sent,
    required this.timestamp,
  });
  Message.fromMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        senderEmail = map['senderEmail'],
        recieverId = map['recieverId'],
        message = map['message'],
        type = map['type'],
        read = map['read'],
        sent = map['sent'],
        timestamp = map['timestamp'];

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'type': type,
      'read': read,
      'sent': sent,
      'timestamp': timestamp,
    };
  }
}
