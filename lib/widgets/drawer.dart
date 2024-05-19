import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/user_provider.dart';
import 'package:test_app/utils/colors.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
    final UserProvider userProvider = Provider.of<UserProvider>(context);
     final user = userProvider.getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: const BoxDecoration(
              color: drawerColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl),
                radius: 45,
              ),
              const SizedBox(height: 20,),
               Text(user.email)],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info,color:blueColor),
            title: const Text('Info',style: TextStyle(color: blueColor),),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.school,color: blueColor,),
            title: const Text('Campus',style: TextStyle(color: blueColor),),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading:const Icon(Icons.house,color:blueColor),
            title: const Text('Club',style: TextStyle(color:blueColor),),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard,color:blueColor,),
            title: const Text('Committee',style: TextStyle(color: blueColor),),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings,color: blueColor,),
            title: const Text('Settings',style: TextStyle(color: blueColor),),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
