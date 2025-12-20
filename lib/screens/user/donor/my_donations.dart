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

  List<String> Readdonordonations=[];
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


  @override
  Widget build(BuildContext context) {
    if (loading) {
        return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('donoruid', isEqualTo:userid)
          .orderBy('donatetime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var docs = snapshot.data!.docs
            .where((doc) => !Readdonordonations.contains(doc.id))
            .toList();

        if (docs.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text('My Donations')),
            body: Center(child: Text('There are no donations.')),
          );
        }


        return Scaffold(
          appBar: AppBar(
            title: Center(child: const Text("My Donations")),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final item = docs[index];
                donation current =donation(
                  mealType: item['mealType'],
                  numberOfPeople: item['numberOfPeople'],
                  status: item['status'],
                  imagePath: item['imagePath'],
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FutureBuilder(
                        future: getApplicationDocumentsDirectory(),
                        builder: (context, asyncSnapshot) {
                          if (!asyncSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator(strokeWidth: 2));
                          }
                          final fullPath =
                              current.imagePath;

                          final file = File(fullPath);

                          if (!file.existsSync()) {
                            return Icon(Icons.broken_image);
                          }

                          return Image.file(
                              file,
                              fit: BoxFit.cover);
                        }
                      ),
                  ),
                      ),
                      const SizedBox(width: 15),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                current.mealType,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("Persons: ${current.numberOfPeople}"),
                            const SizedBox(height: 6),
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: current.status=='pending'?Colors.orange[100]:current.status=='delivered'?Colors.green[100]:Colors.blue[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                current.status,
                                style: TextStyle(
                                    color: current.status=='pending'?Colors.orange:current.status=='delivered'?Colors.green:Colors.blue
                                    , fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
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

                          icon: const Icon(Icons.delete, color: Colors.red)),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}