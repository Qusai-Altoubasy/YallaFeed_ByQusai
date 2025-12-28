import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/classes/user.dart';
import 'package:qusai/screens/user/deleviry/accept.dart';
import 'package:qusai/shared/shared.dart';
import '../../../classes/donation.dart';


class view_available_requests extends StatefulWidget {
  const view_available_requests({super.key});

  @override
  State<view_available_requests> createState() => _view_available_requests();
}

class _view_available_requests extends State<view_available_requests> {

  List<String> Readdeliverydonations = [];
  bool loading = true;

  final Map<String, Map<String, dynamic>> _usersCache = {};
  final Set<String> _loadingUids = {};


  @override
  void initState() {
    super.initState();
    loadReaddeliverydonations();
  }

  Future<void> loadReaddeliverydonations() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_delivery_donations')
        .where('userId', isEqualTo: userid)
        .get();

    Readdeliverydonations =
        readSnapshot.docs.map((e) => e['donationid'] as String).toList();

    setState(() {
      loading = false;
    });
  }

  Future<void> _ensureUserLoaded(String uid) async {
    if (uid.isEmpty) return;
    if (_usersCache.containsKey(uid)) return;
    if (_loadingUids.contains(uid)) return;

    _loadingUids.add(uid);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final data = doc.data();
      if (data != null) {
        _usersCache[uid] = data;
      }
    } finally {
      _loadingUids.remove(uid);
    }
  }

  Future<void> _preloadUsersForDocs(List<QueryDocumentSnapshot> docs) async {
    final Set<String> uids = {};

    for (final d in docs) {
      final data = d.data() as Map<String, dynamic>;
      final donorUid = (data['donoruid'] ?? '').toString();
      final receiverUid = (data['reciveruid'] ?? '').toString();

      if (donorUid.isNotEmpty) uids.add(donorUid);
      if (receiverUid.isNotEmpty) uids.add(receiverUid);
    }

    await Future.wait(uids.map(_ensureUserLoaded));
    if (mounted) setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('status', isEqualTo: 'accepted')
            .orderBy('recivetime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final docs = snapshot.data!.docs
              .where((doc) => !Readdeliverydonations.contains(doc.id))
              .toList();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _preloadUsersForDocs(docs);
          });


          if (docs.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme:
                const IconThemeData(color: Color(0xFF1F7A5C)),
                title: const Text(
                  'Available Requests',
                  style: TextStyle(
                    color: Color(0xFF1A202C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: const Center(
                child: Text('There are no new Requests.'),
              ),
            );
          }


          return Scaffold(

            backgroundColor: const Color(0xFFF5F3FA),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Color(0xFF6A1B9A)),
              title: const Text(
                'Available Requests',
                style: TextStyle(
                  color: Color(0xFF1A202C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final item = docs[index];

                donation current = donation(
                    mealType: item['mealType'],
                    numberOfPeople: item['numberOfPeople'],
                    status: item['status'],
                    imagePath: item['imagePath'],
                    category: item['category'],
                    fromlocation: item['fromlocation'],
                    description: item['description'],
                    donatetime: item['donatetime'].toDate(),
                    did: item['did'],
                    donoruid: item['donoruid'],
                    reciveruid: item['reciveruid'],
                    tolocation: item['tolocation'],
                );


                return Card(
                  elevation: 6,
                  shadowColor: Colors.black12,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6A1B9A).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: FutureBuilder(
                                future: getApplicationDocumentsDirectory(),
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return const Center(
                                        child:
                                        CircularProgressIndicator(strokeWidth: 2));
                                  }
                                  final file = File(current.imagePath);
                                  if (!file.existsSync()) {
                                    return Icon(Icons.fastfood_outlined,
                                        color: Color(0xFF6A1B9A));
                                  }

                                  return Image.file(file, fit: BoxFit.cover);

                                }
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From: ${current.fromlocation}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'To : ${current.tolocation}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.redAccent),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('read_delivery_donations')
                                    .doc('${userid}_${docs[index].id}')
                                    .set({
                                  'userId': userid,
                                  'donationid': docs[index].id,
                                });

                                setState(() {
                                  Readdeliverydonations.add(docs[index].id);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.check_box,
                                  color: Color(0xFF6A1B9A)),
                              tooltip: 'View details',
                              onPressed: () {

                                final donor = _usersCache[current.donoruid];
                                final receiver = _usersCache[current.reciveruid];

                                final donorName = donor?['name'] ?? 'Loading...';
                                final donorPhone = donor?['phone'] ?? '';

                                final receiverName = receiver?['name'] ?? 'Loading...';
                                final receiverPhone = receiver?['phone'] ?? '';

                                receiverdonationdetails = current;

                                navigatetoWithTransition(
                                  context,
                                  accept(donorphone: donorPhone,receiverphone: receiverPhone,),
                                  color: const Color(0xFF5C6BC0),
                                  message: 'Loading donation details...',
                                );

                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}
