import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/shared/shared.dart';
import '../../../classes/donation.dart';

class my_donations extends StatefulWidget {
  const my_donations({super.key});

  @override
  State<my_donations> createState() => _my_donationsState();
}

class _my_donationsState extends State<my_donations> {
  List<String> Readdonordonations = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadReaddonordonations();
  }

  Future<void> loadReaddonordonations() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_donor_donations')
        .where('userId', isEqualTo: userid)
        .get();

    Readdonordonations =
        readSnapshot.docs.map((e) => e['donationid'] as String).toList();

    setState(() {
      loading = false;
    });
  }

  Color _statusColor(String status) {
    if (status == 'pending') return Colors.orange;
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
          .where('donoruid', isEqualTo: userid)
          .orderBy('donatetime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final docs = snapshot.data!.docs
            .where((doc) => !Readdonordonations.contains(doc.id))
            .toList();

        if (docs.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme:
              const IconThemeData(color: Color(0xFF1F7A5C)),
              title: const Text(
                'My Donations',
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
          backgroundColor: const Color(0xFFF3F7F6),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme:
            const IconThemeData(color: Color(0xFF1F7A5C)),
            title: const Text(
              'My Donations',
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
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // ===== IMAGE =====
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
                              "Serves ${current.numberOfPeople} people",
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
                                current.status,
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

                      // ===== DELETE =====
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.redAccent),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('read_donor_donations')
                              .doc('${userid}_${docs[index].id}')
                              .set({
                            'userId': userid,
                            'donationid': docs[index].id,
                          });

                          setState(() {
                            Readdonordonations.add(docs[index].id);
                          });
                        },
                      ),
                      if (current.status == 'pending')
                        IconButton(
                          icon: const Icon(Icons.delete_forever, color: Colors.red),
                          tooltip: 'Delete donation permanently',
                          onPressed: () async {
                            await _deleteDonationForAll(docs[index].id);
                          },
                        ),

                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _deleteDonationForAll(String donationId) async {
    try {

      await FirebaseFirestore.instance
          .collection('donations')
          .doc(donationId)
          .delete();

      final receiverReads = await FirebaseFirestore.instance
          .collection('read_receiver_donations')
          .where('donationid', isEqualTo: donationId)
          .get();

      for (var doc in receiverReads.docs) {
        await doc.reference.delete();
      }

      final donorReads = await FirebaseFirestore.instance
          .collection('read_donor_donations')
          .where('donationid', isEqualTo: donationId)
          .get();

      for (var doc in donorReads.docs) {
        await doc.reference.delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error deleting donation')),
      );
    }
  }

}
