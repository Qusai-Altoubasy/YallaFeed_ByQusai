import 'package:flutter/material.dart';
import 'package:qusai/screens/user/deleviry/history/history.dart';
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ===== HEADER (SAME STYLE AS RECEIVER) =====
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
                          // ===== ICON =====
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.25),
                            ),
                            child: const Icon(
                              Icons.delivery_dining,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ===== MESSAGE =====
                          Text(
                            'Your help delivers hope 🤍',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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

                            _deliveryActionButton(
                              icon: Icons.assignment_outlined,
                              title: 'Available Requests',
                              subtitle:
                              'Find delivery requests near you',
                              gradient: const [
                                Color(0xFFF4511E),
                                Color(0xFFBF360C),
                              ],
                              onTap: () {
                                navigatetoWithTransition(
                                  context,
                                  view_available_requests(),
                                  color: const Color(0xFF2E7D32),
                                  message:
                                  'Loading delivery requests...',
                                );
                              },
                            ),

                            const SizedBox(height: 22),

                            _deliveryActionButton(
                              icon: Icons.history_outlined,
                              title: 'Delivery History',
                              subtitle:
                              'Review your completed deliveries',
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

  // ===== DELIVERY BUTTON (SAME AS RECEIVER) =====
  Widget _deliveryActionButton({
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
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
