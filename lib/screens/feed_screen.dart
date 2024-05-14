import 'package:flutter/material.dart';
import 'package:test_app/utils/colors.dart';
import 'package:test_app/utils/dimension.dart';
class Feedscreen extends StatefulWidget {
  const Feedscreen({super.key});

  @override
  State<Feedscreen> createState() => _FeedscreenState();
}

class _FeedscreenState extends State<Feedscreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
    backgroundColor: width > webScreenSize ? secondaryColor : primaryColor,
      appBar:  AppBar(
          title: Image.asset('assets/2.png', height: 120, width: 120),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: primaryColor),
        ),
         endDrawer: const Drawer(),
      
    );
  }
}