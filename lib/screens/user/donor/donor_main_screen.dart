import 'package:flutter/material.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/screens/user/donor/add_new_donation.dart';
import 'package:qusai/screens/user/donor/my_donations.dart';
import 'package:qusai/shared/shared.dart';
import '../../../classes/user.dart';

class donor_main_screen extends StatelessWidget {
  late user? User;
  donor_main_screen({required this.User});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF3F7F6),
      body: Stack(
        children: [
          // ===== BACKGROUND =====
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1F7A5C),
                  Color(0xFF3AA17E),
                  Color(0xFF8FE3CF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // ===== CONTENT =====
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ===== HEADER =====
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 26, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.white.withOpacity(0.18),
                        border: Border.all(color: Colors.white24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Welcome back,\n${User?.name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Thank you for sharing your kindness\nEvery donation makes a difference',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ===== ACTIONS =====
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Actions',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 30),

                            _donorActionButton(
                              icon: Icons.add_circle_outline,
                              title: 'Add New Donation',
                              subtitle:
                              'Share surplus food with those in need',
                              gradient: const [
                                Color(0xFF11998E),
                                Color(0xFF38EF7D),
                              ],
                              onTap: () {
                                navigateto(context, add_new_donation());
                              },
                            ),

                            const SizedBox(height: 22),

                            _donorActionButton(
                              icon: Icons.inventory_2_outlined,
                              title: 'My Donations',
                              subtitle:
                              'Track and manage your donations',
                              gradient: const [
                                Color(0xFF3A7BD5),
                                Color(0xFF00D2FF),
                              ],
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

  // ===== BUTTON =====
  Widget _donorActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.45),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
