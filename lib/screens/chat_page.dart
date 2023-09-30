import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/chat_bubble.dart';
import 'package:parttimenow_flutter/Widgets/chat_text_field.dart';
import 'package:parttimenow_flutter/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserID;
  final String recieverUserImage;
  const ChatPage(
      {super.key,
      required this.recieverUserEmail,
      required this.recieverUserID,
      required this.recieverUserImage});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? currentUserImageURL; // To store the current user's image URL

  @override
  void initState() {
    super.initState();
    getCurrentUserImageURL().then((url) {
      setState(() {
        currentUserImageURL = url;
      });
    });
  }

  Future<String?> getCurrentUserImageURL() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      // Fetch the user's image URL from your data source (e.g., Firebase Firestore)
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userData['photoUrl'];
    }
    return null;
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepOrange,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.recieverUserImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.recieverUserEmail[0].toUpperCase() +
                  widget.recieverUserEmail.substring(1),
              style: const TextStyle(color: Colors.deepOrange),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              // Add your logic for the dot menu here
            },
            icon: const Icon(
              Icons.more_vert, // Vertical ellipsis icon
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //message
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildMessageInput(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          widget.recieverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  (data['senderId'] == _firebaseAuth.currentUser!.uid)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                if (data['senderId'] != _firebaseAuth.currentUser!.uid)
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(data['senderId'])
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show a loading indicator while fetching data
                      }
                      if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text(
                          'User not found',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                      final senderData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final senderImageUrl = senderData['photoUrl'];
                      return CircleAvatar(
                        backgroundImage: NetworkImage(senderImageUrl),
                        radius: 15, // Adjust the radius as needed
                      );
                    },
                  ),
                const SizedBox(
                  width: 10,
                ),
                ChatBubble(
                    message: data['message'],
                    color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                        ? 'sender'
                        : 'reciever'),
                const SizedBox(
                  width: 10,
                ),
                if (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(data['senderId'])
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show a loading indicator while fetching data
                      }
                      if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text(
                          'User not found',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                      final senderData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final senderImageUrl = senderData['photoUrl'];
                      return CircleAvatar(
                        backgroundImage: NetworkImage(senderImageUrl),
                        radius: 15, // Adjust the radius as needed
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Add logic to handle photo button click here
            },
            icon: const Icon(
              Icons.camera_alt_outlined,
              size: 35,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ChatTextField(
              controller: _messageController,
              hintText: 'Enter Message',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
