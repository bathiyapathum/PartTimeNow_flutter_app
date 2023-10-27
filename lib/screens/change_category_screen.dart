import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/category_item_chip.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class ChangeCategoryScreen extends StatefulWidget {
  final List selectedCategory;
  const ChangeCategoryScreen({super.key, this.selectedCategory = const []});

  @override
  State<ChangeCategoryScreen> createState() => _ChangeCategoryScreenState();
}

class _ChangeCategoryScreenState extends State<ChangeCategoryScreen> {
  late List category = [];
  List selectedCategory = [];

  @override
  void initState() {
    categoryIcons.forEach((key, value) {
      category.add(
        IconStringComb(
          key: key,
          icon: value,
        ),
      );
      selectedCategory = widget.selectedCategory;    
    });
    super.initState();
  }


  void _onSelected(String item) {
    setState(() {
      selectedCategory.contains(item)
          ? selectedCategory.remove(item)
          : selectedCategory.add(item);
    });
    logger.d(selectedCategory);
  }

  Iterable<Widget> get categoryItems sync* {
    for (IconStringComb item in category) {
      yield CategoryItemChip(
        selectedItem: item.key,
        callback: _onSelected,
        iconvar: item.icon,
        isContain: false,
        selectedCategoryList: selectedCategory,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star_border_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Select your Interests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          SizedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              margin: const EdgeInsets.only(top: 15),
              width: 95,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0.5),
                ),
                onPressed: () {
                  if (selectedCategory.isNotEmpty &&
                      selectedCategory.length <= 3) {

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(AuthMethod().currentUser?.uid)
                          .update({
                        'categories': selectedCategory,
                      });
                          

                    Navigator.of(context).pop();
                  } else if (selectedCategory.length > 3) {
                    showSnackBar(
                        "Maximum you can select three category only", context);
                  } else {
                    showSnackBar(
                        "Please select at least one category", context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1,
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 5.0,
                runSpacing: 8,
                children: <Widget>[
                  ...categoryItems,
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class IconStringComb {
  String? key;
  IconData? icon;
  IconStringComb({this.key, this.icon});
}
