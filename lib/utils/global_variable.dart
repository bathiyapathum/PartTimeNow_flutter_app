import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/screens/chat_home_page.dart';
import 'package:parttimenow_flutter/screens/feed_screen_layout.dart';
// import 'package:parttimenow_flutter/screens/feedback_screen.dart';
import 'package:parttimenow_flutter/screens/menue_screen_layout.dart';
// import 'package:parttimenow_flutter/screens/post_a_job.dart';
import 'package:parttimenow_flutter/screens/post_job_screen.dart';

// import 'package:parttimenow_flutter/screens/post_a_job.dart';

const mobileScreenSize = 600;
const webScreenSize = 600;

const homeScreenItems = [
  FeedScreenLayout(),
  Text('Search'),
  PostJobScreen(),
  // FeedbackScreen(), // this is temporary for testing,
  // JobPostingPage(),
  ChatHomePage(),
  MenueScreen(),
];

const categories = [
  'Sales',
  'Retail',
  'Software Engineering',
  'Accounting',
  'Marketing',
  'Human Resources',
  'Customer Service',
  'Distribution',
  'Healthcare',
  'Education',
  'Hospitality',
  'Manufacturing',
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

const categoryIcons = {
  'Software Engineering': Icons.computer_rounded,
  'Sales': Icons.shopping_bag,
  'Accounting': Icons.account_balance,
  'Marketing': Icons.mark_email_read,
  'Human Resources': Icons.people,
  'Distribution': Icons.delivery_dining,
  'Customer Service': Icons.support_agent,
  'Healthcare': Icons.medical_services,
  'Education': Icons.school,
  'Hospitality': Icons.hotel,
  'Manufacturing': Icons.build,
  'Retail': Icons.shopping_cart,
  'Security': Icons.security,
  'Plumber': Icons.plumbing,
  'Electrician': Icons.electrical_services,
  'Carpenter': Icons.construction,
  'Mason': Icons.handyman,
  'Painter': Icons.format_paint,
  'Welder': Icons.precision_manufacturing,
  'Singer': Icons.mic,
  'Actor': Icons.theater_comedy,
  'Musician': Icons.music_note,
};
