import 'package:flutter/material.dart';
import '../../components/components.dart';

class charity_register extends StatefulWidget {
  @override
  State<charity_register> createState() => _charity_register();
}

class _charity_register extends State<charity_register> {
  bool ispassword = true;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var IDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // 🌟 Gradient background
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //  Title
                    Text(
                      'REGISTER',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    //  Subtitle
                    Text(
                      'Register now to donate or receive food easily',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30.0),

                    // Form fields inside a card
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your name of organization ';
                              }
                            },
                            label: 'Name of organization',
                            prefix: Icons.volunteer_activism,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: IDController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your ID from a Governmental organization ';
                              }
                            },
                            label: 'ID from a Governmental organization',
                            prefix: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ispassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isPassword: ispassword,
                            suffixPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: confirmpasswordController,
                            type: TextInputType.visiblePassword,
                            suffix: ispassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isPassword: ispassword,
                            suffixPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              } else if (passwordController.text !=
                                  confirmpasswordController.text) {
                                return 'password does not match';
                              }
                            },
                            label: 'Confirm password',
                            prefix: Icons.lock_outline,
                          ),
                          const SizedBox(height: 30.0),

                          //  Register button with gradient
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}