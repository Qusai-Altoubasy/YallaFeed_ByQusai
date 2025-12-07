import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/shared/shared.dart';

import '../base_screens/login_screen.dart';

class manage_accounts extends StatefulWidget {


  @override
  State<manage_accounts> createState() => _manage_accountsState();
}

class _manage_accountsState extends State<manage_accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        // leading: IconButton(
          // icon: const Icon(Icons.arrow_back_outlined),
          // onPressed: () {
          //   Navigator.pop(context);
          // },
        // ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for users',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder:(context , index ) => buildChatItem(context),
                separatorBuilder: (context , index ) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: 20),
          ),
        ],
      ),
    );
  }
}

Widget buildChatItem(context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: Text(
          'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(width: 8,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              navigateto(context, another_profile(uid: '56',));
            },
            icon: Icon(Icons.remove_red_eye, size: 16),
            label: Text('View'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.withOpacity(0.5),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(width: 8,),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.delete, size: 16),
            label: Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.5),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    ],
  ),
);