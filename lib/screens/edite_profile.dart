// ignore_for_file: unnecessary_null_comparison
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:parttimenow_flutter/Widgets/text_field_input.dart';
import 'package:parttimenow_flutter/models/user_model.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/category_selection_screen.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';
import 'package:parttimenow_flutter/utils/utills.dart';

class EditeProfile extends StatefulWidget {
  const EditeProfile({super.key});

  @override
  State<EditeProfile> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<EditeProfile> {

    Map<String, dynamic>? userData;
  UserModel? userDetails;
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

    Future<void> getUserData() async {
    try {
      // Assuming AuthMethod().getUserDetails() returns a UserModel instance
      final user = await AuthMethod().getUserDetails();
      // ignore: unnecessary_null_comparison
      if (user != null) {
        setState(() {
          userDetails = user;
        });
        logger.e(user.email);
        user.photoUrl;
      } else {}
    } catch (e) {
      userDetails = null; // Set userDetails to null in case of an error
    }
  }

    @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    getUserData();

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

    logger.d('isssssssssssssssssssssssssaaaa  $res');

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
                        :  CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              userDetails?.photoUrl?? 'N/A',
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
                  label: userDetails?.username?? 'N/A',
                ),
                const SizedBox(
                  height: 24,
                ),
                //text feild email
                TextFieldInput(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  label: userDetails?.email?? 'N/A',
                ),
                const SizedBox(
                  height: 24,
                ),

                TextFieldInput(
                  textEditingController: bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  label: userDetails?.bio?? 'N/A',
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
                          'Update Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: buttonText,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                ),
                //go to signup
                
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
