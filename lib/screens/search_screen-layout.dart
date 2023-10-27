import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class SearchScreenLayout extends StatefulWidget {
  const SearchScreenLayout({super.key});

  @override
  State<SearchScreenLayout> createState() => _SearchScreenLayoutState();
}

class _SearchScreenLayoutState extends State<SearchScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('Search'),
      ),
    );
  }
}
