// Qusai Ayman Altoubasy

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';
import 'package:qusai/screens/base_screens/login_screen.dart';
import 'package:qusai/screens/base_screens/logo_screen.dart';
import 'package:qusai/screens/charity/charity_main_screen.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/screens/common_screens/profile.dart';

import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_screen(),
    );
  }
}