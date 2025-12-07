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
      create: (BuildContext context){
        var cubit = charity_cubit();
        cubit.getcharity(uid);
        return cubit;
      },
      child: BlocConsumer<charity_cubit, charity_states>(
          builder: (context, state){
            if(state is loading){
              return Center(child: CircularProgressIndicator());
            }
            var cubit = charity_cubit.get(context);
            charity? current_charity = cubit.Charity;
            return Scaffold(
            drawer: menu(context, Color(0xFF9BE7FF)),
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xFFE8EEF5),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Charity Organization Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),
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
                                    'Welcome back,\n ${current_charity.name} !',
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
                                    'Together we are making a difference in our community\n'
                                        'by connecting those in need with generous donors.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 25
                          ),
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
                                    icon: Icons.person_add_alt_1_rounded,
                                    text: 'Accept new recipients',
                                    onTap: () {
                                      navigateto(context, accept_reject_new_user());
                                    },
                                  ),
                                  const SizedBox(height: 25),

                                  // 🟦 Button 3 - Manage recipients
                                  _buildModernButton(
                                    color1: const Color(0xFF396afc),
                                    color2: const Color(0xFF2948ff),
                                    icon: Icons.group,
                                    text: 'Manage recipients',
                                    onTap: () {
                                      navigateto(context, manage_accounts());
                                    },
                                  ),
                                  const SizedBox(height: 25),

                                  // 🟦 Button 3 - Manage recipients
                                  _buildModernButton(
                                    color1: const Color(0xff7F00FF),
                                    color2: const Color(0xffE100FF),
                                    onTap: () {
                                      navigateto(context, AnnouncementDesign());
                                    },
                                    icon: Icons.notifications_active,
                                    text: 'Send announcement',
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
          listener: (context, state){},
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
