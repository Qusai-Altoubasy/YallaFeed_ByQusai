import 'package:flutter/material.dart';
import 'package:qusai/screens/register/register_options.dart';
import 'package:qusai/screens/temp.dart';
import 'package:qusai/shared/shared.dart';
import '../../components/components.dart';

class login_screen extends StatefulWidget {
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  var EmailController=TextEditingController();

  var PasswordController=TextEditingController();

  bool ispassword=true;
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4a90e2),Color(0xff50e3c2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 60),

            child: Form(key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      boxShadow: const[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.white,
                      size:80,
                    ),

                  ),
                  SizedBox(height: 30),


                  Text(
                    'Welcome !',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          )
                        ]
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign in to continue fighting food waste',
                    style: TextStyle(
                      fontSize: 18,

                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defaultFormField(controller:EmailController,
                    label:"Email Address",
                    prefix:Icons.email_outlined,
                    type:TextInputType.emailAddress,
                    validate:(String value){
                      if(value.isEmpty|| value==null){
                        return "Email must not be empty";
                      }
                      return null;
                    },

                  ),

                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(controller:PasswordController,
                    label:"Password",
                    prefix:Icons.lock,
                    type:TextInputType.visiblePassword,
                    validate:(String value){
                      if(value.isEmpty|| value==null){
                        return "password must not be empty";
                      }
                      return null;
                    },
                    suffix:ispassword?Icons.visibility:Icons.visibility_off,
                    isPassword:ispassword,
                    suffixPressed:(){
                      setState(() {
                        ispassword=!ispassword;
                      });

                    },

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width:double.infinity,
                    alignment: Alignment.centerRight,


                    child:
                    TextButton(onPressed: (){},
                        child:Text(
                          "Forget password?",
                          style:TextStyle(color:Colors.white70,fontSize:14),
                        )
                    ),
                  ),


                  SizedBox(
                    height: 20,
                  ),
                  // sign in
                  defaultButton(
                    text: "Sign In",
                    function: () {
                      if (formKey.currentState!.validate()) {
                        // Your login logic here
                      }
                    },
                    background: Colors.white,
                    textColor: const Color(0xFF4A90E2),
                    height: 55,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // temp for just showing work
                  defaultButton(
                      function: (){
                        navigateto(context, temp());
                      },
                      text: "next  (temp.)",
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account ?",style:TextStyle(color:Colors.white70,fontSize:15),),
                      TextButton(
                          onPressed: (){
                            navigateto(context, register_option());
                            },
                          child: Text(
                            "Register Now",
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:17,
                                fontWeight: FontWeight.bold,
                            ),
                      )),
                    ],)
                ],
              ),
            ),

          ),
        ),

      ),
    );
  }
}