import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qusai/shared/shared.dart';
import 'package:intl/intl.dart';

import '../../../components/components.dart';
import '../../charity/accept_reject_new_user.dart';

class donation_detalis extends StatefulWidget {
  const donation_detalis({super.key});

  @override
  State<donation_detalis> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<donation_detalis> {
  File? _image = File(receiverdonationdetails!.imagePath);
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int dailyLimit = 0;
  int usedCapacityToday = 0;
  int remainingCapacity = 0;
  bool capacityLoaded = false;

  @override
  void initState() {
    super.initState();
    loadDailyCapacity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF6A1B9A)),
        title: const Text(
          'Donation Details',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== IMAGE =====
              Center(
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: const Color(0xFF6A1B9A).withOpacity(0.08),
                    image: _image != null
                        ? DecorationImage(
                        image: FileImage(_image!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _image == null
                      ? const Center(
                      child: Icon(
                        Icons.fastfood_outlined,
                        size: 80,
                        color: Color(0xFF6A1B9A),
                      ))
                      : null,
                ),
              ),
              const SizedBox(height: 30),

              // ===== INFO CARDS =====
              _infoCard(
                  title: 'Meal Type', value: receiverdonationdetails!.mealType),
              _infoCard(
                  title: 'Persons',
                  value: receiverdonationdetails!.numberOfPeople.toString()),
              _infoCard(
                  title: 'Donate time',
                  value: DateFormat('dd/MM/yyyy – hh:mm a')
                      .format(receiverdonationdetails!.donatetime)),

              const SizedBox(height: 20),

              // ===== DESCRIPTION =====
              Card(
                elevation: 6,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          receiverdonationdetails!.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== PICKUP LOCATION =====
              Card(
                elevation: 6,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pickup location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          receiverdonationdetails!.fromlocation,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== RECEIVE LOCATION =====
              _sectionCard(
                title: 'Receive location',
                children: [
                  defaultFormField(
                    controller: cityController,
                    label: 'City',
                    prefix: Icons.location_city,
                    type: TextInputType.name,
                    validate: (v) => v.isEmpty ? 'Enter city' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: districtController,
                    label: 'District',
                    prefix: Icons.map,
                    type: TextInputType.name,
                    validate: (v) => v.isEmpty ? 'Enter district' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: streetController,
                    label: 'Street',
                    prefix: Icons.signpost_outlined,
                    type: TextInputType.name,
                    validate: (v) => v.isEmpty ? 'Enter street' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: buildingController,
                    label: 'Building',
                    prefix: Icons.home_outlined,
                    type: TextInputType.name,
                    validate: (v) => v.isEmpty ? 'Enter building' : null,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== DAILY CAPACITY =====
              if (capacityLoaded)
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daily Capacity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: dailyLimit == 0
                              ? 0
                              : usedCapacityToday / dailyLimit,
                          minHeight: 10,
                          backgroundColor: Colors.grey.shade300,
                          color: remainingCapacity <= 5
                              ? Colors.red
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Used: $usedCapacityToday',
                              style: TextStyle(
                                color: remainingCapacity <= 5
                                    ? Colors.red
                                    : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Remaining: $remainingCapacity',
                              style: TextStyle(
                                color: remainingCapacity <= 5
                                    ? Colors.red
                                    : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Limit: $dailyLimit',
                              style: TextStyle(
                                color: remainingCapacity <= 5
                                    ? Colors.red
                                    : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // ===== ACCEPT BUTTON =====
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  onPressed: () async {
                    print('ACCEPT BUTTON PRESSED');

                    if (!formKey.currentState!.validate()) return;

                    final userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userid)
                        .get();

                    int familySize = userDoc.data()?['familySize'] ?? 0;

                    if (familySize == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          margin: const EdgeInsets.all(16),
                          content: const Text(
                            'Your family size has not been set yet. Please contact the charity.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      return;
                    }

                    final int currentDonationCapacity =
                        receiverdonationdetails!.numberOfPeople;

                    if (currentDonationCapacity > familySize + 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          backgroundColor: const Color(0xFFD32F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          margin: const EdgeInsets.all(16),
                          content: Row(
                            children: const [
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'This donation exceeds your family size by more than two people.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      return;
                    }

                    final now = DateTime.now();
                    final startOfDay = DateTime(now.year, now.month, now.day);

                    final todaySnapshot = await FirebaseFirestore.instance
                        .collection('donations')
                        .where('reciveruid', isEqualTo: userid)
                        .where(
                      'recivetime',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
                    )
                        .get();

                    int usedCapacityToday = 0;
                    for (var doc in todaySnapshot.docs) {
                      if (doc.data().containsKey('numberOfPeople')) {
                        usedCapacityToday += doc['numberOfPeople'] as int;
                      }
                    }

                    final int dailyLimit = familySize * 3;
                    final int remainingCapacity = dailyLimit - usedCapacityToday;

                    if (currentDonationCapacity > remainingCapacity) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          backgroundColor: const Color(0xFFD32F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          margin: const EdgeInsets.all(16),
                          content: const Text(
                            'This donation exceeds your remaining daily capacity.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      return;
                    }

                    await FirebaseFirestore.instance
                        .collection('donations')
                        .doc(receiverdonationdetails!.did)
                        .update({
                      'reciveruid': userid,
                      'recivetime': FieldValue.serverTimestamp(),
                      'status': 'accepted',
                      'tolocation':
                      '${cityController.text}, ${districtController.text}, ${streetController.text}, ${buildingController.text}',
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 3),
                        backgroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        margin: const EdgeInsets.all(16),
                        content: Row(
                          children: const [
                            Icon(Icons.check_circle_outline,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Donation accepted successfully 🤍',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: const Text("Accept",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Future<void> loadDailyCapacity() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get();

    int familySize = userDoc.data()?['familySize'] ?? 0;
    if (familySize == 0) return;

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final todaySnapshot = await FirebaseFirestore.instance
        .collection('donations')
        .where('reciveruid', isEqualTo: userid)
        .where(
      'recivetime',
      isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
    )
        .get();

    int used = 0;
    for (var doc in todaySnapshot.docs) {
      used += (doc.data()['numberOfPeople'] ?? 0) as int;
    }

    setState(() {
      dailyLimit = familySize * 3;
      usedCapacityToday = used;
      remainingCapacity = dailyLimit - usedCapacityToday;
      capacityLoaded = true;
    });
  }
}
