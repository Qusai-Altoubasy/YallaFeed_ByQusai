import 'package:flutter/material.dart';
import 'package:qusai/screens/register/charity_register.dart';
import 'package:qusai/screens/register/user_register.dart';
import 'package:qusai/shared/shared.dart';

class register_option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2F855A), // نفس ثيم Login
              Color(0xFF68D391),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.volunteer_activism,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Join Our Community',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose how you would like to help',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // ===== USER BUTTON =====
                  _buildOptionButton(
                    icon: Icons.person_outline,
                    text: 'Register as User',
                    onTap: () {
                      navigatetoWithTransition(
                        context,
                        user_register(),
                        color: const Color(0xFF4CAF50),
                        message: 'Starting user registration...',
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // ===== CHARITY BUTTON =====
                  _buildOptionButton(
                    icon: Icons.apartment_outlined,
                    text: 'Register as Charity Organization',
                    onTap: () {
                      navigatetoWithTransition(
                        context,
                        charity_register(),
                        color: const Color(0xFF2F855A),
                        message: 'Starting charity registration...',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16), // مهم
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2F855A),
              Color(0xFF68D391),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),

            // ✅ هذا هو الحل: خلي النص يتمدد واذا طول يختصر
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
