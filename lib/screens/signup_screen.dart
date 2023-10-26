// ignore_for_file: unnecessary_null_comparison
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/Widgets/text_field_input.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/category_selection_screen.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final logger = Logger();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void signUpUserData() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });

    if (image != null) {
      res = await AuthMethod().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: image!,
      );
    } else {
      showSnackBar('Please select an image', context);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    logger.d('isssssssssssssssssssssssssaaaa  ${res}');

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
    }
  }

  void snackBar(res) {
    if (res == 'Success') {
      showSnackBar(
        'User created successfully',
        context,
      );
    } else {
      showSnackBar(res, context);
      // logger.e(res);
    }
  }

  void navgateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const CategorySelectionScreen(),
      ),
    );
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/SignUp.jpg',
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 184),
                //circle avatar
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVoRlmXdh-WdDE4s4LFsOL1p05KKG8_ERrfqVFXaC57xgNLZFMMEqTmNJ8ltgGAYEdEwA&usqp=CAU',
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 82,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo),
                        color: hintColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                //text feild for username
                TextFieldInput(
                  textEditingController: usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  label: 'Username',
                ),
                const SizedBox(
                  height: 24,
                ),
                //text feild email
                TextFieldInput(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 24,
                ),
                //text feild password
                TextFieldInput(
                  textEditingController: passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.visiblePassword,
                  isPass: true,
                  label: 'Password',
                ),
                const SizedBox(
                  height: 24,
                ),
                //input field for bio
                TextFieldInput(
                  textEditingController: bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  label: 'Bio',
                ),
                const SizedBox(
                  height: 24,
                ),
                // button login
                ElevatedButton(
                  onPressed: () {
                    signUpUserData();
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
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: buttonText,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                ),
                //go to signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text("Having an account?",
                          style: TextStyle(
                            color: hintColor,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToLogin();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: postUserNameColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 64,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
