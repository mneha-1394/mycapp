import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:provider/provider.dart';
import 'package:test_app/responsive/mobile_screen_layout.dart';
import 'package:test_app/responsive/responsive_layout.dart';
import 'package:test_app/responsive/web_screen_layout.dart';
import 'package:test_app/screens/login_screen.dart';
import 'package:test_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/user_provider.dart';


void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDnyd7chHKtslVR_KVEVRi49s_My-_DW9w',
          appId: '1:805447398223:android:32dab95c7a457ed3b68b3a',
          messagingSenderId: '805447398223',
          storageBucket: "mycapp-77ad9.appspot.com",
          projectId: 'mycapp-77ad9'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Raise Your Concern',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: primaryColor,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // Checking if the snapshot has any data or not
                if (snapshot.hasData) {
                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
        
              // means connection to future hasnt been made yet
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
        
              return const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}