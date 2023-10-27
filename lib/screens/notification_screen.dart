import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/notification_card.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'PartTimeNow',
          style: TextStyle(
            color: signInBtn,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        // title: Card(
        //   elevation: 0,
        //   shape: const CircleBorder(),
        //   color: Colors.white,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       color: navActivaeColor,
        //       Icons.format_indent_increase_outlined,
        //     ),
        //   ),
        // ),
        actions: [
          Card(
            margin: const EdgeInsets.only(right: 10),
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.white,
            child: IconButton(
              onPressed: () {},
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
          // image: DecorationImage(
          //   image: AssetImage(
          //     'assets/background.jpg',
          //   ),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 5,
                ),
                child: const NotificationCard(),
              ),
            );
          },
        ),
      ),
    );
  }
}
