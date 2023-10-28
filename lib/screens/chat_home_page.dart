import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttimenow_flutter/Widgets/shimmer_message_card.dart';
import 'package:parttimenow_flutter/screens/category_selection_screen.dart';
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
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const LoginScreen(), // Replace with your login screen
        ),
      );
    } catch (e) {
      logger.e('Error signing out: $e');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    // getChatRoomID();
  }

  // Future<void> getChatRoomID() async {
  //   DocumentSnapshot chatRoomID = await _firestore
  //       .collection('chat_rooms')
  //       .doc(_auth.currentUser!.uid)
  //       .get();

  //   logger.e(chatRoomID);
  // }
  void showShrim({
    required context,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CategorySelectionScreen(),

//         builder: (context) => const NotificationCard(),
      ),
    );
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
          margin: const EdgeInsets.only(left: 10),
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
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                showShrim(context: context);
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
        margin: const EdgeInsets.only(top: 2),
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
      List<String> userIds = [_firebaseAuth.currentUser!.uid, document.id];
      userIds.sort();
      String chatRoomId = userIds.join('_');

      logger.e('Chat room ID: $chatRoomId');

      // chatRoomsCollection.get().then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     // Here, 'doc.id' will give you the ID of each document in the collection
      //     String documentID = doc.id;
      //     logger.e('Document ID: $documentID');
      //     // Now, you can use the document ID to get the unreadCount
      //   });
      // }).catchError((error) {
      //   // logger.e("Error getting documents: $error");
      // });

      return FutureBuilder<int>(
          future: _chatService.getUnreadCount(chatRoomId),
          builder: (context, unreadCountSnapshot) {
            if (unreadCountSnapshot.connectionState ==
                ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: const ShrimmerMessageCard(),
                ),
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
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                    0.3), // Adjust opacity as needed
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Row(
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
                                              ? NetworkImage(
                                                  userData['photoUrl'])
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
                                  subtitle: StreamBuilder<DocumentSnapshot>(
                                    stream:
                                        _chatService.getLastMessage(chatRoomId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return const Text('No messages found');
                                      } else {
                                        final data = snapshot.data?.data()
                                            as Map<String, dynamic>;
                                        var lastMessage = data['message'];
                                        final type = data['type'];

                                        type == 'img'
                                            ? lastMessage = 'Image'
                                            : lastMessage = lastMessage;
                                        return Text(
                                          lastMessage,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        );
                                      }
                                    },
                                  ),
                                  onTap: () async {
                                    await _chatService
                                        .resetUnreadCount(chatRoomId);

                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          recieverUserEmail:
                                              userData['username'],
                                          recieverUserID: document.id,
                                          recieverUserImage:
                                              userData['photoUrl'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            unreadCountSnapshot.data == 0
                                ? const SizedBox()
                                : Container(
                                    width: 20, // Adjust the width as needed
                                    height: 20, // Adjust the height as needed
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          mobileBackgroundColor, // You can change the color
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
                            const SizedBox(width: 20),
                            // Add spacing between the card and the count circle
                          ],
                        ),
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
