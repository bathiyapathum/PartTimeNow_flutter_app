// import 'package:flutter/material.dart';
// import 'package:parttimenow_flutter/Widgets/feedback_card.dart';
// import 'package:parttimenow_flutter/screens/chat_home_page.dart';
import 'package:parttimenow_flutter/screens/feed_screen_layout.dart';
import 'package:parttimenow_flutter/screens/feedback_screen.dart';
import 'package:parttimenow_flutter/screens/feedback_screen_layout.dart';
import 'package:parttimenow_flutter/screens/menue_screen_layout.dart';
import 'package:logger/logger.dart';

import 'package:parttimenow_flutter/screens/post_job_screen.dart';


const mobileScreenSize = 600;
const webScreenSize = 600;
final logger = Logger();

const homeScreenItems = [
  FeedScreenLayout(),
  FeedbackScreenLayout(feedbackUserId: ""), // Text('Search'),
  PostJobScreen(),
  FeedbackScreen(
    postID: '123',
  ), // this is temporary for testing,
  // JobPostingPage(),
  // ChatHomePage(),
  MenueScreen(),
];

const categories = [
  'Software Engineering',
  'Accounting',
  'Marketing',
  'Sales',
  'Human Resources',
  'Customer Service',
  'Distribution',
  'Healthcare',
  'Education',
  'Hospitality',
  'Manufacturing',
  'Retail',
  'Security',
];
const locations = [
  'Ampara',
  'Anuradhapura',
  'Badulla',
  'Batticaloa',
  'Colombo',
  'Galle',
  'Gampaha',
  'Hambantota',
  'Jaffna',
  'Kalutara',
  'Kandy',
  'Kegalle',
  'Kilinochchi',
  'Kurunegala',
  'Mannar',
  'Matale',
  'Matara',
  'Moneragala',
  'Mullaitivu',
  'Nuwara Eliya',
  'Polonnaruwa',
  'Puttalam',
  'Ratnapura',
  'Trincomalee',
  'Vavuniya',
];
