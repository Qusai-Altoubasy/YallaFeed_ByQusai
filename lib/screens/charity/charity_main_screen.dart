import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/charity.dart';
import 'package:qusai/screens/charity/accept_reject_new_user.dart';
import 'package:qusai/cubits/charity/charity_cubit.dart';
import 'package:qusai/cubits/charity/charity_states.dart';
import 'package:qusai/screens/charity/manage_accounts.dart';
import 'package:qusai/shared/shared.dart';
import '../admin/announcements.dart';

class charity_main_screen extends StatelessWidget {
  final String uid;
  const charity_main_screen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = charity_cubit();
        cubit.getcharity(uid);
        return cubit;
      },
      child: BlocConsumer<charity_cubit, charity_states>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = charity_cubit.get(context);
          final charity? currentCharity = cubit.Charity;

          return Scaffold(
            drawer: menu(context, const Color(0xFF1F7A5C)),
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xFFF3F7F6),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Charity Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
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
                          // ===== HEADER CARD =====
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1F7A5C),
                                  Color(0xFF3AA17E),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 26, horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    'Welcome back',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 14,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    currentCharity?.name ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Together we create impact by connecting generosity with need.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // ===== ACTIONS CARD =====
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      color: Color(0xFF1A202C),
                                    ),
                                  ),
                                  const SizedBox(height: 26),

                                  _buildModernButton(
                                    color1: const Color(0xFF56AB2F),
                                    color2: const Color(0xFFA8E063),
                                    icon: Icons.person_add_alt_1_rounded,
                                    text: 'Accept new recipients',
                                    onTap: () {
                                      navigatetoWithTransition(
                                        context,
                                        accept_reject_new_user(),
                                        color: const Color(0xFF43A047),
                                        message: 'Reviewing new requests...',
                                      );

                                    },
                                  ),
                                  const SizedBox(height: 22),

                                  _buildModernButton(
                                    color1: const Color(0xFF396AFC),
                                    color2: const Color(0xFF2948FF),
                                    icon: Icons.group_rounded,
                                    text: 'Manage recipients',
                                    onTap: () {
                                      navigatetoWithTransition(
                                        context,
                                        manage_accounts(),
                                        color: const Color(0xFF11998E),
                                        message: 'Loading accounts manager...',
                                      );

                                    },
                                  ),
                                  const SizedBox(height: 22),

                                  _buildModernButton(
                                    color1: const Color(0xFF7F00FF),
                                    color2: const Color(0xFFE100FF),
                                    icon:
                                    Icons.notifications_active_rounded,
                                    text: 'Send announcement',
                                    onTap: () {
                                      navigatetoWithTransition(
                                        context,
                                        AnnouncementDesign(
                                          Owenr: currentCharity!,
                                          uid: uid,
                                        ),
                                        color: const Color(0xFF26A69A),
                                        message: 'Preparing announcement...',
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
        },
      ),
    );
  }

  // ===== REUSABLE BUTTON =====
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
        height: 72,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
