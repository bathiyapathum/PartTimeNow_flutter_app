import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/models/user_model.dart';
import 'package:parttimenow_flutter/providers/user_provider.dart';
import 'package:parttimenow_flutter/resources/firestore_methods.dart';
import 'package:parttimenow_flutter/screens/feedback_screen.dart';
import 'package:parttimenow_flutter/screens/feedback_screen_layout.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatefulWidget {
  final dynamic snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final logger = Logger();
  bool isSaved = false;
  int num = 1;

  String postId = '';

  @override
  void initState() {
    super.initState();
    postId = widget.snap['uid'];
  }

  void postSave(user) async {
    logger.d('user ${user.uid}');
    logger.d('post ${widget.snap['postId']}');

    if (widget.snap['saved'].contains(user.uid)) {
      isSaved = true;
    } else {
      isSaved = false;
    }
    await FireStoreMethods().savePost(
      widget.snap['postId'],
      user.uid,
      widget.snap['saved'],
    );
    setState(() {
      num += 2;
    });
    logger.d('saved');
  }

  void clickRating({
    required context,
    required String postUserId,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
            child: FeedbackScreenLayout(feedbackUserId: postUserId));
      },
    );
  }

  void openFeedbackModel(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedbackScreen(postID: postId),
      ),
    );
  }

  String formatDate(DateTime? date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return date != null ? formatter.format(date) : 'N/A';
  }

  Widget buildStarRating(int rating) {
    List<Widget> stars = [];

    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        Icons.star,
        color: i < rating ? Colors.yellow[700] : Colors.grey,
        size: 16,
      ));
    }

    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rating = widget.snap['rating'] ?? 5;
    final UserModel user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).userModel;

    final startDate = widget.snap['startDate'] is Timestamp
        ? (widget.snap['startDate'] as Timestamp).toDate()
        : null;
    final endDate = widget.snap['endDate'] is Timestamp
        ? (widget.snap['endDate'] as Timestamp).toDate()
        : null;

    return Center(
      child: Card(
        elevation: 20,
        color: postCardbackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ).copyWith(right: 0),
                child: Row(
                  children: [
                    widget.snap['photoUrl']?.toString() == null
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : FutureBuilder(
                            future: precacheImage(
                              NetworkImage(
                                widget.snap['photoUrl']?.toString() ??
                                    'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                              ),
                              context,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                    widget.snap['photoUrl']?.toString() ??
                                        'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYW-ltZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                                  ),
                                );
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.grey,
                                  ),
                                );
                              }
                            },
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['userName']?.toString() ?? 'N/A',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => clickRating(
                                  context: context,
                                  postUserId: widget.snap['uid']),
                              child: Row(
                                children: [
                                  Text(
                                    '$rating Star Rating',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 194, 188, 188),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  buildStarRating(rating),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shrinkWrap: true,
                              children: const [
                                ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.more_vert,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Table(
                      border: TableBorder.all(color: Colors.transparent),
                      columnWidths: const {0: FixedColumnWidth(110)},
                      children: [
                        TableRow(
                          children: [
                            const TableCell(
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.snap['gender']?.toString() ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDate(startDate),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    formatDate(endDate),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Text(
                                'Time',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.snap['startTime']?.toString() ??
                                        'N/A',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.snap['endTime']?.toString() ?? 'N/A',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Text(
                                'Salary',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF9CFF5A),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Text(
                                        widget.snap['salary']?.toString() ??
                                            'N/A',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Text(
                                'Location',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.snap['location']?.toString() ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                            TableCell(
                              child: SizedBox(height: 16),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(height: 0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.snap['description']?.toString() ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      postSave(user);
                    },
                    icon: widget.snap['saved'].contains(user.uid)
                        ? SvgPicture.asset(
                            'assets/saved.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.srcIn),
                          )
                        : SvgPicture.asset(
                            'assets/saved.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        openFeedbackModel(context);
                      },
                      icon: SvgPicture.asset(
                        'assets/feedback.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/addRequest.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          logger.d('Message');
                        },
                        icon: SvgPicture.asset(
                          'assets/message.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
