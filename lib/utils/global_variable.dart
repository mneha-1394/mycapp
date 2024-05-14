import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screens/add_concern.dart';
import 'package:test_app/screens/feed_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String uid=_auth.currentUser!.uid;
List<Widget> homeScreenItems = [
   const Feedscreen(),
   const Text('Search Screen'),
  const AddConcernScreen(),
  const Text('notifications'),
   const Text('Profile Screen')
];