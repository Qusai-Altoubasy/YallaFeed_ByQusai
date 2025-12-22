import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qusai/classes/donation.dart';
import 'package:qusai/shared/shared.dart';
import '../../../components/components.dart';

class add_new_donation extends StatefulWidget {
  @override
  State<add_new_donation> createState() => _add_new_donation();
}

class _add_new_donation extends State<add_new_donation> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final numberofpeopleController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();

  String? category;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<Directory> _getDonationImagesFolder() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${dir.path}/donation_images');
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    return imagesDir;
  }

  Future<File> _saveImageLocally(String donationId) async {
    final imagesDir = await _getDonationImagesFolder();
    return await _image!.copy('${imagesDir.path}/$donationId.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF1F7A5C)),
        title: const Text(
          'New Donation',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Share a Meal 🤍',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your donation can make someone’s day better',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 26),

                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: DottedBorder(
                      dashPattern: const [6, 4],
                      color: const Color(0xFF1F7A5C),
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                            : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,
                                size: 42,
                                color: Color(0xFF1F7A5C)),
                            SizedBox(height: 8),
                            Text(
                              'Add meal photo',
                              style: TextStyle(
                                color: Color(0xFF1F7A5C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                _sectionCard(
                  title: 'Meal Information',
                  children: [
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Meal type',
                      prefix: Icons.fastfood_outlined,
                      validate: (v) =>
                      v.isEmpty ? 'Enter meal type' : null,
                    ),
                    const SizedBox(height: 14),
                    defaultFormField(
                      controller: numberofpeopleController,
                      type: TextInputType.number,
                      label: 'Number of people served',
                      prefix: Icons.group_outlined,
                      validate: (v) {
                        if (v.isEmpty) return 'Enter number';
                        if (int.tryParse(v) == null) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Bread',
                        'Cooked Meal',
                        'Fruits',
                        'Vegetables'
                      ]
                          .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => category = v),
                      validator: (v) =>
                      v == null ? 'Choose category' : null,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _sectionCard(
                  title: 'Pickup Location',
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

                const SizedBox(height: 20),

                _sectionCard(
                  title: 'Description',
                  children: [
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Write short description...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please add a meal photo')),
                        );
                        return;
                      }

                      final doc = FirebaseFirestore.instance
                          .collection('donations')
                          .doc();

                      final image = await _saveImageLocally(doc.id);

                      donation Donation = donation(
                        mealType: nameController.text,
                        numberOfPeople:
                        int.parse(numberofpeopleController.text),
                        fromlocation:
                        '${cityController.text}, ${districtController.text}, ${streetController.text}, ${buildingController.text}',
                        imagePath: image.path,
                        status: 'pending',
                        deleiveruid: ' ',
                        donoruid: userid!,
                        reciveruid: ' ',
                        description: descriptionController.text,
                        category: category,
                      );

                      Donation.saveindatabase(doc);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text('Donation submitted successfully 🤍')),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Submit Donation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
