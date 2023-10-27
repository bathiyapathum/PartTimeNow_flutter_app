import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/post_card.dart';
import 'package:parttimenow_flutter/Widgets/shimmer_post_card.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/filter_feed_screen.dart';
import 'package:parttimenow_flutter/screens/notification_screen.dart';
import 'package:parttimenow_flutter/screens/select_location_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  Map<String, dynamic> filteredData = {};
  String gender = "male";

  void navigateToFilter(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FilterFeedScreen(
          callback: getLocation,
          filterStat: filteredData,
        ),
      ),
    );
  }

  void navigateToSearch(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SelectLocationScreen(),
      ),
    );
  }

  void showDialog({
    required context,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
          child: FilterFeedScreen(
            callback: getLocation,
            filterStat: filteredData,
          ),
        );
      },
    );
  }

  void showShrim({
    required context,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        // builder: (context) => const CategorySelectionScreen(),

        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void getLocation(Map<String, dynamic> data) {
    setState(() {
      filteredData = data;
    });
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
          "Saved Posts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('saved', arrayContains: AuthMethod().currentUser?.uid)            
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
          if (!snapshot.hasData ||
              snapshot.data != null && snapshot.data!.docs.isEmpty) {
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
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: PostCard(
                  snap: snapshot.data?.docs[index].data(),
                ),
              ),
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
