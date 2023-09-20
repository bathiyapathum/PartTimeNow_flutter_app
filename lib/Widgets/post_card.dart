import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        // elevation:20,
        color: Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: Container(

            // color: postCardbackgroundColor,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ).copyWith(right: 0),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),
                    // const Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 8),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'John Doe',
                    //           style: TextStyle(
                    //             color: postUserNameColor,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width:
                                    1),
                             // Adjust the spacing between the icon and text
                            Text(
                              '2h. ago',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 103, 103, 103),
                              ),
                            ),
                            SizedBox(
                                width:
                                    4),
                            Icon(
                              Icons.access_time,
                              size: 14, // Adjust the size as needed
                              color: Color.fromARGB(255, 103, 103, 103),
                            ),
                          ],
                        )
                      ],
                    ),

                    // IconButton(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => Dialog(
                    //         child: ListView(
                    //           padding: const EdgeInsets.symmetric(
                    //             vertical: 16,
                    //           ),
                    //           shrinkWrap: true,
                    //           children: const [
                    //             ListTile(
                    //               leading: Icon(Icons.edit),
                    //               title: Text('Edit'),
                    //             ),
                    //             ListTile(
                    //               leading: Icon(Icons.delete),
                    //               title: Text('Delete'),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   icon: const Icon(
                    //     Icons.more_vert,
                    //   ),
                    // )
                  ],
                ),
              ),
              Container(
                // Set the container size and decoration
                // width: 500,
                // height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://w.forfun.com/fetch/f8/f8630c70a089df7390f25558ea609624.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                // Create a ClipRect to apply the frosted glass effect
                child: ClipRect(
                  // Use a BackdropFilter to blur the content
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ), // Adjust the sigma values for desired blur intensity
                    child: Container(
                      color: Colors.grey.shade300.withOpacity(
                        0.3,
                      ), // Adjust the opacity for the glass effect
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Table(
                              border:
                                  TableBorder.all(color: Colors.transparent),
                              columnWidths: const {0: FixedColumnWidth(110)},
                              children: const [
                                TableRow(
                                  children: [
                                    TableCell(
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
                                            '2021-05-20',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'To',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '2021-05-20',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
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
                                            '12:00 PM',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'To',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '12:00 PM',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Add a spacer row with space between rows
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
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
                                      child: Text(
                                        '1000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
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
                                        'Male',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
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
                                        'Gampaha',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                          height:
                                              16), // Adjust the height for spacing
                                    ),
                                  ],
                                ),
                                TableRow(
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
                                      child: Text(
                                        'This is a description of the job post. It can be a bit longer and may go to the next line if needed.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.waving_hand_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_border,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
