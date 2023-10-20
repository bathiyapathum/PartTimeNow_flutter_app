import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttimenow_flutter/Widgets/text_field_input.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/responsive/mobile_screen_layout.dart';
import 'package:parttimenow_flutter/responsive/responsive.dart';
import 'package:parttimenow_flutter/responsive/web_screen_layout.dart';
import 'package:parttimenow_flutter/screens/signup_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String _error = '';

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginInUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethod().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == 'Success') {
      setState(() {
        _isLoading = false;
      });

      snackBar(res);
      navgateToHome();
    } else {
      setState(() {
        _isLoading = false;
      });
      snackBar(res);

      setState(() {
        _error = res;
      });
    }
  }

  void snackBar(res) {
    if (res == 'Success') {
      showSnackBar(
        'Successfully Login',
        context,
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void navgateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ),
    );
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sign In',
          style: GoogleFonts.lato(
              textStyle: const TextStyle(
            color: postUserNameColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/sign.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              const CircleAvatar(
                radius: 84,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  radius: 74,
                  //svg image
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1681811472561-801b008d75e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text('Sign In to Continue',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    color: postUserNameColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
              const SizedBox(height: 44),
              //text feild email
              TextFieldInput(
                textEditingController: emailController,
                hintText: 'Email ID',
                label: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              //text feild password
              TextFieldInput(
                textEditingController: passwordController,
                hintText: 'Password',
                label: 'Password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                _error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              // button login
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      spreadRadius: 3, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(2, 6), // Offset
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    loginInUser();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    foregroundColor: primaryColor,
                    backgroundColor: signInBtn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Text(
                          'Sign In',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: buttonText,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                ),
              ),

              Flexible(flex: 2, child: Container()),
              //go to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Don't have an account?",
                        style: TextStyle(
                          color: hintColor,
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToSignup();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Sign Up ",
                        style: TextStyle(
                          color: postUserNameColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              )
            ],
          ),
        ),
      ),
    );
  }
}
