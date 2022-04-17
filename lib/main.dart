import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/product_provider.dart';
import 'package:anime_info/screens/checkout.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/login.dart';
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
    return MaterialApp(
      theme: ThemeData(),
      home: MultiProvider(
        providers: [
          Provider<ProductProvider>(create: (ctx) => ProductProvider()),
          Provider<CategoryProvider>(create: (ctx) => CategoryProvider())
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
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
