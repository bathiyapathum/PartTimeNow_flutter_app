import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parttimenow_flutter/Widgets/post_card.dart';
import 'package:parttimenow_flutter/Widgets/shimmer_post_card.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class SearchScreenLayout extends StatefulWidget {
  const SearchScreenLayout({Key? key}) : super(key: key);

  @override
  State<SearchScreenLayout> createState() => _SearchScreenLayoutState();
}

class _SearchScreenLayoutState extends State<SearchScreenLayout> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _postsStream;

  @override
  void initState() {
    super.initState();
    _postsStream = FirebaseFirestore.instance.collection('posts').snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Update the stream query based on the search text
                    setState(() {
                      _postsStream = FirebaseFirestore.instance
                          .collection('posts')
                          .where('userName', isLessThan: value + 'z')
                          .where('userName', isGreaterThanOrEqualTo: value)
                          .snapshots();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _postsStream = FirebaseFirestore.instance
                        .collection('posts')
                        .where('userName', isEqualTo: _searchController.text)
                        .snapshots();
                  });
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 15.0),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _postsStream,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 2,
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: 2,
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
