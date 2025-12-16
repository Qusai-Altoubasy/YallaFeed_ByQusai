import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/cubits/charity/charity_cubit.dart';
import 'package:qusai/shared/shared.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';

import '../../classes/charity.dart';
import '../../classes/user.dart';
import '../../cubits/charity/charity_states.dart';
import '../../cubits/user/user_states.dart';



class manage_accounts extends StatefulWidget {
  @override
  State<manage_accounts> createState() => _manage_accountsState();
}

class _manage_accountsState extends State<manage_accounts> {

  String searchText = '';


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => user_cubit()..getAllUsers()),
        BlocProvider(create: (_) => charity_cubit()..getAllCharities()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Accounts'),
          elevation: 0,
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
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for users or charities',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<user_cubit, user_states>(
                      builder: (context, state) {
                        var userCubit = user_cubit.get(context);
                        final filteredUsers = userCubit.users.where((u) {
                          final name = u.name ?? '';
                          return name.toLowerCase().contains(searchText);
                        }).toList();
                        if (userCubit.users.isEmpty) {
                          return SizedBox();
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Users',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredUsers.length,
                              separatorBuilder: (_, __) => Divider(),
                              itemBuilder: (context, index) {
                                var model = filteredUsers[index];
                                return buildChatItem(
                                    context, model.name, model.databaseID,
                                    model.imageUrl, 'users');
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    BlocBuilder<charity_cubit, charity_states>(
                      builder: (context, state) {
                        var charityCubit = charity_cubit.get(context);
                        final filteredCharities = charityCubit.charities.where((c) {
                          final name = c.name ?? '';
                          return name.toLowerCase().contains(searchText);
                        }).toList();
                        if (charityCubit.charities.isEmpty) {
                          return SizedBox();
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Charities',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredCharities.length,
                              separatorBuilder: (_, __) => Divider(),
                              itemBuilder: (context, index) {
                                var model = filteredCharities[index];
                                return buildChatItem(
                                    context, model.name, model.ID,
                                    model.imageUrl, 'charity');
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildChatItem(BuildContext context, String? name, String? uid,
    String? image, String collection) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          image!,
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: Text(
          name!,
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
              navigateto(context, another_profile(uid: uid!,));
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
            onPressed: () {
             showDialog(
             context: context,
             builder: (context) => AlertDialog(
             title: Text('Delete Account'),
             content:
             Text('Are you sure you want to delete this account?'),
             actions: [
             TextButton(
             onPressed: () => Navigator.pop(context),
             child: Text('Cancel')),
             TextButton(
             onPressed: () {
             FirebaseFirestore.instance
             .collection(collection)
             .doc(uid)
             .delete();
              Navigator.pop(context);   Navigator.pop(context);
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text(
                   'The account deleted successfully')),
             );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red))),
               ],
               ));
                 },

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