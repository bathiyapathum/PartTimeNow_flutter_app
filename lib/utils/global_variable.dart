import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/screens/feed_screen_layout.dart';
import 'package:parttimenow_flutter/screens/feedback_screen.dart';
import 'package:parttimenow_flutter/screens/menue_screen_layout.dart';
import 'package:parttimenow_flutter/screens/post_job_screen.dart';

const mobileScreenSize = 600;
const webScreenSize = 600;

const homeScreenItems = [
  FeedScreenLayout(),
  Text('Search'),
  PostJobScreen(),
  // Text('Message')
  FeedbackScreen(), // this is temporary for testing
  MenueScreen(),
];
