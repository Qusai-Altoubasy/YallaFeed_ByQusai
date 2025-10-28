import 'package:flutter/material.dart';
import '../../components/components.dart';

class user_register extends StatefulWidget {
  @override
  State<user_register> createState() => _user_register();
}

class _user_register extends State<user_register> {
  bool ispassword = true;

  var formKey = GlobalKey<FormState>();

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
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
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.blue[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Register now to donate or receive food easily',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Card-like container for inputs
                  Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                            controller: firstnameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your first name';
                              }
                            },
                            label: 'First Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(height: 15),
                          defaultFormField(
                            controller: lastnameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your last name';
                              }
                            },
                            label: 'Last Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(height: 15),
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
                          const SizedBox(height: 15),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number';
                              } else if (phoneController.text.length != 10) {
                                return 'The phone must be 10 numbers';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 15),
                          defaultFormField(
                            controller: IDController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your ID number';
                              } else if (IDController.text.length != 10) {
                                return 'The ID must be 10 numbers';
                              }
                            },
                            label: 'National ID',
                            prefix: Icons.badge,
                          ),
                          const SizedBox(height: 15),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ispassword ? Icons.visibility : Icons.visibility_off,
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
                          const SizedBox(height: 15),
                          defaultFormField(
                            controller: confirmpasswordController,
                            type: TextInputType.visiblePassword,
                            suffix: ispassword ? Icons.visibility : Icons.visibility_off,
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
                            label: 'Confirm Password',
                            prefix: Icons.lock_outline,
                          ),
                          const SizedBox(height: 30),
                          //  Modern Button

                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: defaultButton(
                              function: () {},
                              text: "Register",
                              radius: 25,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}