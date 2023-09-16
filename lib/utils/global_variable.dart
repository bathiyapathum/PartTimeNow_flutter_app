import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/screens/feed_screen_layout.dart';
import 'package:parttimenow_flutter/screens/menue_screen_layout.dart';

const mobileScreenSize = 600;
const webScreenSize = 600;

const homeScreenItems = [
  FeedScreenLayout(),
  Text('Search'),
  Text('Add'),
  Text('Message'),
  MenueScreen(),
];
