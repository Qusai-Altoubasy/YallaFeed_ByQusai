import 'package:flutter/material.dart';
import 'package:qusai/screens/common_screens/history.dart';
import 'package:qusai/screens/user/deleviry/view_available_requests.dart';
import 'package:qusai/shared/shared.dart';

import '../../../classes/user.dart';

class deleviry_main_screen extends StatelessWidget {
  final user? User;
  deleviry_main_screen({required this.User});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFEAF5EC),
      body: Stack(
        children: [
          // ===== BACKGROUND =====
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2E7D32),
                  Color(0xFF66BB6A),
                  Color(0xFFC8E6C9),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ===== HEADER =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1B5E20),
                          Color(0xFF43A047),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_shipping_rounded,
                          size: 56,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Welcome back,\n${User?.name ?? ''}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Your dedication helps meals reach\nthose who need them most.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== ACTIONS CARD =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Actions',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E2E2E),
                          ),
                        ),
                        const SizedBox(height: 24),

                        _buildModernButton(
                          icon: Icons.assignment_rounded,
                          text: 'View available requests',
                          gradient: const [
                            Color(0xFFF4511E),
                            Color(0xFFBF360C),
                          ],
                          onTap: () {
                            navigatetoWithTransition(
                              context,
                              view_available_requests(),
                              color: const Color(0xFF2E7D32),
                              message: 'Loading delivery requests...',
                            );

                          },
                        ),

                        const SizedBox(height: 22),

                        _buildModernButton(
                          icon: Icons.history_rounded,
                          text: 'Delivery history',
                          gradient: const [
                            Color(0xFF616161),
                            Color(0xFF424242),
                          ],
                          onTap: () {
                            navigatetoWithTransition(
                              context,
                              history(),
                              color: const Color(0xFF616161),
                              message: 'Loading history...',
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== MODERN BUTTON =====
  Widget _buildModernButton({
    required IconData icon,
    required String text,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
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
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white70, size: 16),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
