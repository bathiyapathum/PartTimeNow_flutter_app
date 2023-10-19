import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parttimenow_flutter/Widgets/search_location_field.dart';
import 'package:parttimenow_flutter/Widgets/show_item_chip.dart';
import 'package:parttimenow_flutter/models/filter_model.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class FilterFeedScreen extends StatefulWidget {
  final Map<String, dynamic> filterStat;
  final Function(Map<String, dynamic>)? callback;
  const FilterFeedScreen({super.key, this.callback, required this.filterStat});

  @override
  State<FilterFeedScreen> createState() => _FilterFeedScreenState();
}

class _FilterFeedScreenState extends State<FilterFeedScreen> {
  int genderQtTurnIndex = 2;
  bool isTapped = false;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool isLocationSelected = false;
  bool isCategorySelected = false;
  bool isPriceSelected = false;
  bool isGenderSelected = false;
  bool openModelCat = false;
  bool openModelLoc = false;

  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  late Function callback;
  late Map<String, dynamic> filterStat;

  @override
  void initState() {
    callback = widget.callback!;
    filterStat = widget.filterStat;
    FilterModel filterModel = FilterModel.fromList(filterStat);

    if (filterModel.male != null) {
      setState(() {
        isMaleSelected = true;
        isGenderSelected = true;
      });
    }
    if (filterModel.female != null) {
      setState(() {
        isFemaleSelected = true;
        isGenderSelected = true;
      });
    }
    if (filterModel.location != null) {
      setState(() {
        location = filterModel.location;
        openModelLoc = true;
        isLocationSelected = true;
      });
    }
    if (filterModel.category != null) {
      setState(() {
        category = filterModel.category;
        openModelCat = true;
        isCategorySelected = true;
      });
    }
    if (filterModel.startSal != null) {
      setState(() {
        values = RangeValues(double.parse(filterModel.startSal!), values.end);
        minController.text = filterModel.startSal!;
        isPriceSelected = true;
      });
    }
    if (filterModel.endSal != null) {
      setState(() {
        values = RangeValues(values.start, double.parse(filterModel.endSal!));
        maxController.text = filterModel.endSal!;
        isPriceSelected = true;
      });
    }
    super.initState();
  }

  String? location;
  String? category;

  void getCategory(String data) {
    setState(() {
      category = data;
      openModelCat = true;
    });
  }

  void getLocation(String data) {
    setState(() {
      location = data;
      openModelLoc = true;
    });
  }

  void openClosedCat(String data) {
    setState(() {
      openModelCat = false;
      category = null;
    });
  }

  void openClosedLoc(String data) {
    setState(() {
      openModelLoc = false;
      location = null;
    });
  }

  void navigateToFeed(context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const MobileScreenLayout(),
    //   ),
    // );
    Navigator.pop(context);
  }

  void hello() {
    logger.d(location);
    logger.d(category);
  }

  void handleDropdown(isSelected) {
    isSelected = !isSelected;
    if (isSelected) {
      setState(() {
        genderQtTurnIndex = 3;
      });
    } else {
      setState(() {
        genderQtTurnIndex = 2;
      });
    }
  }

  void handleMinValue(value) {
    if (int.parse(minController.text.toString()) >
        int.parse(maxController.text.toString())) {
      minController.text = maxController.text.toString();
      values = RangeValues(double.parse(maxController.text), values.end);
      return;
    } else if (int.parse(minController.text.toString()) > 50000) {
      minController.text = "50000";
      return;
    } else {
      values = RangeValues(double.parse(value), values.end);
    }
  }

  void handleMaxValue(value) {
    if (int.parse(minController.text.toString()) >
        int.parse(maxController.text.toString())) {
      maxController.text = minController.text.toString();
      values = RangeValues(values.start, double.parse(maxController.text));
      return;
    } else if (int.parse(maxController.text.toString()) > 50000) {
      maxController.text = "50000";
      return;
    } else {
      values = RangeValues(values.start, double.parse(value));
    }
  }

  RangeValues values = const RangeValues(0, 50000);

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RangeLabels lables = RangeLabels(
      values.start.toInt().toString(),
      values.end.toInt().toString(),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            logger.d(filterStat);
          },
          child: const Text(
            "Filter",
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
                navigateToFeed(context);
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
              onPressed: () {},
              icon: const Icon(
                color: navActivaeColor,
                Icons.notifications,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Filters",
                    style: TextStyle(
                      color: Colors.orange.shade300,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logger.d("clear all");
                    setState(() {
                      isMaleSelected = false;
                      isFemaleSelected = false;
                      isGenderSelected = false;
                      isLocationSelected = false;
                      isCategorySelected = false;
                      isPriceSelected = false;
                      minController.text = "0";
                      maxController.text = "50000";
                      values = const RangeValues(0, 50000);
                      location = null;
                      category = null;
                      openModelCat = false;
                      openModelLoc = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Gender : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isGenderSelected = !isGenderSelected;
                        logger.d("isGenderSelected $isGenderSelected");
                      });
                    },
                    child: RotatedBox(
                      quarterTurns: !isGenderSelected ? 2 : 3,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            isGenderSelected
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMaleSelected = !isMaleSelected;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: isMaleSelected
                              ? BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                )
                              : BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Male",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                isMaleSelected
                                    ? const Icon(
                                        Icons.close_rounded,
                                        color: Colors.orangeAccent,
                                      )
                                    : const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFemaleSelected = !isFemaleSelected;
                            logger.d("isFemaleSelected $isFemaleSelected");
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: isFemaleSelected
                              ? BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                )
                              : BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Female",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                isFemaleSelected
                                    ? const Icon(
                                        Icons.close_rounded,
                                        color: Colors.orangeAccent,
                                      )
                                    : const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Price Range : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPriceSelected = !isPriceSelected;
                      });
                      // handleDropdown(isPriceSelected);
                    },
                    child: RotatedBox(
                      quarterTurns: !isPriceSelected ? 2 : 3,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            isPriceSelected
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                width: 74,
                                child: Text(
                                  "From",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  onChanged: (value) => {
                                    setState(() {
                                      handleMinValue(value);
                                      logger.d("value $value");
                                    })
                                  },
                                  controller: minController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(5),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,6}$')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    labelText: 'Min',
                                    labelStyle: const TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                width: 74,
                                child: Text(
                                  "To",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  onChanged: (value) => {
                                    setState(() {
                                      handleMaxValue(value);
                                      logger.d("value $value");
                                    })
                                  },
                                  controller: maxController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(5),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,6}$')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    labelText: 'Max',
                                    labelStyle: const TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: values,
                        min: 0,
                        max: 50000,
                        divisions: 100,
                        labels: lables,
                        onChanged: (RangeValues newValues) {
                          setState(() {
                            values = newValues;
                            minController.text =
                                newValues.start.toInt().toString();
                            maxController.text =
                                newValues.end.toInt().toString();
                          });
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Location : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLocationSelected = !isLocationSelected;
                      });
                    },
                    child: RotatedBox(
                      quarterTurns: !isLocationSelected ? 2 : 3,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLocationSelected
                    ? SearchLocationField(
                        contentList: locations,
                        callback: getLocation,
                      )
                    : const SizedBox(),
                openModelLoc
                    ? ShowItemChip(
                        selectedItem: location,
                        callback: openClosedLoc,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Category : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCategorySelected = !isCategorySelected;
                      });
                    },
                    child: RotatedBox(
                      quarterTurns: !isCategorySelected ? 2 : 3,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isCategorySelected
                    ? SearchLocationField(
                        contentList: categories,
                        callback: getCategory,
                      )
                    : const SizedBox(),
                openModelCat
                    ? ShowItemChip(
                        selectedItem: category,
                        callback: openClosedCat,
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              onPressed: () {
                // hello();
                Map<String, dynamic> query = {};
                query.putIfAbsent("location", () => location);
                query.putIfAbsent("category", () => category);
                query.putIfAbsent(
                    "startSal", () => values.start.toInt().toString());
                query.putIfAbsent(
                    "endSal", () => values.end.toInt().toString());
                query.putIfAbsent("male", () => isMaleSelected ? 'male' : null);
                query.putIfAbsent(
                    "female", () => isFemaleSelected ? 'female' : null);

                Map<String, dynamic> clear = {};
                clear.putIfAbsent("location", () => null);
                clear.putIfAbsent("category", () => null);
                clear.putIfAbsent("startSal", () => null);
                clear.putIfAbsent("endSal", () => null);
                clear.putIfAbsent("male", () => null);
                clear.putIfAbsent("female", () => null);
                logger.d(query);
                callback(clear);
                callback(query);
                navigateToFeed(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 15,
                ),
                child: Text(
                  "Apply Filters",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
