import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/models/message.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';

class ChatService extends ChangeNotifier {
  //get instance auth and firestore
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(
      String recieverId, String message, String type) async {
    //get current user info
    final String currentUserId = _firebase.currentUser!.uid;
    final String currentUserEmail = _firebase.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      message: message,
      type: type,
      read: 'false',
      sent: 'true',
      timestamp: timestamp,
    );

    //construct chat room id
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');
//add new message to firestore
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    await incrementUnreadCount(chatRoomId);
  }

  //get message collection
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Increment the unreadCount in a chat room
  Future<void> incrementUnreadCount(String chatRoomId) async {
    try {
      final chatRoomRef =
          FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId);

      // Use set with merge: true to create the document if it doesn't exist
      await chatRoomRef.set({
        'unreadCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // logger.e('Unread count incremented by 1');
    } catch (e) {
      // logger.e('Error incrementing unread count: $e');
    }
  }

  // Get the unreadCount for a specific chat room
  Future<int> getUnreadCount(String chatRoomId) async {
    try {
      // logger.e('Fetching unread count for chat room ID: $chatRoomId');

      final chatRoomSnapshot = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .get();
      // logger.e('Chat room snapshot: $chatRoomSnapshot');
      // logger.e('Chat room snapshot exists: ${chatRoomSnapshot.exists}');
      if (chatRoomSnapshot.exists) {
        final data = chatRoomSnapshot.data();
        if (data != null && data.containsKey('unreadCount')) {
          final unreadCount = data['unreadCount'] as int;
          logger.e('Unread count for $chatRoomId: $unreadCount');
          return unreadCount;
        } else {
          logger.e('No "unreadCount" field found for $chatRoomId');
          return 0; // Return a default value if 'unreadCount' field is missing
        }
      } else {
        // logger.e('Chat room document $chatRoomId does not exist');
        return 0; // Return a default value if the document does not exist
      }
    } catch (e) {
      logger.e('Error getting unread count for $chatRoomId: $e');
      return 0; // Return a default value if there's an error
    }
  }

  Future<void> resetUnreadCount(String chatRoomId) async {
    logger.e('Resetting unread count for $chatRoomId');
    try {
      // Update the 'unreadCount' field to 0 for the specified chat room
      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .update({'unreadCount': 0});
    } catch (e) {
      // Handle any errors that may occur during the update operation
      logger.e('Error resetting unread count for $chatRoomId: $e');
    }
  }

  Stream<DocumentSnapshot> getLastMessage(String chatRoomId) {
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        // logger.e('No messages found in chat room $chatRoomId');
      }
      return querySnapshot.docs.first;
    });
  }

  Future<String> getChatRoomId(String userId, String otherUserId) async {
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatRoomId = userIds.join('_');

    // Check if the chat room exists
    DocumentSnapshot chatRoomDoc =
        await _firebaseFirestore.collection('chat_rooms').doc(chatRoomId).get();

    if (chatRoomDoc.exists) {
      return chatRoomId;
    } else {
      // Create a new chat room if it doesn't exist
      await _firebaseFirestore.collection('chat_rooms').doc(chatRoomId).set({
        'users': userIds,
      });

      return chatRoomId;
    }
  }

  Future<void> markMessageAsRead(String senderId, String recieverId) async {
    try {
      await _firebaseFirestore
          .collection('messages')
          .doc()
          .update({'read': true});
    } catch (e) {
      // Handle any errors that may occur during the update operation
      logger.e('Error marking message as read: $e');
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      // Handle any errors that may occur during the delete operation
      logger.e('Error deleting message: $e');
    }
  }
}
