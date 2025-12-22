import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../classes/user.dart';
import '../../components/components.dart';
import '../../cubits/register/register_cubit.dart';
import '../../cubits/register/register_states.dart';


class user_register extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final IDController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => register_cubit(),
      child: BlocConsumer<register_cubit, register_states>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = register_cubit.get(context);

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
                    Color(0xFF2F855A),
                    Color(0xFF68D391),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: Column(
                    children: [
                      // ===== HEADER =====
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.volunteer_activism,
                              size: 56,
                              color: Colors.white,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'User Registration',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Register now to donate or receive food easily',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ===== FORM CARD =====
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.96),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                label: 'Your name',
                                prefix: Icons.person_outline,
                                validate: (v) =>
                                v.isEmpty ? 'Enter your name' : null,
                              ),
                              const SizedBox(height: 14),

                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'Email address',
                                prefix: Icons.email_outlined,
                                validate: (v) {
                                  if (v.isEmpty) return 'Email is required';
                                  if (!isValidEmail(v.trim())) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              defaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                label: 'Phone number',
                                prefix: Icons.phone_outlined,
                                validate: (v) {
                                  if (v.isEmpty) return 'Phone number required';
                                  if (v.length != 10) {
                                    return 'Phone must be 10 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              defaultFormField(
                                controller: IDController,
                                type: TextInputType.number,
                                label: 'National ID',
                                prefix: Icons.badge_outlined,
                                validate: (v) {
                                  if (v.isEmpty) return 'ID required';
                                  if (v.length != 10) {
                                    return 'ID must be 10 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                prefix: Icons.lock_outline,
                                isPassword: cubit.isPassword,
                                suffix: cubit.suffix,
                                suffixPressed:
                                cubit.changePasswordVisibility,
                                validate: (v) =>
                                v.isEmpty ? 'Password required' : null,
                              ),
                              const SizedBox(height: 14),

                              defaultFormField(
                                controller: confirmpasswordController,
                                type: TextInputType.visiblePassword,
                                label: 'Confirm password',
                                prefix: Icons.lock_outline,
                                isPassword: cubit.isPassword,
                                suffix: cubit.suffix,
                                suffixPressed:
                                cubit.changePasswordVisibility,
                                validate: (v) {
                                  if (v.isEmpty) return 'Confirm password';
                                  if (v != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 28),

                              // ===== REGISTER BUTTON =====
                              Container(
                                width: double.infinity,
                                height: 54,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2F855A),
                                      Color(0xFF68D391),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF2F855A)
                                          .withOpacity(0.35),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (!formKey.currentState!.validate()) return;

                                    final User = user(
                                      username: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      id: IDController.text,
                                      imageUrl: 'image path',
                                      password: passwordController.text,
                                    );

                                    try {
                                      await cubit.userRegister(User: User);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                          Text('Registered successfully'),
                                        ),
                                      );
                                    } catch (_) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                          Text('Invalid information'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
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
          );
        },
      ),
    );
  }
}
