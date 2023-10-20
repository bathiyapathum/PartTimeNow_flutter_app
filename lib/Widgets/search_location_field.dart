import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class SearchLocationField extends StatefulWidget {
  final List contentList;
  final Function(String)? callback;
  final double fieldWidth;
  

  const SearchLocationField(
      {super.key, required this.contentList, this.callback, this.fieldWidth = 0.4});

  @override
  State<SearchLocationField> createState() => _SearchLocationFieldState();
}

class _SearchLocationFieldState extends State<SearchLocationField> {
  String? _selectedItem;
  late double _fieldWidth = 0.4;
  final TextEditingController _searchTextController = TextEditingController();
  late List data;
  late Function callback;

  @override
  void initState() {
    data = widget.contentList;
    callback = widget.callback!;
    _fieldWidth = widget.fieldWidth;
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
                width: MediaQuery.of(context).size.width * _fieldWidth,
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
                          child: Container(
                            width: MediaQuery.of(context).size.width * _fieldWidth,
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
    );
  }
}
