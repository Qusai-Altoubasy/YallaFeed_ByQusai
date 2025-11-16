import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';

class add_new_donation extends StatefulWidget {
  @override
  State<add_new_donation> createState() => _add_new_donation();
}

class _add_new_donation extends State<add_new_donation> {
  bool ispassword = true;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var IDController = TextEditingController();

  File? _image;

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
                        children: [
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
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter number';
                              }
                              return null;
                            },
                            label: 'How many people you will serve?',
                            prefix: Icons.group,
                          ),
                          const SizedBox(height: 15),
                          CircleAvatar(
                            radius: 150,
                            backgroundImage:
                            _image == null ? null : FileImage(_image!),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF757575), Color(0xFF424242)],
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
                            child: GestureDetector(
                              onTap: getImage,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Center(
                                  child: Text(
                                    "Add photo",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
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
                                // تنفيذ إرسال النموذج
                                if (formKey.currentState!.validate()) {
                                  // حفظ البيانات + الصورة
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

  // ============================
  // دالة اختيار الصورة من الكاميرا
  // ============================
  Future<void> getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80, // اختياري لتقليل حجم الصورة
        maxWidth: 1024,
      );

      if (pickedFile == null) {
        // المستخدم ألغى الاختيار
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
        return;
      }

      final File imageFile = File(pickedFile.path);

      setState(() {
        _image = imageFile;
      });
    } catch (e) {
      // إدارة الأخطاء
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}
