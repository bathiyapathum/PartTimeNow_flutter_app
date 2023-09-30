import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/post_card.dart';
import 'package:parttimenow_flutter/screens/filter_feed_screen.dart';
import 'package:parttimenow_flutter/screens/select_location_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class FeedScreenLayout extends StatelessWidget {
  const FeedScreenLayout({super.key});

  void navigateToFilter(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FilterFeedScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Card(
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.white,
            child: IconButton(
              onPressed: () {
                navigateToFilter(context);
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
                navigateToSearch(context);
              },
              icon: const Icon(
                color: navActivaeColor,
                Icons.notifications,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
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
                horizontal: 10,
                vertical: 10,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
