import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screens/add_concern.dart';
import 'package:test_app/screens/feed_screen.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/search_screen.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
String uid=_auth.currentUser!.uid;
List<Widget> homeScreenItems = [
   const Feedscreen(),
  const SearchScreen(),
  const AddConcernScreen(),
  const Text('notifications'),
  ProfileScreen(uid: uid),
];