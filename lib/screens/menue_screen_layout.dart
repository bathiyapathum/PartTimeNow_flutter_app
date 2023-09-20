import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class MenueScreen extends StatelessWidget {
  const MenueScreen({super.key});

  void signOut(context) async {
    await AuthMethod().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Menu',
            style: TextStyle(
              color: signInBtn,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: navActivaeColor,
                  size: 30,
                ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // body: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/Welcome.jpg'),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Name',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Text(
                      '@23284',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(12.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          signInBtn,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(300, 50)),
                      elevation: MaterialStateProperty.all(12.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        signInBtn,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0.0), // Adjust the radius as needed
                        ),
                      ),
                    ),
                    child: const Text('hay'),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
