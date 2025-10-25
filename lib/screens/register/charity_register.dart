import 'package:flutter/material.dart';

import '../../components/components.dart';

class charity_register extends StatefulWidget {
  @override
  State<charity_register> createState() => _charity_register();
}

class _charity_register extends State<charity_register> {
  bool ispassword=true;

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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.blue[300],
                    ),
                  ),
                  Text(
                    'Register now to donate or receive food easily',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your name of organization ';
                      }
                    },
                    label: 'Name of organization ',
                    prefix: Icons.volunteer_activism,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
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
                  SizedBox(
                    height: 15.0,
                  ),

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
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: IDController,
                    type: TextInputType.number,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your ID from a Governmental organization ';
                      }
                    },
                    label: 'ID from a Governmental organization ',
                    prefix: Icons.badge_outlined,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    suffix:ispassword?Icons.visibility:Icons.visibility_off,
                    onSubmit: (value) {},
                    isPassword:ispassword,
                    suffixPressed: () {
                      setState(() {
                        ispassword=!ispassword;
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
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: confirmpasswordController,
                    type: TextInputType.visiblePassword,
                    suffix:ispassword?Icons.visibility:Icons.visibility_off,
                    onSubmit: (value) {},
                    isPassword:ispassword,
                    suffixPressed: () {
                      setState(() {
                        ispassword=!ispassword;
                      });
                    },
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'password is too short';
                      }
                      else if (passwordController.text!=confirmpasswordController.text){
                        return 'password does not match';
                      }
                    },
                    label: 'Confirm password',
                    prefix: Icons.lock_outline,
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  defaultButton(
                      function: (){},
                      text: "Register",background:Colors.blue[300]
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}