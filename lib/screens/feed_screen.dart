import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/user_provider.dart';
import 'package:test_app/utils/colors.dart';
import 'package:test_app/utils/dimension.dart';
import 'package:test_app/widgets/drawer.dart';
import '../widgets/post_card.dart';
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
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? secondaryColor : primaryColor,
      appBar:  AppBar(
          title: Image.asset('assets/2.png', height: 120, width: 120),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: primaryColor),
        ),
         endDrawer: const DrawerScreen(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(!snapshot.hasData||snapshot.data!.docs.isEmpty){
             return const Center(
                child:  Text("No concern Yet")
             );
          } 
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}