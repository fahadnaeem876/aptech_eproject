import 'package:e_project/admin/home.dart';
import 'package:e_project/admin/productadd.dart';
import 'package:e_project/firebase_options.dart';
import 'package:e_project/login.dart';
import 'package:e_project/register.dart';
import 'package:e_project/splash.dart';
import 'package:e_project/user/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: login(),
      home: Splash(),
      // home: ProductAdd(),
      // home: home(),
      routes: {
        "/login": (context) => login(),
        "/RegisterPage": (context) => RegisterPage(),
        "/home": (context) => home(),
        "/adminhome":(context) => AdminHome()
      },
    );
  }
}
