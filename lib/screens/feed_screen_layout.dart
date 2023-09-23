import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/post_card.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class FeedScreenLayout extends StatelessWidget {
  const FeedScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Card(
          elevation: 0,
          shape: const CircleBorder(),
          color: Colors.white,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              color: navActivaeColor,
              Icons.format_indent_increase_outlined,
            ),
          ),
        ),
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
          image: DecorationImage(
            image: AssetImage(
              '',
            ),
            fit: BoxFit.cover,
          ),
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
                  horizontal: 10,
                  vertical: 10,
                ),
                child: const PostCard(),
              ),
            );
          },
        ),
      ),
    );
  }
}
