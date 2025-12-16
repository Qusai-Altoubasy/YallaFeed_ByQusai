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

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var IDController = TextEditingController();
  var passwordController = TextEditingController();

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
              elevation: 0,
              backgroundColor: Color(0xFFB3E5FC),
              // leading: IconButton(
              //     onPressed: (){
              //       Navigator.pop(context);
              //     },
              //     icon: Icon(Icons.arrow_back_outlined,color: Colors.black,)),
            ),
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
                          'Add new user',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.blue[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'please enter your name';
                                    }
                                    return null;
                                  },
                                  label: 'Name',
                                  prefix: Icons.person,
                                ),
                                const SizedBox(height: 15),
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
                                    return null;
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
                                    return null;
                                  },
                                  label: 'National ID',
                                  prefix: Icons.badge,
                                ),
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 15),
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
                                    function: () async{
                                      if (formKey.currentState!.validate()) {
                                        user User=user(
                                          username: emailController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          id: IDController.text,
                                          imageUrl: 'image path',
                                          password: passwordController.text,
                                        );
                                        try {
                                          await cubit.userRegister(User: User);
                                          final adminUid = FirebaseAuth.instance.currentUser!.uid;
                                          navigateto(context,admin_main_screen(uid: adminUid));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text(
                                                'Adding new user successfully')),
                                          );
                                        }

                                        catch (e){

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text(
                                                'The informations are not valid')),
                                          );
                                        }
                                      }
                                    },
                                    text: "Add",
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

      ),
    );
  }
}