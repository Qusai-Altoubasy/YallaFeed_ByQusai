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

    _controller.addStatusListener((status) {
      if (status.isCompleted) {
        Future.delayed(const Duration(seconds: 1), () {
          navigatetoWithTransition(
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
                userid = uid;

                return FutureBuilder<String?>(
                  future: getUserType(uid),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final type = userSnapshot.data;
                    usertype = type;

                    if (type == 'user') {
                      return user_layout(uid: uid);
                    } else if (type == 'charity') {
                      return charity_main_screen(uid: uid);
                    } else {
                      return admin_main_screen(uid: uid);
                    }
                  },
                );
              },
            ),
            color: const Color(0xFF4CAF50),
            message: 'Finalizing your session...',
          );

        });
      }
    });
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
            colors: [
              Color(0xFF2F855A),
              Color(0xFF68D391),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white30,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.volunteer_activism,
                    color: Colors.white,
                    size: 72,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Nakhwa',
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Share food • Spread kindness',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
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
