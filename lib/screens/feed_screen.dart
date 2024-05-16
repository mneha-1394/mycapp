import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/user_provider.dart';
import 'package:test_app/utils/colors.dart';
import 'package:test_app/utils/dimension.dart';
import 'package:test_app/widgets/drawer.dart';

import '../model/user.dart';
class Feedscreen extends StatefulWidget {
  const Feedscreen({super.key});

  @override
  State<Feedscreen> createState() => _FeedscreenState();
}

class _FeedscreenState extends State<Feedscreen> {

  @override
  void initState() {
    super.initState();
    _refreshUserData();
  }
  void _refreshUserData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context);
     final user = userProvider.getUser;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
    backgroundColor: width > webScreenSize ? secondaryColor : primaryColor,
      appBar:  AppBar(
          title: Image.asset('assets/2.png', height: 120, width: 120),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: primaryColor),
        ),
         endDrawer: const DrawerScreen(),
      body: user==null ? Center(child: CircularProgressIndicator(),): Text("No Concerns Yet",style: TextStyle(fontSize: 40),),
    );
  }
}