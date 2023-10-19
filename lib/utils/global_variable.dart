import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/screens/feed_screen_layout.dart';
import 'package:parttimenow_flutter/screens/menue_screen_layout.dart';
import 'package:logger/logger.dart';

const mobileScreenSize = 600;
const webScreenSize = 600;
final logger = Logger();

const homeScreenItems = [
  FeedScreenLayout(),
  Text('Search'),
  Text('Add'),
  Text('Message'),
  MenueScreen(),
];
