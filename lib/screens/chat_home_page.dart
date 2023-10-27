import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttimenow_flutter/screens/chat_page.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:parttimenow_flutter/services/chat/chat_service.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // You can navigate to the login or home screen after signing out
      // For example, you can use Navigator.pushReplacement to replace the current screen with a login screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(), // Replace with your login screen
        ),
      );
    } catch (e) {
      logger.e('Error signing out: $e');
    }
  }

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
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 1,
        centerTitle: false,
        title: Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Messages',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                _signOut();
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
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
    String capitalize(String input) {
      if (input.isEmpty) return input;
      return input[0].toUpperCase() + input.substring(1);
    }

    Map<String, dynamic> userData = document.data()! as Map<String, dynamic>;

    if (_firebaseAuth.currentUser!.email != userData['email']) {
      // Get the 'unreadCount' for this chat room
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference chatRoomsCollection =
          firestore.collection('chat_rooms');

      chatRoomsCollection.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Here, 'doc.id' will give you the ID of each document in the collection
          String documentID = doc.id;
          logger.e('Document ID: $documentID');
          // Now, you can use the document ID to get the unreadCount
        });
      }).catchError((error) {
        logger.e("Error getting documents: $error");
      });

      return FutureBuilder<int>(
          future: _chatService.getUnreadCount(document.id),
          builder: (context, unreadCountSnapshot) {
            if (unreadCountSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const SpinKitWanderingCubes(
                color: Color.fromARGB(255, 247, 193,
                    193), // You can set the color of the animation
                size: 80.0,
                // You can set the size of the animation
              );
            }

            final int unreadCount = unreadCountSnapshot.data ?? 0;
            logger.d('Unread count for $chatRoomId: $unreadCount');


            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 400,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 247, 193, 193)
                          .withOpacity(0.3),
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                                capitalize(userData['username']),
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'hnsana', // Display the last reply message here
                                style: GoogleFonts.lato(color: Colors.black),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      recieverUserEmail: userData['username'],
                                      recieverUserID: document.id,
                                      recieverUserImage: userData['photoUrl'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 20, // Adjust the width as needed
                          height: 20, // Adjust the height as needed
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red, // You can change the color
                          ),
                          child: Center(
                            child: Text(
                              unreadCount
                                  .toString(), // Replace with your unread message count
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                20), // Add spacing between the card and the count circle
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    } else {
      return Container();
    }
  }
}
