import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class SearchLocationField extends StatefulWidget {
  final List contentList;
  final Function(String)? callback;

  const SearchLocationField(
      {super.key, required this.contentList, this.callback});

  @override
  State<SearchLocationField> createState() => _SearchLocationFieldState();
}

class _SearchLocationFieldState extends State<SearchLocationField> {
  String? _selectedItem;
  final TextEditingController _searchTextController = TextEditingController();
  late List data;
  late Function callback;

  @override
  void initState() {
    data = widget.contentList;
    callback = widget.callback!;
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SearchField(
                    controller: _searchTextController,
                    hint: 'Search',
                    maxSuggestionsInViewPort: 3,
                    itemHeight: 50,
                    searchStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                    searchInputDecoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey.shade200,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue.withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    onSuggestionTap: (SearchFieldListItem<String> x) {
                      setState(() {
                        _selectedItem = x.searchKey;
                        _searchTextController.text = '';
                        callback(_selectedItem);
                      });
                      FocusScope.of(context).unfocus();
                    },
                    suggestions: data
                        .map(
                          (e) => SearchFieldListItem<String>(
                            e,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    suggestionItemDecoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black87,
                          width: 0.5,
                        ),
                        left: BorderSide(
                          color: Colors.black87,
                          width: 0.5,
                        ),
                        right: BorderSide(
                          color: Colors.black87,
                          width: 0.5,
                        ),
                      ),
                    ),
                    suggestionsDecoration: SuggestionDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
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
                                _selectedItem = null;
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
        ),
      ],
    );
  }
}
