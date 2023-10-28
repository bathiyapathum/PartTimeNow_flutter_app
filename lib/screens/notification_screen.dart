import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/not_card.dart';
import 'package:parttimenow_flutter/Widgets/notification_card.dart';
import 'package:parttimenow_flutter/Widgets/shimmer_post_card.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  final List notificationsList;
   
  const NotificationScreen({Key? key,this.notificationsList = const [1,2,3,4,5,6] }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List notificationsList = [1,2,3,4,5,6];

 @override
  void initState() {
    notificationsList = widget.notificationsList;
    super.initState();
    // Fetch user data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: const ShrimmerPostCard(),
              ),
            );
          }
          if (!snapshot.hasData || (snapshot.data != null && snapshot.data!.docs.isEmpty)) {
            return const Center(
              child: Text(
                "No Data",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                // You can customize the data or use different widgets here
                if (index % 2 == 0) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: NotificationCard(NotificationType: 'request'),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: NotCard(NotificationType: ''),
                  );
                }
              },
            );
          }
          return ListView.builder(
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: const ShrimmerPostCard(),
            ),
          );
        },
      ),
    );
  }
}
