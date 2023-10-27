import 'package:flutter/material.dart';

class CategoryItemChip extends StatefulWidget {
  final String? selectedItem;
  final Function(String)? callback;
  final IconData? iconvar;
  final bool isContain;
  final List selectedCategoryList;
  const CategoryItemChip({
    super.key,
    required this.selectedItem,
    this.callback,
    this.iconvar,
    this.isContain = false,
    this.selectedCategoryList = const [],
  });

  @override
  State<CategoryItemChip> createState() => _CategoryItemChipState();
}

class _CategoryItemChipState extends State<CategoryItemChip> {
  String? _selectedItem;
  bool isSelect = false;
  bool isContain = false;
  List selectedCategoryList = [];
  Function(String)? callback;
  IconData? iconvar = Icons.location_on;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    callback = widget.callback;
    iconvar = widget.iconvar;
    isContain = widget.isContain;
    selectedCategoryList = widget.selectedCategoryList;
    if (selectedCategoryList.contains(_selectedItem)) {
      isSelect = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isSelect = !isSelect;
              if (isSelect) {
                callback!(_selectedItem!);
              } else {
                callback!(_selectedItem!);
              }
            });
          },
          child: _selectedItem != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelect || isContain
                        ? const Color.fromARGB(255, 252, 84, 23)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              iconvar,
                              color: isSelect || isContain
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                      Flexible(
                        child: _selectedItem == null
                            ? const Text(
                                'Something went wrong',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey),
                              )
                            : SizedBox(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  _selectedItem!,
                                  style: TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontSize: 14,
                                    color: !isSelect || isContain
                                        ? Colors.grey.shade800
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
