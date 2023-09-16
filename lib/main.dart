import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parttimenow_flutter/providers/user_provider.dart';
import 'package:parttimenow_flutter/responsive/mobile_screen_layout.dart';
import 'package:parttimenow_flutter/responsive/responsive.dart';
import 'package:parttimenow_flutter/responsive/web_screen_layout.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAfb0fE4QhUWpCv2idYZXcWLQ3c8xcFA2g",
      appId: "1:482037754383:web:206cf365d82e26e152517a",
      messagingSenderId: "482037754383",
      projectId: "parttimenow-d19d8",
      storageBucket: "parttimenow-d19d8.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Part Time Now',
        theme: ThemeData.dark().copyWith(          
          scaffoldBackgroundColor: Colors.white,          
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const LoginScreen();
            }),
      ),
    );
  }
}
