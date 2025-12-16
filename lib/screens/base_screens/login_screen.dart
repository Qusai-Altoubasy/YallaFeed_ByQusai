import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/login/login_cubit.dart';
import 'package:qusai/cubits/login/login_states.dart';
import 'package:qusai/screens/register/register_options.dart';
import 'package:qusai/shared/shared.dart';
import '../../components/components.dart';
import '../admin/admin_main_screen.dart';
import '../charity/charity_main_screen.dart';
import '../user/user_layout.dart';


class login_screen extends StatelessWidget {
  var EmailController=TextEditingController();

  var PasswordController=TextEditingController();


  var formKey=GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
         create: (BuildContext context) => login_cubit(),
       child: BlocConsumer<login_cubit , login_states>(
         listener: (context, state) {},
           builder: (context, state) {
             var cubit = login_cubit.get(context);
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

                   child: Form(
                     key:formKey,
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
                         defaultFormField(
                           controller:EmailController,
                           label:"Email Address",
                           prefix:Icons.email_outlined,
                           type:TextInputType.emailAddress,
                           validate:(String value){
                             if(value.isEmpty){
                               return "Email must not be empty";
                             }  else if (!isValidEmail(value.trim())) {
                               return 'Please enter a valid email address';
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
                             if(value.isEmpty){
                               return "password must not be empty";
                             }
                             return null;
                           },
                           suffix:login_cubit.get(context).suffix,
                           isPassword:login_cubit.get(context).isPassword,
                           suffixPressed:(){
                            login_cubit.get(context).changePasswordVisibility();

                           },

                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Container(
                           width:double.infinity,
                           alignment: Alignment.centerRight,


                           child:
                           TextButton(
                               onPressed: () {
                                 var resetEmailController = TextEditingController();

                                 if (EmailController.text.isNotEmpty) {
                                   resetEmailController.text = EmailController.text;
                                 }

                                 showDialog(
                                   context: context,
                                   builder: (context) => AlertDialog(
                                     title: const Text('Reset Password'),
                                     content: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         const Text('Enter your email to receive a reset link:'),
                                         const SizedBox(height: 10),
                                         TextFormField(
                                           controller: resetEmailController,
                                           keyboardType: TextInputType.emailAddress,
                                           decoration: const InputDecoration(
                                             hintText: "Email Address",
                                             prefixIcon: Icon(Icons.email),
                                             border: OutlineInputBorder(),
                                           ),
                                         ),
                                       ],
                                     ),
                                     actions: [
                                       TextButton(
                                         onPressed: () => Navigator.pop(context),
                                         child: const Text('Cancel'),
                                       ),
                                       TextButton(
                                         onPressed: () async {
                                           if (resetEmailController.text.isNotEmpty) {
                                             try {
                                               await FirebaseAuth.instance.sendPasswordResetEmail(
                                                   email: resetEmailController.text.trim());

                                               Navigator.pop(context);

                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 const SnackBar(
                                                   content: Text("Reset link sent! Check your email"),
                                                   backgroundColor: Colors.green,
                                                 ),
                                               );

                                             } on FirebaseAuthException catch (e) {
                                               Navigator.pop(context);

                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 SnackBar(
                                                   content: Text(e.message ?? "Error"),
                                                   backgroundColor: Colors.red,
                                                 ),
                                               );
                                             }
                                           } else {
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               const SnackBar(
                                                 content: Text("Please enter email inside the box"),
                                                 backgroundColor: Colors.orange,
                                               ),
                                             );
                                           }
                                         },
                                         child: const Text('Send'),
                                       ),
                                     ],
                                   ),
                                 );
                               },
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
                           text: "log In",
                           function: ()async {
                             if (formKey.currentState!.validate()){
                             try{
                               await cubit.userLogin(email: EmailController.text.trim(), password: PasswordController.text.trim());
                               navigateto(
                                   context,
                                   StreamBuilder(
                                     stream: FirebaseAuth.instance.authStateChanges(),
                                     builder: (context, snapshot) {
                                       if (snapshot.connectionState == ConnectionState.waiting) {
                                         return const Center(child: CircularProgressIndicator());
                                       }
                                       //   final uid = FirebaseAuth.instance.currentUser!.uid;
                                       final user = FirebaseAuth.instance.currentUser;
                                       if (user == null) {
                                         return login_screen();
                                       }

                                       final uid = user.uid;
                                       userid = uid;

                                       return FutureBuilder<String?>(
                                         future: getUserType(uid),
                                         builder: (context, userSnapshot) {

                                           if (userSnapshot.connectionState == ConnectionState.waiting) {
                                             return const Center(child: CircularProgressIndicator());
                                           }


                                           if (!userSnapshot.hasData || userSnapshot.data == null) {
                                             WidgetsBinding.instance.addPostFrameCallback((_) {
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 const SnackBar(
                                                   content: Text('The account has been deleted'),
                                                   backgroundColor: Colors.red,
                                                 ),
                                               );
                                               FirebaseAuth.instance.signOut();
                                             });
                                             return login_screen();
                                           }


                                           final type = userSnapshot.data!;
                                           usertype = type;

                                           if (type == 'user') {
                                             return user_layout(uid: uid);
                                           } else if (type == 'charity') {
                                             return charity_main_screen(uid: uid);
                                           } else if (type == 'admin') {
                                             return admin_main_screen(uid: uid,);
                                           } else {
                                             WidgetsBinding.instance.addPostFrameCallback((_) {
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 const SnackBar(
                                                   content: Text('The account has been deleted'),
                                                   backgroundColor: Colors.red,
                                                 ),
                                               );
                                               FirebaseAuth.instance.signOut();
                                             });
                                             return login_screen();
                                           }
                                         },
                                       );

                                     },
                                   )                               );
                             }
                             on FirebaseException catch(e) {
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(content: Text(
                                     'The username or password is incorrect. ')),
                               );

                             }
                           }
                             },
                           background: Colors.white,
                           textColor: const Color(0xFF4A90E2),
                           height: 55,
                         ),
                         SizedBox(
                           height: 20,
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
           ),
     );
  }
}