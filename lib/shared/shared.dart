
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String charity_name = 'Charity Name';
String admin_name = 'Admin Name';
String user_name = 'User Name';

void navigateto(context, Widget page) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=> page,
      ),
  );
}



