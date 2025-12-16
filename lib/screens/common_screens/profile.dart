
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../classes/mainuser.dart';
import '../../cubits/profile_cubit.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? _image;
  bool editName = false;
  bool editEmail = false;
  bool editPassword = false;
  bool editPhone = false;
  bool editId = false;

  var nameC = TextEditingController();
  var emailC = TextEditingController();
  var passC = TextEditingController();
  var phoneC = TextEditingController();
  var idC = TextEditingController();

  @override
  void initState() {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ProfileCubit.get(context).loadUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC),
        title: Text(
          'Your profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, mainuser?>(
        builder: (context, user) {
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          nameC.text = user.name;
          emailC.text = user.username;
          passC.text = user.password;
          phoneC.text = user.phone;
          idC.text = user.ID;

          return Container(
            decoration: const BoxDecoration(
              // 🌟 Gradient background
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 150,
                          backgroundImage:
                          _image == null ? null : FileImage(_image!),
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt, size: 25,),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              builder: (context) => Container(
                                padding: EdgeInsets.all(20),
                                height: 160,
                                child: Column(
                                  children: [
                                    Text(
                                      "Select Image Source",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            getImage(ImageSource.camera);
                                          },
                                          icon: Icon(Icons.camera_alt),
                                          label: Text("Camera"),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            getImage(ImageSource.gallery);
                                          },
                                          icon: Icon(Icons.photo),
                                          label: Text("Gallery"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ]
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: editId
                                  ? TextField(
                                controller: idC,
                                obscureText: false,
                                decoration: InputDecoration(labelText: 'label'),
                              )
                                  : Text(
                                "ID : ${user.ID}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  profileField(
                    label: "Name",
                    controller: nameC,
                    isEditing: editName,
                    onEdit: () => setState(() => editName = !editName),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  profileField(
                    label: "Email",
                    controller: emailC,
                    isEditing: editEmail,
                    onEdit: () => setState(() => editEmail = !editEmail),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  profileField(
                    label: "Password",
                    controller: passC,
                    isEditing: editPassword,
                    obscure: true,
                    onEdit: () => setState(() => editPassword = !editPassword),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  profileField(
                    label: "Phone",
                    controller: phoneC,
                    isEditing: editPhone,
                    onEdit: () => setState(() => editPhone = !editPhone),
                  ),

                  SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: () {
                      final updated = mainuser(
                        name: nameC.text,
                        username: emailC.text,
                        password: passC.text,
                        phone: phoneC.text,
                        ID: user.ID,
                        imageUrl: user.imageUrl,
                        type: user.type,
                      );

                      String uid =
                          FirebaseAuth.instance.currentUser!.uid;

                      ProfileCubit.get(context).updateUser(updated, uid);

                      Navigator.pop(context);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Updated Successfully")),
                      );
                    },
                    child: const Text("Save"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget profileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: isEditing
                    ? TextField(
                  controller: controller,
                  obscureText: obscure,
                  decoration: InputDecoration(labelText: label),
                )
                    : Text(
                  "$label : ${controller.text}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

                IconButton(
                  onPressed: onEdit,
                  icon:  Icon(Icons.edit),
                )


            ],
          ),
        ),
      ),
    );
  }
  Future<void> getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
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
