import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/shared/shared.dart';
import '../../../classes/donation.dart';
import 'donatin_details.dart';


class view_available_donation extends StatefulWidget {
  const view_available_donation({super.key});

  @override
  State<view_available_donation> createState() => _view_available_donationState();
}

class _view_available_donationState extends State<view_available_donation> {

  List<String> Readreceiverdonations = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadReadreceiverdonations();
  }

  Future<void> loadReadreceiverdonations() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_receiver_donations')
        .where('userId', isEqualTo: userid)
        .get();

    Readreceiverdonations =
        readSnapshot.docs.map((e) => e['donationid'] as String).toList();

    setState(() {
      loading = false;
    });
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
          .where('status', isEqualTo: 'pending')
          .orderBy('donatetime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final docs = snapshot.data!.docs
            .where((doc) => !Readreceiverdonations.contains(doc.id))
            .toList();
        if (docs.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme:
              const IconThemeData(color: Color(0xFF1F7A5C)),
              title: const Text(
                'Available Donations',
                style: TextStyle(
                  color: Color(0xFF1A202C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: const Center(
              child: Text('There are no new donations.'),
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
              'Available Donations',
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
                did: item['did']
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
                      // ===== ICON =====
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

                      // ===== INFO =====
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              current.mealType,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Serves ${current.numberOfPeople} people',
                              style: const TextStyle(
                                fontSize: 13,
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
                                  .collection('read_receiver_donations')
                                  .doc('${userid}_${docs[index].id}')
                                  .set({
                                'userId': userid,
                                'donationid': docs[index].id,
                              });

                              setState(() {
                                Readreceiverdonations.add(docs[index].id);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.check_box,
                                color: Color(0xFF6A1B9A)),
                            tooltip: 'View details',
                            onPressed: () {
                              receiverdonationdetails = current;
                              navigatetoWithTransition(
                                context,
                                donation_detalis(),
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
