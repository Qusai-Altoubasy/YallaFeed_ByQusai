import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class donation_detalis extends StatefulWidget {
  const donation_detalis({super.key});

  @override
  State<donation_detalis> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<donation_detalis> {
  File? _image;

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
            _infoCard(title: 'Meal Type', value: 'Burger'),
            _infoCard(title: 'Persons', value: '5'),
            _infoCard(title: 'Date', value: '05 / 10 / 2025'),

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This meal is freshly prepared and suitable for families. '
                          'Please pick it up within the available time window.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===== INFO CARD =====
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

  // ===== IMAGE PICKER (unchanged logic) =====
  Future<void> getImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
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
