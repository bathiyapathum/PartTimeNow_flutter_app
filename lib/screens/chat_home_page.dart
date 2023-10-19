import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/screens/chat_page.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    const backgroundGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Messages',
          style:
              TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: backgroundGradient,
        margin: const EdgeInsets.only(top: 10),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> userData = document.data()! as Map<String, dynamic>;

    if (_firebaseAuth.currentUser!.email != userData['email']) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat_rooms')
            .doc(document
                .id) // Assuming each chat has a document with the same ID as the user
            .collection('messages')
            .orderBy('timestamp',
                descending: true) // Order messages by timestamp, latest first
            .limit(1) // Limit to the last message
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          final List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
          String lastReplyMessage = '';

          if (messages.isNotEmpty) {
            // Get the last message's text from the snapshot
            lastReplyMessage = messages.first['message'];
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 400,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        const Color.fromARGB(255, 247, 193, 193).withOpacity(0.3),
                  ),
                  child: Center(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: ClipOval(
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: userData['photoUrl'] != null
                                  ? NetworkImage(userData['photoUrl'])
                                  : const AssetImage(
                                          'assets/default_profile_image.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        userData['username'],
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        lastReplyMessage, // Display the last reply message here
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              recieverUserEmail: userData['username'],
                              recieverUserID: document.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Container();
    }
  }
}
