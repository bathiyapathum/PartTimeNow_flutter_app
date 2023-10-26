import 'package:flutter/material.dart';

class ShowItemChip extends StatefulWidget {
  final String? selectedItem;
  final Function(String)? callback;
  final double boxWidth;
  const ShowItemChip(
      {Key? key,
      required this.selectedItem,
      this.callback,
      this.boxWidth = 0.25})
      : super(key: key);

  @override
  State<ShowItemChip> createState() => _ShowItemChipState();
}

class _ShowItemChipState extends State<ShowItemChip> {
  late String? selectedItem;
  Function? callback;
  double _boxWidth = 0.25;
  @override
  void initState() {
    selectedItem = widget.selectedItem;
    callback = widget.callback;
    _boxWidth = widget.boxWidth;
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
          child: selectedItem != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedItem == null
                          ? const Text(
                              'Please select a Location',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blueGrey),
                            )
                          : SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * _boxWidth,
                              child: Text(
                                selectedItem!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            callback!(selectedItem);
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
