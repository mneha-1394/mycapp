
import 'package:test_app/screens/verify_screen.dart';
import 'package:test_app/utils/utils.dart';
import '/resources/auth_methods.dart';
import '/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _visibile = true;
  void googleSiginIn() async {
    await AuthMethods().googleSiginIn();
  }
  void checkpassword(){
    if(_passwordController.text==_confirmpasswordController.text){
       return signUpUser();
    }
    else{
          showSnackBar(context, "Confirm Password should be same as Password");
    }
  }
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const VerfiyScreen()),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
        showSnackBar(context, res);
      
    }
  }

  Widget horizontalline() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          height: 1,
          width: 70, // change with web
          color: primaryColor,
        ),
      );
  Widget flexible() => Flexible(flex: 2, child: Container());
  Widget imagebox(String imageasset) =>
      SizedBox(child: Image.asset(imageasset));
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(flex: 1, child: Container()),
            imagebox("assets/4.png"),
            const SizedBox(height: 25),
            TextFieldInput(
                prefixIcon: const Icon(
                  Icons.email,
                ),
                suffixIcon: const Icon(Icons.edit),
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            TextFieldInput(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon:
                      Icon(_visibile ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _visibile = !_visibile;
                    });
                  },
                ),
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: _visibile),
            const SizedBox(height: 24),
            TextFieldInput(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon:
                      Icon(_visibile ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _visibile = !_visibile;
                    });
                  },
                ),
                textEditingController: _confirmpasswordController,
                hintText: 'Re-enter your password',
                textInputType: TextInputType.text,
                isPass: _visibile),
            const SizedBox(height: 14),
            InkWell(
              onTap:checkpassword,
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
                        'Sign Up',
                        style: TextStyle(color: primaryColor, fontSize: 17),
                      )
                    : const CircularProgressIndicator(color:primaryColor),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                flexible(),
                horizontalline(),
                const Text(
                  'Or Continue With',
                  style: TextStyle(color: primaryColor, fontSize: 15),
                ),
                horizontalline(),
                flexible(),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                flexible(),
                InkWell(
                    onTap: googleSiginIn,
                    child: ClipOval(child: imagebox("assets/google.jpg"))),
                flexible(),
                InkWell(
                    onTap: () {},
                    child: ClipOval(child: imagebox("assets/facebook.jpg"))),
                flexible(),
                InkWell(
                    onTap: () {},
                    child: ClipOval(child: imagebox("assets/github.jpg"))),
                flexible()
              ],
            ),
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Already have an account? ",
                      style: TextStyle(color: primaryColor),
                    )),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: primaryColor))),
                )
              ],
            ),
            const Spacer(),
          ]),
        )));
  }
}
