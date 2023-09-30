import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/Widgets/search_location_field.dart';
import 'package:parttimenow_flutter/utils/global_variable.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchLocationField(contentList: locations,)
      );
  }
}