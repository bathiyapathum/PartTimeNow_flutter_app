import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/resources/firestore_methods.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackCard extends StatefulWidget {
  final snap;

  const FeedbackCard({super.key, required this.snap});

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  final logger = Logger();
  bool isSaved = false;

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
      // Update your data here
    });
    logger.d('saved');
  }

  Widget buildStarRating(int rating) {
    List<Widget> stars = [];

    for (int i = 0; i < rating; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow[700],
        size: 16,
      ));
    }

    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rating = widget.snap['rating']?.toString() ?? 'N/A';

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
                    if (widget.snap['photoUrl'] == null)
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey,
                        ),
                      )
                    else
                      FutureBuilder(
                        future: precacheImage(
                          NetworkImage(
                            widget.snap['photoUrl'] ??
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
                                widget.snap['photoUrl'] ??
                                    'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYW-ltZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                              ),
                            );
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: CircleAvatar(
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
                              widget.snap['username']?.toString() ?? 'N/A',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            Row(
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
                                buildStarRating(widget.snap['rating'] ?? 0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.snap['feedback']?.toString() ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
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
