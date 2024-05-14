import "package:test_app/utils/utils.dart";
import "../responsive/mobile_screen_layout.dart";
import "../responsive/responsive_layout.dart";
import "../responsive/web_screen_layout.dart";
import "/resources/auth_methods.dart";
import "/screens/reset_password_screen.dart";
import "../screens/signup_screen.dart";
import "/utils/colors.dart";
import "/widgets/text_field_input.dart";
import "package:flutter/material.dart";


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _visibile = true;
  void googleSiginIn() async {
    await AuthMethods().googleSiginIn();
  }

  void siginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().siginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ));

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  Widget horizontalline() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          height: 1,
          width: 70, // change with web(change this with media query)
          color: primaryColor,
        ),
      );
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            SizedBox(
              child: Image.asset('assets/4.png'),
            ),
            const SizedBox(height: 50),
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
                prefixIcon: const Icon(
                  Icons.lock,
                ),
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
                isPass: _visibile,),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ResetPasswordScreen()));
              },
              child: const Text('Forget Password?',
                  style: TextStyle(color: primaryColor, fontSize: 15)),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap:siginUser,
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
                        'Login ',
                        style: TextStyle(color: primaryColor, fontSize: 17),
                      )
                    : const CircularProgressIndicator(color: primaryColor,)
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 1, child: Container()),
                horizontalline(),
                const Text(
                  'Or Continue With',
                  style: TextStyle(color: primaryColor, fontSize: 15),
                ),
                horizontalline(),
                Flexible(flex: 1, child: Container()),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 1, child: Container()),
                InkWell(
                  //onTap: googleSiginIn,
                  child: ClipOval(child: Image.asset("assets/google.jpg")),
                ),
                Flexible(flex: 1, child: Container()),
                InkWell(
                  onTap: () {},
                  child: ClipOval(child: Image.asset("assets/facebook.jpg")),
                ),
                Flexible(flex: 1, child: Container()),
                InkWell(
                  onTap: () {},
                  child: ClipOval(child: Image.asset("assets/github.jpg")),
                ),
                Flexible(flex: 1, child: Container()),
              ],
            ),
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(color: primaryColor, fontSize: 15),
                    )),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(" Sign Up",
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
