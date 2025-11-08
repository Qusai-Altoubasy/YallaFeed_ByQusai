import 'package:flutter/material.dart';

import '../../../components/components.dart';

class add_new_donation extends StatefulWidget {
  @override
  State<add_new_donation> createState() => _add_new_donation();
}

class _add_new_donation extends State<add_new_donation> {
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
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC),
      ),
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
                      'Add new meal',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 8.0
                    ),
                    //  Subtitle
                    Text(
                      'We hope you donate a good meal.',
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
                                return 'please enter type of meal ';
                              }
                            },
                            label: 'Type of meal',
                            prefix: Icons.fastfood_outlined,
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
                            label: 'How many people you will serve?',
                            prefix: Icons.group,
                          ),
                          SizedBox(
                            height: 30,
                          ),
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
                                  "Submit",
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