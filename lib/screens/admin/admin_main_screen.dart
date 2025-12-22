import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qusai/classes/admin.dart';
import 'package:qusai/cubits/admin/admin_cubit.dart';
import 'package:qusai/cubits/admin/admin_states.dart';
import 'package:qusai/screens/admin/add_new_user.dart';
import 'package:qusai/screens/admin/announcements.dart';
import 'package:qusai/screens/admin/manage_accounts.dart';
import 'package:qusai/shared/shared.dart';

class admin_main_screen extends StatelessWidget {
  final String uid;
  const admin_main_screen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = admin_cubit();
        cubit.getadmin(uid);
        return cubit;
      },
      child: BlocConsumer<admin_cubit, admin_state>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = admin_cubit.get(context);
          final admin? currentAdmin = cubit.Admin;

          return Scaffold(
            drawer: menu(context, const Color(0xFF1F7A5C)),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Admin Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            body: Stack(
              children: [
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

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ===== HEADER =====
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 26, horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Colors.white.withOpacity(0.18),
                            border: Border.all(color: Colors.white24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Welcome, ${currentAdmin?.name ?? ''}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Leading impact • Reducing food waste",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 26),

                        // ===== CARDS =====
                        Expanded(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.82,
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final cards = [
                                {
                                  'icon': Icons.person_add_alt_1,
                                  'title': 'Add User',
                                  'desc':
                                  'Register donors, receivers or drivers',
                                  'gradient': const [
                                    Color(0xFF11998E),
                                    Color(0xFF38EF7D),
                                  ],
                                  'action': () =>
                                      navigatetoWithTransition(
                                        context,
                                        add_new_user(),
                                        color: const Color(0xFF2F80ED),
                                        message: 'Opening registration form...',
                                      )
                                  ,
                                },
                                {
                                  'icon': Icons.group,
                                  'title': 'Manage Accounts',
                                  'desc': 'Edit or remove user accounts',
                                  'gradient': const [
                                    Color(0xFF3A7BD5),
                                    Color(0xFF00D2FF),
                                  ],
                                  'action': () =>
                                      navigatetoWithTransition(
                                        context,

                                        manage_accounts(),
                                        color: const Color(0xFF11998E),
                                        message: 'Loading accounts manager...',
                                      ),


                                },
                                {
                                  'icon': Icons.notifications_active,
                                  'title': 'Announcements',
                                  'desc': 'Broadcast messages to all users',
                                  'gradient': const [
                                    Color(0xFF7F00FF),
                                    Color(0xFFE100FF),
                                  ],
                                  'action': () =>navigatetoWithTransition(
                                    context,
                                    AnnouncementDesign(
                                      Owenr: currentAdmin!,
                                      uid: uid,
                                    ),
                                    color: const Color(0xFF7F00FF),
                                    message: 'Preparing announcement editor...',
                                  ),

                                },
                              ];

                              final card = cards[index];

                              return _adminCard(
                                icon: card['icon'] as IconData,
                                title: card['title'] as String,
                                description: card['desc'] as String,
                                gradient:
                                card['gradient'] as List<Color>,
                                onTap: card['action'] as VoidCallback,
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _adminCard({
    required IconData icon,
    required String title,
    required String description,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.4),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 34, color: Colors.white),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
