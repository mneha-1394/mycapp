import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/utils/utils.dart';
import '/screens/login_screen.dart';
import '/utils/colors.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String errorMessage = '';
    void resetpassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      showSnackBar(context, "A password reset link has been sent to your email");
      if(context.mounted){
      Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/4.png',
              color: secondaryColor,
            ),
            const SizedBox(height: 40),
            const SizedBox(
              child: Text(
                'Enter the email address associated with your account and we will send you a link to reset your password ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: iconColor,
                  ),
                  suffixIcon: Icon(
                    Icons.edit,
                    color: iconColor,
                  ),
                  hintText: "Enter Your Email",
                  border: OutlineInputBorder(),
                  filled: false,
                  contentPadding: EdgeInsets.all(8)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: resetpassword,
              child: Container(
                  width: 150, //change this for web
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1))),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Reset',
                          style: TextStyle(color: primaryColor, fontSize: 17),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        )),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Back to Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: secondaryColor))),
            )
          ],
        ),
      ),
    );
  }
}
