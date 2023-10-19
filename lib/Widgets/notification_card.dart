import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        color: Colors.white,
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),
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
                            SizedBox(width: 1),
                            // Adjust the spacing between the icon and text
                            Text(
                              '2h. ago',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 103, 103, 103),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.access_time,
                              size: 14, // Adjust the size as needed
                              color: Color.fromARGB(255, 103, 103, 103),
                            ),
                          ],
                        ),
                        Text(
                          'cdascasdcasd sdcdsac dscasd sdcadsc scasd sdcdas dvcads sdcsd sdc',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Or TextOverflow.fade or TextOverflow.visible
                          maxLines: 3, // Adjust the maximum number of lines
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
