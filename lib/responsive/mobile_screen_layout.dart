import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  } 
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        bottomNavigationBar: CupertinoTabBar(    
          height: 80,  
          activeColor: navActivaeColor,    
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                size: 40,
                Icons.home_outlined,
                color: _page == 0 ? navActivaeColor :primaryColor ,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                size: 40,
                Icons.search,
                color: _page == 1 ? navActivaeColor :primaryColor ,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                size: 40,
                Icons.add_box_outlined,
                color: _page == 2 ? navActivaeColor :primaryColor ,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                size: 40,
                Icons.chat_bubble_outline,
                color: _page == 3 ? navActivaeColor :primaryColor ,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                size: 40,
                Icons.menu,
                color: _page == 4 ? navActivaeColor :primaryColor ,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          backgroundColor: mobileAppBackgroundColor,
          onTap: navigationTapped ,
        ));
  }
}
