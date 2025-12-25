
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/classes/donation.dart';
import 'package:qusai/classes/mainuser.dart';
import 'package:qusai/classes/user.dart';
import 'package:qusai/screens/base_screens/logo_screen.dart';
import '../cubits/profile/profile_cubit.dart';
import '../screens/base_screens/login_screen.dart';
import '../screens/common_screens/announcemnts.dart';
import '../screens/common_screens/contact_us.dart';
import '../screens/common_screens/profile.dart';
import 'package:qusai/screens/common_screens/page_transition.dart';


String ?usertype;
String ?userid;
mainuser ? current;
donation ? receiverdonationdetails;



Future<void> navigateto(context, Widget page) async {
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
    bottom: 55,
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
                final uid = FirebaseAuth.instance.currentUser!.uid;
                navigateto(context, BlocProvider(
                    create: (_) => ProfileCubit()..loadUser(uid),
                    child: profile()
                )
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

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => (logo_screen())),
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

Future<void> submitRating({
  required String userId,
  required int stars,
}) async {
  final userRef =
  FirebaseFirestore.instance.collection('users').doc(userId);

  await FirebaseFirestore.instance.runTransaction((tx) async {
    final snap = await tx.get(userRef);

    final total = (snap['ratingTotal'] ?? 0) + stars;
    final count = (snap['ratingCount'] ?? 0) + 1;
    final avg = total / count;

    tx.update(userRef, {
      'ratingTotal': total,
      'ratingCount': count,
      'ratingAverage': avg,
    });
    if(avg<= 2.5){
      announcement x = announcement(
        title: '${snap['name']} rating',
        message: 'The user ${snap['name']} have rating ${avg.toStringAsFixed(2)} so,'
            ' you better delete his/her account',
        sendTo: 'admin',
        owener: '111',
        id: 'ss',
      );
      x.svaeindatabase();
    }
  });
}

