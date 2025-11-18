// Qusai Altoubasy

import 'package:flutter/material.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';
import 'package:qusai/screens/charity/charity_main_screen.dart';
import 'package:qusai/screens/base_screens/login_screen.dart';
import 'package:qusai/screens/base_screens/logo_screen.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/screens/register/charity_register.dart';
import 'package:qusai/screens/register/register_options.dart';
import 'package:qusai/screens/register/user_register.dart';
import 'package:qusai/screens/temp.dart';
import 'package:qusai/screens/user/user_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: logo_screen(),
    );
  }
}