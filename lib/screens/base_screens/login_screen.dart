import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/login/login_cubit.dart';
import 'package:qusai/cubits/login/login_states.dart';
import 'package:qusai/screens/register/register_options.dart';
import 'package:qusai/shared/shared.dart';
import '../../components/components.dart';
import '../../cubits/profile_cubit.dart';
import '../admin/admin_main_screen.dart';
import '../charity/charity_main_screen.dart';
import '../user/user_layout.dart';

class login_screen extends StatelessWidget {
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$')
        .hasMatch(email);
  }

  void showDeletedAccountSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 6,
          backgroundColor: const Color(0xFFD32F2F),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          duration: const Duration(seconds: 3),
          content: Row(
            children: const [
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The account has been deleted',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => login_cubit(),
      child: BlocConsumer<login_cubit, login_states>(
        listener: (_, __) {},
        builder: (context, state) {
          final cubit = login_cubit.get(context);

          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F855A),
                    Color(0xFF68D391),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Sign in to continue helping others',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultFormField(
                                  controller: EmailController,
                                  label: "Email Address",
                                  prefix: Icons.email_outlined,
                                  type: TextInputType.emailAddress,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Email must not be empty";
                                    } else if (!isValidEmail(value.trim())) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 20),

                                defaultFormField(
                                  controller: PasswordController,
                                  label: "Password",
                                  prefix: Icons.lock_outline,
                                  type: TextInputType.visiblePassword,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Password must not be empty";
                                    }
                                    return null;
                                  },
                                  suffix: cubit.suffix,
                                  isPassword: cubit.isPassword,
                                  suffixPressed:
                                  cubit.changePasswordVisibility,
                                ),

                                const SizedBox(height: 20),

                                defaultButton(
                                  text: "Log In",
                                  height: 52,
                                  function: () async {
                                    if (!formKey.currentState!.validate())
                                      return;

                                    try {
                                      await cubit.userLogin(
                                        email:
                                        EmailController.text.trim(),
                                        password:
                                        PasswordController.text.trim(),
                                      );
                                    } on FirebaseAuthException {
                                      showDeletedAccountSnackBar(context);
                                      return;
                                    }

                                    navigatetoWithTransition(
                                      context,
                                      StreamBuilder(
                                        stream: FirebaseAuth.instance
                                            .authStateChanges(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                CircularProgressIndicator());
                                          }

                                          final user = FirebaseAuth
                                              .instance.currentUser;
                                          if (user == null) {
                                            return login_screen();
                                          }

                                          final uid = user.uid;
                                          userid = uid;

                                          return FutureBuilder<String?>(
                                            future: getUserType(uid),
                                            builder:
                                                (context, userSnapshot) {
                                              if (userSnapshot
                                                  .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                    CircularProgressIndicator());
                                              }

                                              if (!userSnapshot.hasData ||
                                                  userSnapshot.data ==
                                                      null) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) {
                                                      showDeletedAccountSnackBar(
                                                          context);
                                                      FirebaseAuth.instance
                                                          .signOut();
                                                    });
                                                return login_screen();
                                              }

                                              final type =
                                              userSnapshot.data!;
                                              usertype = type;

                                              ProfileCubit.get(context)
                                                  .loadUser(uid);

                                              if (type == 'user') {
                                                return user_layout(
                                                    uid: uid);
                                              } else if (type ==
                                                  'charity') {
                                                return charity_main_screen(
                                                    uid: uid);
                                              } else if (type ==
                                                  'admin') {
                                                return admin_main_screen(
                                                    uid: uid);
                                              } else {
                                                FirebaseAuth.instance
                                                    .signOut();
                                                return login_screen();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      color: const Color(0xFF4CAF50),
                                      message: 'Signing you in...',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account?",
                            style:
                            TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              navigatetoWithTransition(
                                context,
                                register_option(),
                                color:
                                const Color(0xFF00BFA5),
                                message:
                                'Preparing registration options...',
                              );
                            },
                            child: const Text(
                              "Register Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
