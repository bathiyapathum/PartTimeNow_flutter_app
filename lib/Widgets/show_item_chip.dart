import 'package:flutter/material.dart';

class ShowItemChip extends StatefulWidget {
  final String? selectedItem;
  final Function(String)? callback;
  const ShowItemChip({super.key, required this.selectedItem, this.callback});

  @override
  State<ShowItemChip> createState() => _ShowItemChipState();
}

class _ShowItemChipState extends State<ShowItemChip> {
  String? _selectedItem = 'dd';
  Function? callback;
  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    callback = widget.callback;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: _selectedItem != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedItem == null
                              ? const Text(
                                  'Please select a Location',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    _selectedItem!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                callback!(_selectedItem);
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.orangeAccent,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        );
  }
}