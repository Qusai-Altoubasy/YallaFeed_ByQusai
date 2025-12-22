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
      create: (_) => user_cubit()..getAllUsers(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F7F6),
        appBar: AppBar(
          title: const Text(
            'Manage Users',
            style: TextStyle(
              color: Color(0xFF1A202C),
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF1F7A5C)),
        ),
        body: Column(
          children: [
            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search users',
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

            // ===== LIST =====
            Expanded(
              child: BlocBuilder<user_cubit, user_states>(
                builder: (context, state) {
                  final cubit = user_cubit.get(context);

                  final filteredUsers = cubit.users.where((u) {
                    final name = (u.name ?? '').toLowerCase();
                    final hasPermission = u.havepermission == true;
                    return hasPermission &&
                        name.contains(searchText);
                  }).toList();

                  if (state is loading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (filteredUsers.isEmpty) {
                    return const Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return _userCard(
                        context,
                        filteredUsers[index],
                      );
                    },
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

// ===== USER CARD =====
Widget _userCard(BuildContext context, user model) {
  return Card(
    margin: const EdgeInsets.only(bottom: 14),
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
            backgroundImage: NetworkImage(
              model.imageUrl ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              model.name ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.visibility_outlined,
                color: Color(0xFF1F7A5C)),
            tooltip: 'View profile',
            onPressed: () {
              navigatetoWithTransition(
                context,
                another_profile(uid: model.databaseID),
                color: const Color(0xFF455A64),
                message: 'Opening profile...',
              );

            },
          ),
          IconButton(
            icon: const Icon(Icons.cancel_outlined,
                color: Colors.redAccent),
            tooltip: 'Decline permission',
            onPressed: () {
              user_cubit
                  .get(context)
                  .declinePermission(model.databaseID);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Permission declined'),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
