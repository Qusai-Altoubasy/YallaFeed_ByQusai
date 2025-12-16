import 'package:flutter/material.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/screens/user/donor/add_new_donation.dart';
import 'package:qusai/screens/user/donor/my_donations.dart';
import 'package:qusai/shared/shared.dart';

import '../../../classes/user.dart';

class donor_main_screen extends StatelessWidget {
  late user ?User;
  donor_main_screen({required this.User});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      backgroundColor: const Color(0xFFE8EEF5),
      body: Stack(
        children: [
          //  Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9BE7FF),
                  Color(0xFFB3E5FC),
                  Color(0xFFE1F5FE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          //  Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //  Header card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4A90E2),
                            Color(0xFF6FB1FC),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome back,\n${User?.name}!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              textAlign: TextAlign.center,
                              'Thank you for sharing your surplus food and '
                                  'helping reduce waste in our community',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Actions card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Actions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // 🟩 Button 1 - Accept new recipients
                            _buildModernButton(
                              color1: const Color(0xFF56AB2F),
                              color2: const Color(0xFFA8E063),
                              icon: Icons.add_box_outlined,
                              text: 'Add new donation',
                              onTap: () {
                                navigateto(context, add_new_donation());
                              },
                            ),

                            const SizedBox(height: 25),

                            // 🟥 Button 2 - Block recipients
                            _buildModernButton(
                              color1: const Color(0xFFED213A),
                              color2: const Color(0xFF93291E),
                              icon: Icons.list_alt,
                              text: 'My donations',
                              onTap: () {
                                navigateto(context, my_donations());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Custom reusable modern button widget
  Widget _buildModernButton({
    required Color color1,
    required Color color2,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}