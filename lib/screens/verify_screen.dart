import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/utils/utils.dart';
import 'dart:async';
import '/screens/create_profile_screen.dart';
import '../utils/colors.dart';

class VerfiyScreen extends StatefulWidget {
  const VerfiyScreen({super.key});

  @override
  State<VerfiyScreen> createState() => _VerfiyScreenState();
}

class _VerfiyScreenState extends State<VerfiyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  bool _isLoading = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  void resendemail() async {
    await FirebaseAuth.instance.currentUser?.reload();
    _auth.currentUser!.sendEmailVerification();
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      _isLoading = true;
    });
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, "Email verified!!");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
        );
        timer?.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Center(
              child: Column(
                children: [
                  Flexible(flex: 1, child: Container()),
                  SizedBox(
                    child: Image.asset(
                      'assets/4.png',
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Check your Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: secondaryColor, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: Text(
                        'We have sent you a Email on  ${_auth.currentUser?.email}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: iconColor,
                        ))
                      : const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Center(
                            child: Text(
                              'Verifying email....',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  const SizedBox(height: 57),
                  InkWell(
                    onTap: resendemail,
                    child: Container(
                        width: 150, //change this for web
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 1),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1))),
                          color: blueColor,
                        ),
                        child: const Text(
                          'Resend ',
                          style: TextStyle(color: primaryColor, fontSize: 17),
                        )),
                  ),
                  Flexible(flex: 1, child: Container()),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.green),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
                label: '')
          ],
          backgroundColor: Colors.green,
        ));
  }
}
