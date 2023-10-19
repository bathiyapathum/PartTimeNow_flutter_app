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
        padding: const EdgeInsets.only(top: 10),
        child: CupertinoTabBar(
          border: null,
          height: 55,
          activeColor: navActivaeColor,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _page == 0
                      ? navActivaeColor
                      : primaryColor, // Define your condition here
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/home.svg',
                ),
              ),
              label: 'Home',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _page == 1 ? navActivaeColor : primaryColor,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/search.svg',
                ),
              ),
              label: 'Search',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _page == 2 ? navActivaeColor : primaryColor,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/add.svg',
                ),
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _page == 3 ? navActivaeColor : primaryColor,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/chat.svg',
                ),
              ),
              label: 'Chat',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _page == 4 ? navActivaeColor : primaryColor,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/menu.svg',
                ),
              ),
              label: 'Menu',
              backgroundColor: primaryColor,
            ),
          ],
          backgroundColor: mobileAppBackgroundColor,
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
