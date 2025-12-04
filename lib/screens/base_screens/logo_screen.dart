import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';
import 'package:qusai/screens/base_screens/login_screen.dart';
import 'package:qusai/screens/charity/charity_main_screen.dart';
import 'package:qusai/screens/user/user_layout.dart';
import 'package:qusai/shared/shared.dart';
class logo_screen extends StatefulWidget {
  const logo_screen({super.key});

  @override
  State<logo_screen> createState() => _logo_screen();
}
class _logo_screen extends State<logo_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _controller.addStatusListener((status){
        if(status.isCompleted){
          Future.delayed(Duration(seconds: 1),(){
            navigateto(
                context,
                StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return login_screen();
                    }

                    final uid = FirebaseAuth.instance.currentUser!.uid;

                    return FutureBuilder<String?>(
                      future: getUserType(uid),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final type = userSnapshot.data;

                        if (type == 'user') {
                          return user_layout(uid: uid,);
                        } else if (type == 'charity') {
                          return charity_main_screen();
                        } else {
                          return admin_main_screen();
                        }
                      },
                    );
                  },
                )
            );
          });
        }
      }
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4A90E2),Color(0xff50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

          ),


        ),

        child: Center(
          child: FadeTransition(

            opacity: _fadeIn,



            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54,width: 2)
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                SizedBox(height: 30),

                Text(
                  'Yalla Feed',
                  style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 15,
                          color: Colors.black26,
                          offset: Offset(2, 3),

                        )
                      ]

                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Share food • Spread kindess',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}