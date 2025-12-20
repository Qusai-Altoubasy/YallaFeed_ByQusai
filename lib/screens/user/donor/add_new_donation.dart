import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qusai/classes/donation.dart';
import 'package:qusai/shared/shared.dart';
import '../../../components/components.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


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
  var cityController = TextEditingController();
  var districtController= TextEditingController();
  var streetController = TextEditingController();
  var buildingController = TextEditingController();

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

  Future<Directory> getDonationImagesFolder() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${dir.path}/donation_images');

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir;
  }

  Future<File> saveImageLocally(String donationId) async {
    final imagesDir = await getDonationImagesFolder();

    final imagePath = '${imagesDir.path}/$donationId.jpg';

    return await _image!.copy(imagePath);
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
                              else{
                                try{
                                  int x=int.parse(value);
                                }catch(e){
                                  return 'please enter an integer number';
                                }
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
                          defaultFormField(
                            controller: cityController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a city ';
                              }
                              return null;
                            },
                            label: 'City',
                            prefix: Icons.map,
                          ),
                          const SizedBox(height: 6),
                          defaultFormField(
                            controller: districtController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a district';
                              }
                              return null;
                            },
                            label: 'District',
                            prefix: Icons.location_city,
                          ),
                          const SizedBox(height: 6),
                          defaultFormField(
                            controller: streetController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a street ';
                              }
                              return null;
                            },
                            label: 'Street',
                            prefix: Icons.car_repair,
                          ),
                          const SizedBox(height: 6),
                          defaultFormField(
                            controller: buildingController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter the building number ';
                              }
                              return null;
                            },
                            label: 'Building number',
                            prefix: Icons.numbers,
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
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) return;

                                if (_image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('You have to add an image.')),
                                  );
                                  return;
                                }
                                if (category == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please select a category')),
                                  );
                                  return;
                                }


                                final doc =
                                FirebaseFirestore.instance.collection('donations').doc();
                                final donationId = doc.id;

                                final savedImage = await saveImageLocally(donationId);

                                  donation Donation=donation(
                                      mealType: nameController.text,
                                      numberOfPeople: int.parse(numberofpeopleController.text),
                                      fromlocation: '${cityController.text}, ${districtController.text}, ${streetController.text}, ${buildingController.text}.',
                                      imagePath: savedImage.path,
                                      status: 'pending',
                                      deleiveruid: ' ',
                                      donoruid: '$userid',
                                      reciveruid: ' ',
                                      description: descriptionController.text,
                                      category: category,
                                  );

                                  Donation.saveindatabase(doc);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'The donation have been submitted successfully, thank you. ')),
                                  );
                                  Navigator.pop(context);
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

}