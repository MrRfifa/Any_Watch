import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ShowProvider>(
          create: (context) => ShowProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff746bc9),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return HomePage();
            } else {
              return WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}
