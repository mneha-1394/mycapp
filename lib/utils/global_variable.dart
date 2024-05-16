import 'package:flutter/material.dart';
import 'package:test_app/screens/add_concern.dart';
import 'package:test_app/screens/feed_screen.dart';
import 'package:test_app/screens/search_screen.dart';
List<Widget> homeScreenItems = [
   const Feedscreen(),
  const SearchScreen(),
  const AddConcernScreen(),
  const Text('notifications'),
   const Text('Profile Screen')
];