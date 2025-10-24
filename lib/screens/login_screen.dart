import 'package:flutter/material.dart';
import 'package:qusai/components/components.dart';

class login_screen extends StatelessWidget {
  const login_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[300],
      //   title: Text(
      //     ' Yalla feed',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
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
              text_box(
                Type: TextInputType.text,
                Label: 'email address',
                Prefix: Icon(Icons.email),
              ),
              SizedBox(
                height: 10,
              ),
              text_box(
                  Type: TextInputType.visiblePassword, 
                  Label: 'password', 
                  Prefix: Icon(Icons.lock),
                  Postfix: Icon(Icons.remove_red_eye_outlined),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
