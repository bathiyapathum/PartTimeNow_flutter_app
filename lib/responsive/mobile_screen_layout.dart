import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          child: CupertinoTabBar(
            border: null,
            height: 55,
            activeColor: navActivaeColor,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/home.svg',
                  color: _page == 0 ? navActivaeColor : primaryColor,
                ),
                label: 'Home',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/search.svg',
                  color: _page == 1 ? navActivaeColor : primaryColor,
                ),
                label: 'Search',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/add.svg',
                  color: _page == 2 ? navActivaeColor : primaryColor,
                ),
                label: '',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/chat.svg',
                  color: _page == 3 ? navActivaeColor : primaryColor,
                ),
                label: 'Chat',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/menu.svg',
                  color: _page == 4 ? navActivaeColor : primaryColor,
                ),
                label: 'Menu',
                backgroundColor: primaryColor,
              ),
            ],
            backgroundColor: mobileAppBackgroundColor,
            onTap: navigationTapped,
          ),
        ));
  }
}
