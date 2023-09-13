import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/responsive/mobile_screen_layout.dart';
import 'package:parttimenow_flutter/responsive/responsive_layout_screen.dart';
import 'package:parttimenow_flutter/responsive/web_screen_layout.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const  ResponsiveLyout(mobileScreenLayout: MobileScreenLayout(),
       webScreenLayout: WebScreenLayout(),
       ),
    );
  }
}
