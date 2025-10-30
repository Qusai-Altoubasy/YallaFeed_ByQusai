import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qusai/cubits/admin/admin_cubit.dart';
import 'package:qusai/cubits/admin/admin_states.dart';
import 'package:qusai/screens/admin/add_new_user.dart';
import 'package:qusai/screens/register/user_register.dart';
import 'package:qusai/shared/shared.dart';

class admin_main_screen extends StatelessWidget {
  const admin_main_screen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> admin_cubit(),
      child: BlocConsumer<admin_cubit, admin_state>(
          builder: (context, state)=>Scaffold(
            drawer: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 30,
              ),
              child: NavigationDrawer(
                backgroundColor: Color(0xFF9BE7FF),
                children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            leading: const Icon(Icons.person, size: 30,),
                            title: const Text('Profile'),
                            onTap: (){},
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                          ListTile(
                            leading: const Icon(Icons.notifications, size: 30,),
                            title: const Text('Announcements'),
                            onTap: (){},
                          ),
                          Container(
                            color: Colors.grey,
                            height: 2,
                            width: double.infinity,
                          ),
                          ListTile(
                            leading: const Icon(Icons.group, size: 30,),
                            title: const Text('Contact us'),
                            onTap: (){},
                          ),
                          Container(
                            color: Colors.grey,
                            height: 2,
                            width: double.infinity,
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout, size: 30,),
                            title: const Text('Log out'),
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Admin Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9BE7FF),
                        Color(0xFFB3E5FC),
                        Color(0xFFE1F5FE),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),


                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // 🧑‍💼 قسم الترحيب
                        Hero(
                          tag: "admin_header",
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white.withOpacity(0.15),
                              border: Border.all(color: Colors.white30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Welcome, $admin_name 👋",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Reducing food waste, fighting hunger",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ⚡ البطاقات
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 1.0,
                            children: [
                              _buildGlassCard(
                                icon: Icons.person_add_alt_1,
                                title: "Add new user",
                                color1: const Color(0xff4FACFE),
                                color2: const Color(0xff00F2FE),
                                onTap: () {
                                  navigateto(context, add_new_user());
                                },
                              ),
                              _buildGlassCard(
                                icon: Icons.person_remove_alt_1,
                                title: "Remove User",
                                color1: const Color(0xffF85032),
                                color2: const Color(0xffE73827),
                                onTap: () {},
                              ),
                              _buildGlassCard(
                                icon: Icons.group,
                                title: "Manage Accounts",
                                color1: const Color(0xff11998e),
                                color2: const Color(0xff38ef7d),
                                onTap: () {},
                              ),
                              _buildGlassCard(
                                icon: Icons.notifications_active,
                                title: "Announcements",
                                color1: const Color(0xff7F00FF),
                                color2: const Color(0xffE100FF),
                                onTap: () {},
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
          ),
          listener: (context, state){},
      ),
    );
  }


  Widget _buildGlassCard({
    required IconData icon,
    required String title,
    required Color color1,
    required Color color2,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1.withOpacity(0.9), color2.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color2.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}