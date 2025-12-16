import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/shared/shared.dart';

import '../../classes/user.dart';
import '../../cubits/user/user_states.dart';

class manage_accounts extends StatefulWidget {

  @override
  State<manage_accounts> createState() => _manage_accountsState();
}

class _manage_accountsState extends State<manage_accounts> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
create: (context) => user_cubit()..getAllUsers(),
      child: Scaffold(
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
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
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
              child: BlocBuilder<user_cubit, user_states>(
                builder: (context, state) {
                  final cubit = user_cubit.get(context);
                  final filteredUsers = cubit.users.where((u) {
                    final name = (u.name ?? '').toLowerCase();
                    final hasPermission = u.havepermission == true;
                    return hasPermission && name.contains(searchText);
                  }).toList();

                  if (state is loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (filteredUsers.isEmpty) {
                    return const Center(child: Text('No users found'));
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        buildChatItem(context, filteredUsers[index]),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: filteredUsers.length,
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget buildChatItem(BuildContext context , user model) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          model.imageUrl ??
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: Text(
          model.name ??
          '',
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
              navigateto(context, another_profile(uid: model.databaseID));
            },
            icon: Icon(Icons.person, size: 16),
            label: Text('profile'),
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
              user_cubit.get(context).declinePermission(model.databaseID);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Permission declined'),
                ),
              );
            },
            icon: Icon(Icons.remove_circle, size: 16),
            label: Text('Decline'),
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
