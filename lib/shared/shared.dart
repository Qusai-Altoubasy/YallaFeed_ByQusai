
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/mainuser.dart';
import 'package:qusai/screens/base_screens/logo_screen.dart';
import '../cubits/profile_cubit.dart';
import '../screens/base_screens/login_screen.dart';
import '../screens/common_screens/announcemnts.dart';
import '../screens/common_screens/contact_us.dart';
import '../screens/common_screens/page_transition.dart';
import '../screens/common_screens/profile.dart';

String ?usertype;
String ?userid;
mainuser ? current;
Future<void> navigateto (context, Widget page) async {
  Navigator.push (
      context,
      MaterialPageRoute(
        builder: (context)=> page,
      ),
  );
}

Widget menu(context, Color color)=> Padding(
  padding: EdgeInsetsDirectional.only(
    top: 30,
    bottom: 60,
  ),
  child: NavigationDrawer(
    backgroundColor: color,
    children:[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const Icon(Icons.person, size: 30,),
              title: const Text('Profile'),
              onTap: (){
                navigateto(context, profile()
                );
              },
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: double.infinity,
            ),
            ListTile(
              leading: const Icon(Icons.notifications, size: 30,),
              title: const Text('Announcements'),
              onTap: () async {
                await navigateto(context, announcemnts_shared());
              },
            ),
            Container(
              color: Colors.grey,
              height: 2,
              width: double.infinity,
            ),
            ListTile(
              leading: const Icon(Icons.group, size: 30,),
              title: const Text('Contact us'),
              onTap: (){
                navigateto(context, contact_us());
              },
            ),
            Container(
              color: Colors.grey,
              height: 2,
              width: double.infinity,
            ),
            ListTile(
              leading: const Icon(Icons.logout, size: 30,),
              title: const Text('Log out'),
              onTap: ()async {
                await FirebaseAuth.instance.signOut();
                context.read<ProfileCubit>().emit(null);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => (login_screen())),
                        (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    ],
  ),
);



Future<String?> getUserType(String uid) async {
  // Check users collection
  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  if (userDoc.exists) return 'user';

  // Check charity collection
  final charityDoc = await FirebaseFirestore.instance
      .collection('charity')
      .doc(uid)
      .get();
  if (charityDoc.exists) return 'charity';

  // Check admin collection
  final adminDoc = await FirebaseFirestore.instance
      .collection('admin')
      .doc(uid)
      .get();
  if (adminDoc.exists) return 'admin';

  return null; // Not found in any collection
}
void navigatetoWithTransition(
    BuildContext context,
    Widget nextScreen, {
      Color color = const Color(0xFF1F7A5C),
      String message = 'Loading...',
    }) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PageTransitionScreen(
        nextPage: nextScreen,
        primaryColor: color,
        message: message,
      ),
    ),
  );
}

