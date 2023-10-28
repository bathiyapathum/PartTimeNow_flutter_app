import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parttimenow_flutter/Widgets/chat_bubble.dart';
import 'package:parttimenow_flutter/Widgets/chat_text_field.dart';
import 'package:parttimenow_flutter/services/chat/chat_service.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
// import 'package:parttimenow_flutter/utils/my_date_util.dart';
import 'package:uuid/uuid.dart';

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
  File? imageFile; // To store the image file
  var type = 'text';
  @override
  void initState() {
    super.initState();
    getCurrentUserImageURL().then((url) {
      setState(() {
        currentUserImageURL = url;
      });
    });
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      imageFile = File(xFile.path);
      await uploadImage(imageFile!);
    }
  }

  String formatTimestamp(dynamic timestamp) {
    if (timestamp is int) {
      // Create a DateTime object from the timestamp
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

      // Format the DateTime to display hours and minutes
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      // Handle the case where timestamp is not an integer by displaying 'N/A'
      return 'N/A';
    }
  }

  Future uploadImage(File imageFile) async {
    String fileName = Uuid().v1();

    try {
      await FirebaseStorage.instance
          .ref()
          .child('images')
          .child("$fileName.jpg")
          .putFile(imageFile);

      String imageUrl = await FirebaseStorage.instance
          .ref()
          .child('images')
          .child("$fileName.jpg")
          .getDownloadURL();

      final String recipientUserId = widget.recieverUserID;
      type = 'img';

      // Send the image URL as a message
      await _chatService.sendMessage(recipientUserId, imageUrl, type);

      // Clear the message input field

      logger.e(imageUrl);
    } catch (error) {
      logger.e("Error uploading image: $error");
    }
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
      final String recipientUserId = widget.recieverUserID;
      final String messageText = _messageController.text;
      type = 'text';
      // Send the message
      await _chatService.sendMessage(recipientUserId, messageText, type);
      // Clear the message input field
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
    final Size size = MediaQuery.of(context).size;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return data['type'] == 'text'
        ? Container(
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                      GestureDetector(
                        onLongPress: () {
                          // Handle long-press here
                          if (data['senderId'] ==
                              _firebaseAuth.currentUser!.uid) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Delete Message',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Are you sure you want to delete this message?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('messages')
                                                    .doc(document.id)
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            // This is a message received by the current user
                            // Handle actions specific to receiver's messages
                          }
                        },
                        child: ChatBubble(
                          message: data['message'],
                          color: (data['senderId'] ==
                                  _firebaseAuth.currentUser!.uid)
                              ? 'sender'
                              : 'reciever',
                        ),
                      ),
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                            // final senderData =
                            //     snapshot.data!.data() as Map<String, dynamic>;
                            // final senderImageUrl = senderData['photoUrl'];
                            // return CircleAvatar(
                            //   backgroundImage: NetworkImage(senderImageUrl),
                            //   radius: 15, // Adjust the radius as needed
                            // );
                            return Container(
                                //     child: Text(
                                //   MyDateUtil.getFormattedTime(
                                //       context: context, time: data['timestamp']),
                                // )
                                );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: data['senderId'] == _firebaseAuth.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                // Handle the onTap behavior (e.g., navigate to a new screen)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ShowImage(
                      imageUrl: data['message'],
                    ),
                  ),
                );
              },
              onLongPress: () {
                // Handle the onTap behavior (e.g., navigate to a new screen)
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Delete Message',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Are you sure you want to delete this message?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('messages')
                                        .doc(document.id)
                                        .delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
                alignment: data['message'] != "" ? null : Alignment.center,
                child: data['message'] != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        child: Image.network(
                          data['message'],
                          fit: BoxFit.cover,
                        ),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
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
            onPressed: () => getImage(),
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

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
