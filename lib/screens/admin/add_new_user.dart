import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';
import 'package:qusai/shared/shared.dart';
import '../../classes/user.dart';
import '../../components/components.dart';
import '../../cubits/register/register_cubit.dart';
import '../../cubits/register/register_states.dart';

class add_new_user extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final IDController = TextEditingController();
  final passwordController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => register_cubit(),
      child: BlocConsumer<register_cubit, register_states>(
        listener: (_, __) {},
        builder: (context, state) {
          final cubit = register_cubit.get(context);

          return Scaffold(
            extendBody: true,
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ===== HEADER =====
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1F7A5C),
                                      Color(0xFF3AA17E),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.black.withOpacity(0.18),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      onPressed: () =>
                                          Navigator.pop(context),
                                    ),
                                    const SizedBox(height: 12),
                                    const Icon(
                                      Icons.person_add_alt_1,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    const SizedBox(height: 14),
                                    const Text(
                                      'Add New User',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Register a donor, receiver, or driver',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),

                              // ===== FORM CARD =====
                              Container(
                                padding: const EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.black.withOpacity(0.06),
                                      blurRadius: 18,
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
                                        label: 'Full Name',
                                        prefix:
                                        Icons.person_outline,
                                        validate: (v) => v.isEmpty
                                            ? 'Name is required'
                                            : null,
                                      ),
                                      const SizedBox(height: 18),
                                      defaultFormField(
                                        controller: emailController,
                                        type:
                                        TextInputType.emailAddress,
                                        label: 'Email Address',
                                        prefix:
                                        Icons.email_outlined,
                                        validate: (v) {
                                          if (v.isEmpty)
                                            return 'Email is required';
                                          if (!isValidEmail(
                                              v.trim())) {
                                            return 'Invalid email format';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 18),
                                      defaultFormField(
                                        controller: phoneController,
                                        type: TextInputType.phone,
                                        label: 'Phone Number',
                                        prefix:
                                        Icons.phone_outlined,
                                        validate: (v) => v.length != 10
                                            ? 'Must be 10 digits'
                                            : null,
                                      ),
                                      const SizedBox(height: 18),
                                      defaultFormField(
                                        controller: IDController,
                                        type:
                                        TextInputType.number,
                                        label: 'National ID',
                                        prefix:
                                        Icons.badge_outlined,
                                        validate: (v) => v.length != 10
                                            ? 'Must be 10 digits'
                                            : null,
                                      ),
                                      const SizedBox(height: 18),
                                      defaultFormField(
                                        controller:
                                        passwordController,
                                        type: TextInputType
                                            .visiblePassword,
                                        label: 'Password',
                                        prefix:
                                        Icons.lock_outline,
                                        isPassword:
                                        cubit.isPassword,
                                        suffix: cubit.suffix,
                                        suffixPressed: cubit
                                            .changePasswordVisibility,
                                        validate: (v) => v.isEmpty
                                            ? 'Password required'
                                            : null,
                                      ),
                                      const SizedBox(height: 34),

                                      // ===== BUTTON =====
                                      SizedBox(
                                        width: double.infinity,
                                        height: 54,
                                        child: ElevatedButton(
                                          style: ElevatedButton
                                              .styleFrom(
                                            backgroundColor:
                                            const Color(
                                                0xFF1F7A5C),
                                            elevation: 6,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (!formKey.currentState!
                                                .validate()) return;

                                            final User = user(
                                              username:
                                              emailController.text,
                                              name:
                                              nameController.text,
                                              phone:
                                              phoneController.text,
                                              id: IDController.text,
                                              imageUrl: 'image path',
                                              password:
                                              passwordController
                                                  .text,
                                            );

                                            try {
                                              final adminUid =
                                                  FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid;
                                              await cubit.userRegister(
                                                  User: User);

                                              navigatetoWithTransition(
                                                context,
                                                admin_main_screen(
                                                    uid: adminUid),
                                                color: const Color(
                                                    0xFF1F7A5C),
                                                message:
                                                'Preparing admin dashboard...',
                                              );

                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'User added successfully'),
                                                ),
                                              );
                                            } catch (_) {
                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Invalid information'),
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'Create User',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
