import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qusai/shared/shared.dart';

class another_profile extends StatefulWidget {
  const another_profile({super.key, required this.uid});
  final String uid;

  @override
  State<another_profile> createState() => _profileState(uid: uid);
}

class _profileState extends State<another_profile> {
  File? _image;
  late final String uid;

  _profileState({required this.uid});

  @override
  Widget build(BuildContext context) {
    String? type = 'users';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE8EEF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(type)
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9BE7FF),
                  Color(0xFFB3E5FC),
                  Color(0xFFE1F5FE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 110, 18, 28),
              child: Column(
                children: [
                  // ===== Profile Card =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.25),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : (data['imageUrl'] != null &&
                              data['imageUrl'].isNotEmpty
                              ? NetworkImage(data['imageUrl'])
                              : null) as ImageProvider?,
                          child: (_image == null &&
                              (data['imageUrl'] == null ||
                                  data['imageUrl'].isEmpty))
                              ? const Icon(Icons.person,
                              size: 70, color: Color(0xFF64B5F6))
                              : null,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          data['name'],
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Colors.amber, size: 28),
                              const SizedBox(width: 8),
                              Text(
                                data['ratingAverage'].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                " / 5.0",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Info Card =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                            Icons.badge_outlined, "ID", data['Id']),
                        const SizedBox(height: 15),
                        _infoRow(Icons.email_outlined, "Email",
                            data['username']),
                        const SizedBox(height: 15),
                        _infoRow(Icons.person_outline, "Name", data['name']),
                        const SizedBox(height: 15),
                        _infoRow(
                            Icons.phone_outlined, "Phone", data['phone']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FBFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3F2FD)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              "$label : $value",
              style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
      await picker.pickImage(source: source, imageQuality: 80);

      if (pickedFile == null) return;

      setState(() {
        _image = File(pickedFile.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}
