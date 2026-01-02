import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/screens/user/deleviry/history/cancel.dart';
import 'package:qusai/screens/user/deleviry/history/delivered.dart';
import 'package:qusai/screens/user/deleviry/history/donation_det.dart';

import '../../../../classes/donation.dart';
import '../../../../shared/shared.dart';


class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _history();
}

class _history extends State<history> {

  List<String> Readdeliveryhistory = [];
  bool loading = true;

  final Map<String, Map<String, dynamic>> _usersCache = {};
  final Set<String> _loadingUids = {};

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
  void initState() {
    super.initState();
    LoadReaddeliveryhistory();
  }
  Future<void> LoadReaddeliveryhistory() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_delivery_history')
        .where('userId', isEqualTo: userid)
        .get();

    Readdeliveryhistory =
        readSnapshot.docs.map((e) => e['donationid'] as String).toList();

    setState(() {
      loading = false;
    });
  }

  Color _statusColor(String status) {
    if (status == 'delivering') return Colors.orange;
    if (status == 'delivered') return Colors.green;
    return Colors.blue;
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
            .where('deleiveruid', isEqualTo: userid)
            .orderBy('deleviretime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final docs = snapshot.data!.docs
              .where((doc) => !Readdeliveryhistory.contains(doc.id))
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
                  'History',
                  style: TextStyle(
                    color: Color(0xFF1A202C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: const Center(
                child: Text('There are no donations.'),
              ),
            );
          }


          return Scaffold(
            backgroundColor: const Color(0xFFF4F6F8),
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                "History",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
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
                  deliverRated: item['deliverRated']
                );

                final statusColor = _statusColor(current.status);

                return Card(
                  elevation: 6,
                  shadowColor: Colors.black12,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.15),
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
                                      color: statusColor);
                                }

                                return Image.file(file, fit: BoxFit.cover);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Details
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
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  current.status=="delivered"?"delivered":
                                  current.status=="accepted"?'You are canceled the order':
                                  current.status=="delivering"?'You are delivering it':'Deliver by driver',
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Actions
                        Column(
                          children: [
                            if(current.status=='delivering')
                              IconButton(
                              icon: const Icon(Icons.local_shipping,
                                  color: Color(0xFF6A1B9A)),
                              tooltip: 'Finish the order',
                              onPressed: () {
                                final donor = _usersCache[current.donoruid];
                                final receiver = _usersCache[current.reciveruid];


                                final donorPhone = donor?['phone'] ?? '';


                                final receiverPhone = receiver?['phone'] ?? '';

                                receiverdonationdetails = current;
                                navigatetoWithTransition(
                                  context,
                                  donation_det( donorphone: donorPhone,  receiverphone: receiverPhone),
                                  color: const Color(0xFF5C6BC0),
                                  message: 'Loading donation details...',
                                );

                              },
                            ),
                            if(current.status=='delivering')
                              IconButton(
                                icon: const Icon(Icons.cancel,
                                    color: Color(0xFF6A1B9A)),
                                tooltip: 'Cancel the order',
                                onPressed: () {
                                  final donor = _usersCache[current.donoruid];
                                  final receiver = _usersCache[current.reciveruid];


                                  final donorPhone = donor?['phone'] ?? '';


                                  final receiverPhone = receiver?['phone'] ?? '';

                                  receiverdonationdetails = current;
                                  navigatetoWithTransition(
                                    context,
                                    cancel(donorphone: donorPhone, receiverphone: receiverPhone),
                                    color: const Color(0xFF5C6BC0),
                                    message: 'Loading donation details...',
                                  );

                                },
                              ),
                            if(current.status=='delivered' || current.status=='delivered by driver' || current.status=='accepted')
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Color(0xFF6A1B9A)),
                                tooltip: 'View details',
                                onPressed: () {
                                  final donor = _usersCache[current.donoruid];
                                  final receiver = _usersCache[current.reciveruid];


                                  final donorPhone = donor?['phone'] ?? '';


                                  final receiverPhone = receiver?['phone'] ?? '';

                                  receiverdonationdetails = current;
                                  navigatetoWithTransition(
                                    context,
                                    delivered(donorphone: donorPhone, receiverphone: receiverPhone),
                                    color: const Color(0xFF5C6BC0),
                                    message: 'Loading donation details...',
                                  );

                                },
                              ),
                            if(current.status=='delivered' || current.status=='delivered by driver' || current.status=='accepted')
                              IconButton(
                              icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('read_delivery_history')
                                    .doc('${userid}_${docs[index].id}')
                                    .set({
                                  'userId': userid,
                                  'donationid': docs[index].id,
                                });

                                setState(() {
                                  Readdeliveryhistory.add(docs[index].id);
                                });
                              },
                            ),
                            if(current.status=='delivered'&&!current.deliverRated)
                              IconButton(
                              onPressed: () {
                                _showRatingDialog(context, current.donoruid, current.reciveruid, current.did);
                              },
                              icon: const Icon(Icons.star_border, color: Colors.amber, size: 30),
                              tooltip: 'Rate Order',
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

  void _showRatingDialog(BuildContext context, donorid, receiverid, donid) {
    showDialog(
      context: context,
      builder: (context) {
        int donorStars  = 0;
        int receiverStars = 0;


        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(child: Text("Rate the experience")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("How was the donor?", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            donorStars = index + 1;
                          });
                        },
                        icon: Icon(
                          index < donorStars ? Icons.star : Icons.star_border,
                          color: index < donorStars ? Colors.amber : Colors.grey,
                          size: 32,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  const Text("How was the receiver?", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            receiverStars = index + 1;
                          });
                        },
                        icon: Icon(
                          index < receiverStars ? Icons.star : Icons.star_border,
                          color: index < receiverStars ? Colors.amber : Colors.grey,
                          size: 32,
                        ),
                      );
                    }),
                  ),

                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    if (donorStars == 0|| receiverStars==0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please rate both meal and delivery")),
                      );
                      return;
                    }

                    await submitRating(
                      userId: donorid,
                      stars: donorStars,
                    );

                    await submitRating(
                      userId: receiverid,
                      stars: receiverStars,
                    );


                    await FirebaseFirestore.instance
                        .collection('donations')
                        .doc(donid)
                        .update({
                      'deliverRated': true,
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Thank you for your ratings!")),
                    );
                  },

                  child: const Text("Submit"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
