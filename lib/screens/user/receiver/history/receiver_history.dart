import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/screens/user/receiver/history/delivered_rec.dart';

import '../../../../classes/donation.dart';
import '../../../../shared/shared.dart';
import 'donation_det.dart';

class receiver_history extends StatefulWidget {
  const receiver_history({super.key});

  @override
  State<receiver_history> createState() => _receiver_historyState();
}

class _receiver_historyState extends State<receiver_history> with SingleTickerProviderStateMixin {

  List<String> Readreceiverhistory = [];
  bool loading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    LoadReadreceiverhistory();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> LoadReadreceiverhistory() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_receiver_history')
        .where('userId', isEqualTo: userid)
        .get();

    Readreceiverhistory =
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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Today"),
            Tab(text: "Past"),
          ],
          labelColor: Colors.black,
          indicatorColor: Colors.blue,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('reciveruid', isEqualTo: userid)
            .orderBy('donatetime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDocs = snapshot.data!.docs
              .where((doc) => !Readreceiverhistory.contains(doc.id))
              .toList();

          final today = DateTime.now();
          final todayDocs = allDocs.where((doc) {
            final date = (doc['donatetime'] as Timestamp).toDate();
            return date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;
          }).toList();

          final pastDocs = allDocs.where((doc) {
            final date = (doc['donatetime'] as Timestamp).toDate();
            return !(date.year == today.year &&
                date.month == today.month &&
                date.day == today.day);
          }).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildListView(todayDocs, "No meals for today."),
              _buildListView(pastDocs, "No past meals."),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView(List docs, String emptyMessage) {
    if (docs.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
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
          did: item.id,
          tolocation: item['tolocation'],
          receiverRated: item['receiverRated'],
          donoruid: item['donoruid'],
          deleiveruid: item['deleiveruid'],
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
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }

                        final file = File(current.imagePath);
                        if (!file.existsSync()) {
                          return Icon(Icons.fastfood_outlined, color: statusColor);
                        }

                        return Image.file(file, fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),


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
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          current.status=="accepted"?"Waiting for a driver":
                          current.status=="delivering"?'On its way' :
                          current.status=="delivered by driver"?'The driver has been delivered the meal':'delivered',
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


                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye, color: Color(0xFF6A1B9A)),
                      tooltip: 'View details',
                      onPressed: () {
                        receiverdonationdetails = current;
                        navigatetoWithTransition(
                          context,
                          delivered_rec(),
                          color: const Color(0xFF5C6BC0),
                          message: 'Loading donation details...',
                        );
                      },
                    ),
                    if(current.status=='delivered')
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('read_receiver_history')
                              .doc('${userid}_${docs[index].id}')
                              .set({
                            'userId': userid,
                            'donationid': docs[index].id,
                          });

                          setState(() {
                            Readreceiverhistory.add(docs[index].id);
                          });
                        },
                      ),
                    if(current.status=='delivered by driver')
                      IconButton(
                        icon: const Icon(Icons.local_shipping, color: Color(0xFF6A1B9A)),
                        tooltip: 'View details',
                        onPressed: () {
                          receiverdonationdetails = current;
                          navigatetoWithTransition(
                            context,
                            donation_det(),
                            color: const Color(0xFF5C6BC0),
                            message: 'Loading donation details...',
                          );
                        },
                      ),
                    if((current.status=='delivered') && !current.receiverRated)
                      IconButton(
                        onPressed: () {
                          _showRatingDialog(context, current.donoruid, current.deleiveruid, current.did);
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
    );
  }

  void _showRatingDialog(BuildContext context, donorid, deliverid, donid) {

    showDialog(
      context: context,
      builder: (context) {
        int donorStars  = 0;
        int deliveryStars = 0;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(child: Text("Rate the experience")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("How was the meal?", style: TextStyle(fontSize: 16)),
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
                  const Text("How was the deliver?", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            deliveryStars = index + 1;
                          });
                        },
                        icon: Icon(
                          index < deliveryStars ? Icons.star : Icons.star_border,
                          color: index < deliveryStars ? Colors.amber : Colors.grey,
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
                    if (donorStars == 0|| deliveryStars==0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please rate both meal and delivery")),
                      );
                      return;
                    }

                    await submitRating(userId: donorid, stars: donorStars);
                    await submitRating(userId: deliverid, stars: deliveryStars);

                    await FirebaseFirestore.instance
                        .collection('donations')
                        .doc(donid)
                        .update({'receiverRated': true});

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Thank you for your ratings!")),
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
