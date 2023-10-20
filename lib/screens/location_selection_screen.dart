// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/search_location_field.dart';
import 'package:parttimenow_flutter/Widgets/show_item_chip.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/resources/firestore_methods.dart';
import 'package:parttimenow_flutter/responsive/mobile_screen_layout.dart';
import 'package:parttimenow_flutter/responsive/responsive.dart';
import 'package:parttimenow_flutter/responsive/web_screen_layout.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class LocationSelectionScreen extends StatefulWidget {
  final List selectedCategory;
  LocationSelectionScreen({super.key, required this.selectedCategory});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

void callbk(String nm) {
  logger.d(nm);
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? _location;
  bool openModelLoc = false;
  bool isSelected = false;

  void openClosedLoc(String data) {
    setState(() {
      openModelLoc = false;
      _location = null;
    });
  }

  void updateUserPref(uId, location, categories) {
    FireStoreMethods().updateUserPref(uId, location, categories);
  }

  void navgateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ),
    );
  }

  Widget refreshSelection(String? location, Function(String)? openClosedLoc) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        openModelLoc
            ? ShowItemChip(
                selectedItem: location,
                callback: openClosedLoc,
                boxWidth: 0.35,
              )
            : const SizedBox(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: const Text('Select Location'),
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          SizedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  logger.d(_location);
                  updateUserPref(AuthMethod().currentUser?.uid, _location,
                      widget.selectedCategory);
                  navgateToHome();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  child: Text(
                    "Finish",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage('assets/location.png'),
                  color: Colors.white,
                  height: 200,
                  width: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    openModelLoc
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              openModelLoc
                                  ? ShowItemChip(
                                      selectedItem: _location,
                                      callback: openClosedLoc,
                                      boxWidth: 0.35,
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                _location != 'car'
                    ? SearchLocationField(
                        contentList: locations,
                        callback: (String nm) {
                          setState(() {
                            logger.e(nm);
                            _location = nm;
                            openModelLoc = true;
                          });
                        },
                        fieldWidth: 0.8)
                    : SizedBox(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
