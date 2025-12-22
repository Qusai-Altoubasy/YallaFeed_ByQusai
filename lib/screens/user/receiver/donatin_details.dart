import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qusai/shared/shared.dart';
import 'package:intl/intl.dart';

import '../../../components/components.dart';



class donation_detalis extends StatefulWidget {
  const donation_detalis({super.key});

  @override
  State<donation_detalis> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<donation_detalis> {
  File? _image= File(receiverdonationdetails!.imagePath);
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final formKey = GlobalKey<FormState>();



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
                    ),
                  )
                      : null,
                ),
              ),

              const SizedBox(height: 30),

              // ===== INFO CARDS =====
              _infoCard(title: 'Meal Type', value: receiverdonationdetails!.mealType),
              _infoCard(title: 'Persons', value: receiverdonationdetails!.numberOfPeople.toString()),
              _infoCard(title: 'Donate time', value: DateFormat('dd/MM/yyyy – hh:mm a').format(receiverdonationdetails!.donatetime)),

              const SizedBox(height: 20),

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


              _sectionCard(
                title: 'Receive location',
                children: [
                  defaultFormField(
                    controller: cityController,
                    label: 'City',
                    prefix: Icons.location_city,
                    type: TextInputType.name,
                    validate: (v) =>
                    v.isEmpty ? 'Enter city' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: districtController,
                    label: 'District',
                    prefix: Icons.map,
                    type: TextInputType.name,
                    validate: (v) =>
                    v.isEmpty ? 'Enter district' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: streetController,
                    label: 'Street',
                    prefix: Icons.signpost_outlined,
                    type: TextInputType.name,
                    validate: (v) =>
                    v.isEmpty ? 'Enter street' : null,
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: buildingController,
                    label: 'Building',
                    prefix: Icons.home_outlined,
                    type: TextInputType.name,
                    validate: (v) =>
                    v.isEmpty ? 'Enter building' : null,
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F80ED), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    await FirebaseFirestore.instance
                        .collection('donations')
                        .doc(receiverdonationdetails?.did)
                        .update({
                      'reciveruid': userid,
                      'recivetime': FieldValue.serverTimestamp(),
                      'status':'accepted',
                      'tolocation':'${cityController.text}, ${districtController.text}, ${streetController.text}, ${buildingController.text}',
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                          Text('You have accepted the meal successfully. 🤍')),
                    );
                    Navigator.pop(context);


                  },
                    child: const Text(
                        "Accept", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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


}
