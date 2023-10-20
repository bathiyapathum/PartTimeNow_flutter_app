import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/feedback_card.dart';
import 'package:parttimenow_flutter/Widgets/post_card.dart';
import 'package:parttimenow_flutter/Widgets/shimmer_post_card.dart';
import 'package:parttimenow_flutter/models/filter_model.dart';
import 'package:parttimenow_flutter/screens/filter_feed_screen.dart';
import 'package:parttimenow_flutter/screens/select_location_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class FeedbackScreenLayout extends StatefulWidget {
  final String feedbackUserId;
  const FeedbackScreenLayout({super.key, required this.feedbackUserId});

  @override
  State<FeedbackScreenLayout> createState() => _FeedbackScreenLayoutState();
}

class _FeedbackScreenLayoutState extends State<FeedbackScreenLayout> {
  Map<String, dynamic> filteredData = {};
  String gender = "male";
  String postUserId = "";
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

  @override
  void initState() {
    super.initState();
    postUserId = widget.feedbackUserId;
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
        builder: (context) => const ShrimmerPostCard(),
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
    FilterModel filterModel = FilterModel.fromList(filteredData);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            logger.d(filterModel.category);
            logger.d(filterModel.location);
            logger.d(filterModel.male);
            logger.d(filterModel.female);
            logger.d(filterModel.startSal);
            logger.d(filterModel.endSal);
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
                showDialog(context: context);
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
                showShrim(context: context);
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
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .where("feedbackReceiverId", isEqualTo: postUserId)
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
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: FeedbackCard(
                  snap: snapshot.data!.docs[index].data(),
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
