import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../classes/charity.dart';
import '../../components/components.dart';
import '../../cubits/register/register_cubit.dart';
import '../../cubits/register/register_states.dart';



class charity_register extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var IDController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => register_cubit(),
      child: BlocConsumer<register_cubit , register_states>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = register_cubit.get(context);
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
                            'Register now to accept people in need.',
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
                                    return null;
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
                                    }  else if (!isValidEmail(value.trim())) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
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
                                    return null;
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
                                    return null;
                                  },
                                  label: 'ID from a Governmental organization',
                                  prefix: Icons.badge_outlined,
                                ),
                                const SizedBox(height: 15.0),
                                defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  suffix: register_cubit.get(context).suffix,
                                  isPassword: register_cubit.get(context).isPassword,
                                  suffixPressed: () {
                                    register_cubit.get(context).changePasswordVisibility();
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'password is too short';
                                    }
                                    return null;
                                  },
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                ),
                                const SizedBox(height: 15.0),
                                defaultFormField(
                                  controller: confirmpasswordController,
                                  type: TextInputType.visiblePassword,
                                  suffix: register_cubit.get(context).suffix,
                                  isPassword: register_cubit.get(context).isPassword,
                                  suffixPressed: () {
                                    register_cubit.get(context).changePasswordVisibility();
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'password is too short';
                                    } else if (passwordController.text !=
                                        confirmpasswordController.text) {
                                      return 'password does not match';
                                    }
                                    return null;
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
                                    onPressed:  () async{
                                      if (formKey.currentState!.validate()) {
                                        charity Charity=charity(
                                          username: emailController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          id: IDController.text,
                                          imageUrl: 'image path',
                                          password: passwordController.text,
                                        );
                                        try {
                                          await cubit.charityRegister(Charity : Charity);
                                          Navigator.pop(context); Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text(
                                                'Signed up successfully')),
                                          );
                                        }

                                        on FirebaseException catch(e) {

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text(
                                                'The informations are not valid')),
                                          );
                                        }
                                      }
                                    },
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
        },
      ),
    );
  }
}