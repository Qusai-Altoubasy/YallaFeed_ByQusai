// Qusai Altoubasy

import 'package:flutter/material.dart';
import 'package:qusai/screens/logo_screen.dart';
import 'package:qusai/screens/login_screen.dart';
import 'package:qusai/screens/register/charity_register.dart';
import 'package:qusai/screens/register/register_options.dart';
import 'package:qusai/screens/register/user_register.dart';

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
      home: charity_register(),
    );
  }
}