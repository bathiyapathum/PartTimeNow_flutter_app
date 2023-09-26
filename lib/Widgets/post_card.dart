import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: postUserNameColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                    )
                  ],
                ),
              ),
              Container(
                color: postCardbackgroundColor,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Table(
                    border: TableBorder.all(color: Colors.transparent),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                height: 16), // Adjust the height for spacing
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 16), // Adjust the height for spacing
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                height: 16), // Adjust the height for spacing
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 16), // Adjust the height for spacing
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
                                height: 16), // Adjust the height for spacing
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 16), // Adjust the height for spacing
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
                                height: 16), // Adjust the height for spacing
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 16), // Adjust the height for spacing
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
                                height: 16), // Adjust the height for spacing
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 16), // Adjust the height for spacing
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
              ),
              Row(
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
                          Icons.message_outlined,
                          color: Colors.black,
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
