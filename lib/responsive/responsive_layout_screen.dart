import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/dimenstions.dart';

class ResponsiveLyout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLyout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints){
        if(constraints.maxWidth > webScreenSize){
          //web screen
          return webScreenLayout;
        }
        //mobile screen
        return mobileScreenLayout;
      },
    );
  }
}