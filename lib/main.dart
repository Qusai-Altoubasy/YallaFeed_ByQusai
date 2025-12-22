// Qusai Ayman Altoubasy

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/screens/base_screens/logo_screen.dart';

import 'cubits/admin/admin_cubit.dart';
import 'cubits/login/login_cubit.dart';
import 'cubits/profile_cubit.dart';
import 'cubits/user/user_cubit.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(  MultiBlocProvider
    (
      providers: [
        BlocProvider(create: (_) => ProfileCubit()),
      ],child: const MyApp()));


//abuissa

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