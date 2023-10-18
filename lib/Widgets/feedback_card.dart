import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/resources/firestore_methods.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  const FeedbackCard({super.key, required this.snap});

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  final logger = Logger();
  bool isSaved = false;
  int num = 1;

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
          // color: postCardbackgroundColor,
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
                                        'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
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
                                const Text(
                                  '',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 194, 188, 188),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                  size: 16,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // const Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 8),
                    //     child: Text(
                    //       "Rating",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //   ],
                    // ),
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
                    )
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
