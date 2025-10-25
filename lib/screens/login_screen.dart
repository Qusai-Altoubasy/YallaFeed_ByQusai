import 'package:flutter/material.dart';
import '../components/components.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          child: Form(key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome !',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300],
                  ),

                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in to continue fighting food waste',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300],
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
                    if(value.isEmpty){
                      return "email must not be empty";
                    }
                    return null;
                  },

                ),

                SizedBox(
                  height: 10,
                ),
                defaultFormField(controller:PasswordController,
                  label:"Password",
                  prefix:Icons.lock,
                  type:TextInputType.visiblePassword,
                  validate:(String value){
                    if(value.isEmpty){
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
                Container(width:double.infinity,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){},
                          child:Text(
                            "Forget password?",
                            style:TextStyle(color:Colors.blue[300],fontSize:15),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                defaultButton(
                    function: (){},
                    text: "Sign in",
                    background:Colors.blue[300]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account ?",style:TextStyle(color:Colors.black,fontSize:15),),
                    TextButton(onPressed: (){}, child:
                    Text("Register Now",style:TextStyle(color:Colors.blue[300],fontSize:20),

                    )),
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}