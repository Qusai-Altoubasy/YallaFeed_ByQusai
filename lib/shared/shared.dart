
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/common_screens/announcemnts.dart';
import '../screens/common_screens/contact_us.dart';
import '../screens/common_screens/profile.dart';

String charity_name = 'Charity Name';
String admin_name = 'Admin Name';
String user_name = 'User Name';

void navigateto(context, Widget page) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=> page,
      ),
  );
}

Widget menu(context, Color color)=> Padding(
  padding: EdgeInsetsDirectional.only(
    top: 30,
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
                navigateto(context, profile());
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
              onTap: (){
                navigateto(context, announcemnts_shared());
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
                Navigator.pop(context);
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




