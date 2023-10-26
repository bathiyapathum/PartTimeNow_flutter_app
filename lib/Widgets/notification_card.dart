// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    // FilterModel filterModel = FilterModel.fromList(filteredData);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            // logger.d(filterModel.category);
            // logger.d(filterModel.location);
            // logger.d(filterModel.male);
            // logger.d(filterModel.female);
            // logger.d(filterModel.startSal);
            // logger.d(filterModel.endSal);
          },
          child: const Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Card(
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.white,
            child: IconButton(
              onPressed: () {
                // navigateToFilter(context);
                // showDialog(context: context);
              },
              icon: const Icon(
                color: navActivaeColor,
                Icons.format_indent_increase_outlined,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Card(
            margin: const EdgeInsets.only(right: 10),
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.white,
            child: IconButton(
              onPressed: () {
                // navigateToSearch(context);
                // showShrim(context: context);
              },
              icon: const Icon(
                color: navActivaeColor,
                Icons.notifications,
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 223, 223, 223),
        ),
        child: ListView(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 7,
              ),
              // elevation:20,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 7, top: 10, bottom: 10),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: navActivaeColor,
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Perara Dilshan Dinal',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 10),
                        constraints: const BoxConstraints(maxWidth: 370),
                        padding: const EdgeInsets.only(
                            left: 10, right: 7, top: 10, bottom: 10),
                        child: const Text(
                          'You have been selected for the job fwvdfv efwvfv  wevfwv  ewfvev  wefve',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 8, bottom: 10),
                        constraints: const BoxConstraints(maxWidth: 170),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: const Center(
                              child: Text(
                                'Reject',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 10),
                        constraints: const BoxConstraints(maxWidth: 170),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.green,
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: const Center(
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
    );
  }
}
