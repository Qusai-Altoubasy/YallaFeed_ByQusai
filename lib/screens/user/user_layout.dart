import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/user.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/cubits/user/user_states.dart';
import 'package:qusai/screens/user/deleviry/deleviry_main_screen.dart';
import 'package:qusai/screens/user/donor/donor_main_screen.dart';
import 'package:qusai/screens/user/receiver/receiver_main_screen.dart';
import 'package:qusai/screens/user/user_profile.dart';
import 'package:qusai/shared/shared.dart';

import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/user_profile_cubit.dart';
import '../base_screens/logo_screen.dart';
import '../common_screens/announcemnts.dart';
import '../common_screens/contact_us.dart';

class user_layout extends StatelessWidget {
  final String uid;
  const user_layout({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = user_cubit();
        cubit.getuser(uid);
        return cubit;
      },
      child: BlocConsumer<user_cubit, user_states>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = user_cubit.get(context);
          final user? currentUser = cubit.User;

          final Color themeColor = cubit.current_index == 0
              ? const Color(0xFF1F7A5C)
              : cubit.current_index == 1
              ? const Color(0xFF6A1B9A)
              : const Color(0xFF2E7D32);

          return Scaffold(
            drawer: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 30,
                bottom: 55,
              ),
              child: NavigationDrawer(
                backgroundColor: themeColor,
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
                          onTap: (){
                            final uid = FirebaseAuth.instance.currentUser!.uid;
                            navigateto(context, BlocProvider(
                                create: (_) => user_profile_cubit()..loadUser(uid),
                                child: user_profile()
                            )
                            );
                          },
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications, size: 30,),
                          title: const Text('Announcements'),
                          onTap: () async {
                            await navigateto(context, announcemnts_shared());
                          },
                        ),
                        Container(
                          color: Colors.grey,
                          height: 2,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.group, size: 30,),
                          title: const Text('Contact us'),
                          onTap: (){
                            navigateto(context, contact_us());
                          },
                        ),
                        Container(
                          color: Colors.grey,
                          height: 2,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout, size: 30,),
                          title: const Text('Log out'),
                          onTap: ()async {
                            await FirebaseAuth.instance.signOut();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => (logo_screen())),
                                  (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xFFF3F7F6),


            appBar: AppBar(
              elevation: 0,
              backgroundColor: themeColor,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                cubit.titles[cubit.current_index],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // ===== BOTTOM NAV =====
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.reactCircle,
              backgroundColor: themeColor,
              elevation: 10,
              initialActiveIndex: cubit.current_index,
              onTap: cubit.change_bottom_nav_bar,
              items: const [
                TabItem(
                  icon: Icons.volunteer_activism_outlined,
                  title: 'Donate',
                ),
                TabItem(
                  icon: Icons.handshake_outlined,
                  title: 'Receive',
                ),
                TabItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Deliver',
                ),
              ],
            ),

            // ===== BODY =====
            body: cubit.current_index == 0
                ? donor_main_screen(User: currentUser)
                : cubit.current_index == 2
                ? deleviry_main_screen(User: currentUser)
                : currentUser!.havepermission
                ? receiver_main_screen(User: currentUser)
                : _noPermissionScreen(context, cubit, currentUser),
          );
        },
      ),
    );
  }

  // ===== NO PERMISSION SCREEN =====
  Widget _noPermissionScreen(
      BuildContext context, user_cubit cubit, user currentUser) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 70,
              color: Color(0xFF6A1B9A),
            ),
            const SizedBox(height: 20),
            const Text(
              'Permission Required',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'To receive meals, you need approval from a charity.\nYou can send a request below.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () async {
                  if (currentUser.askpermission) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text('You already sent a permission request'),
                      ),
                    );
                  } else {
                    await cubit.sendrequest(
                        currentUser.databaseID, currentUser.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Request sent successfully'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Send Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
