import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';

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
  

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              signOut(context);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
