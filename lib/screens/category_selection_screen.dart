import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/category_item_chip.dart';
import 'package:parttimenow_flutter/screens/location_selection_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late List category = [];
  List<String> selectedCategory = [];

  @override
  void initState() {
    categoryIcons.forEach((key, value) {
      category.add(
        IconStringComb(
          key: key,
          icon: value,
        ),
      );
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
              width: 90,
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
                  if (selectedCategory.isNotEmpty &&
                      selectedCategory.length <= 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationSelectionScreen(
                            selectedCategory: selectedCategory),
                      ),
                    );
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
                    horizontal: 2,
                  ),
                  child: Text(
                    "Next",
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
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
