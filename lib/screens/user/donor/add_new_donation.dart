import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/components.dart';
import 'location.dart';

class add_new_donation extends StatefulWidget {
  @override
  State<add_new_donation> createState() => _add_new_donation();
}

class _add_new_donation extends State<add_new_donation> {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var numberofpeopleController = TextEditingController();
  String? category;
  var timeController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  TextEditingController locationController = TextEditingController();

  Future<void> _openMap() async {
    final hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied')),
      );
      return;
    }


    final pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PickLocationPage()),
    );


    if (pickedLocation != null) {
      locationController.text =
      "${pickedLocation.latitude}, ${pickedLocation.longitude}";

      final Uri googleMapUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${pickedLocation.latitude},${pickedLocation.longitude}');

      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC),
      ),
      body: Container(
        decoration: const BoxDecoration(
          // 🌟 Gradient background
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //  Title
                    Text(
                      'Add new meal',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 8.0
                    ),
                    //  Subtitle
                    Text(
                      'We hope you donate a good meal.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30.0),

                    // Form fields inside a card
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: DottedBorder(
                                dashPattern: const [6, 3],
                                color: Colors.blueAccent,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(18),
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: _image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.file(_image!, fit: BoxFit.cover),
                                  )
                                      : const Center(
                                    child:
                                    Icon(Icons.add_a_photo, size: 50, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter type of meal ';
                              }
                              return null;
                            },
                            label: 'Type of meal',
                            prefix: Icons.fastfood_outlined,
                          ),
                          const SizedBox(height: 15.0),
                          defaultFormField(
                            controller: numberofpeopleController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter the number of people';
                              }
                              return null;
                            },
                            label: 'How many people you will serve?',
                            prefix: Icons.group,
                          ),
                          const SizedBox(height: 15.0,),
                          Text("Category",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: category,
                                hint: const Text("Select category"),
                                items: ["Bread", "Cooked Meal", "Fruits", "Vegetables"]
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (v) => setState(() => category = v),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          const SizedBox(height: 15.0),
                          Text("Location",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: locationController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The Location is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Location",
                              prefixIcon: const Icon(Icons.location_on),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.map, color: Colors.blue),
                                onPressed: _openMap, // دالة فتح الخرائط والحصول على الموقع
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              hintText: "Press map icon to get location",
                            ),
                            onTap: () async {
                              if (locationController.text.isNotEmpty) {
                                // إذا الحقل يحتوي إحداثيات، افتحها مباشرة في Google Maps
                                final coords = locationController.text; // "lat, long"
                                final url =
                                Uri.parse('https://www.google.com/maps/search/?api=1&query=$coords');
                                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                  throw 'Could not launch $url';
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 6),
                          Text("Description",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: descriptionController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                              hintText: "Write short description...",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {

                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

}