import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/cubits/charity/charity_cubit.dart';
import 'package:qusai/shared/shared.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
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
        backgroundColor: const Color(0xFFF3F7F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Manage Accounts',
            style: TextStyle(
              color: Color(0xFF1A202C),
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFF1F7A5C)),
        ),
        body: Column(
          children: [
            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (v) => setState(() {
                  searchText = v.toLowerCase();
                }),
                decoration: InputDecoration(
                  hintText: 'Search users or charities',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== USERS =====
                    BlocBuilder<user_cubit, user_states>(
                      builder: (context, state) {
                        final cubit = user_cubit.get(context);
                        final users = cubit.users.where((u) {
                          return (u.name ?? '')
                              .toLowerCase()
                              .contains(searchText);
                        }).toList();

                        if (users.isEmpty) return const SizedBox();

                        return _section(
                          title: 'Users',
                          children: users.map((u) {
                            return _accountTile(
                              context: context,
                              name: u.name!,
                              image: u.imageUrl!,
                              uid: u.databaseID!,
                              collection: 'users',
                            );
                          }).toList(),
                        );
                      },
                    ),

                    // ===== CHARITIES =====
                    BlocBuilder<charity_cubit, charity_states>(
                      builder: (context, state) {
                        final cubit = charity_cubit.get(context);
                        final charities = cubit.charities.where((c) {
                          return (c.name ?? '')
                              .toLowerCase()
                              .contains(searchText);
                        }).toList();

                        if (charities.isEmpty) return const SizedBox();

                        return _section(
                          title: 'Charities',
                          children: charities.map((c) {
                            return _accountTile(
                              context: context,
                              name: c.name!,
                              image: c.imageUrl!,
                              uid: c.ID!,
                              collection: 'charity',
                            );
                          }).toList(),
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

// ===== SECTION =====
Widget _section({required String title, required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    ),
  );
}

// ===== ACCOUNT TILE =====
Widget _accountTile({
  required BuildContext context,
  required String name,
  required String image,
  required String uid,
  required String collection,
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.visibility_outlined,
                color: Color(0xFF1F7A5C)),
            onPressed: () {
              navigatetoWithTransition(
                context,
                another_profile(uid: uid),
                color: const Color(0xFF455A64),
                message: 'Opening profile...',
              );


            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: Colors.redAccent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                      'Are you sure you want to delete this account?'),
                  actions: [
                    TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text('Cancel')),
                    TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection(collection)
                            .doc(uid)
                            .delete();

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Account deleted successfully')),
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
