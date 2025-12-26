import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/shared/shared.dart';
Future<int?> showFamilySizeDialog(BuildContext context) async {
  final controller = TextEditingController();
  int? result;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Family Size Required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter the number of family members for this receiver before accepting the request.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Family members',
                  prefixIcon: const Icon(Icons.people_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      final value = int.tryParse(controller.text);
                      if (value != null && value > 0) {
                        result = value;
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return result;
}
class accept_reject_new_user extends StatelessWidget {
  const accept_reject_new_user({super.key, required this.cid});
  final String cid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: const Text(
          'New Requests',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1F7A5C)),
        titleTextStyle: const TextStyle(
          color: Color(0xFF1A202C),
          fontSize: 18,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
        FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox_outlined,
                      size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No requests yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final uid = doc['uid'];
              final name = doc['name'];

              return _requestCard(
                context: context,
                uid: uid,
                name: name,
                cid: cid
              );
            },
          );
        },
      ),
    );
  }
}

// ===== REQUEST CARD =====
Widget _requestCard({
  required BuildContext context,
  required String uid,
  required String name,
  required String cid
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 14),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          navigatetoWithTransition(
            context,
            another_profile(uid: uid),
            color: const Color(0xFF26A69A),
            message: 'Opening profile...',
          );

        },
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.check_circle,
                  color: Color(0xFF1F7A5C)),
              tooltip: 'Accept',
              onPressed: () async {
                // Fetch receiver data
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get();

                int familySize = userDoc.data()?['familySize'] ?? 0;

                // If family size not set, force charity to enter it
                if (familySize == 0) {
                  final enteredSize = await showFamilySizeDialog(context);
                  if (enteredSize == null) return;

                  familySize = enteredSize;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({
                    'familySize': familySize,
                  });
                }

                // Accept user
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({
                  'havepermission': true,
                  'askpermission': false,
                  'nameofcharity': cid,
                });

                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(uid)
                    .delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Receiver accepted successfully'),
                  ),
                );
              },

            ),
            IconButton(
              icon: const Icon(Icons.cancel,
                  color: Colors.redAccent),
              tooltip: 'Reject',
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({
                  'askpermission': false,
                });

                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(uid)
                    .delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request rejected'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}