import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final phoneC = TextEditingController();
  final idC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    ProfileCubit.get(context).loadUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE8EEF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your profile',
          style: TextStyle(fontWeight: FontWeight.bold),
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
              gradient:const LinearGradient(
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
                  // ===== TOP PROFILE CARD =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.20),
                      border: Border.all(color: Colors.white24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 25,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 78,
                                backgroundColor: Colors.white,
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                    : (user.imageUrl != null &&
                                    user.imageUrl!.trim().isNotEmpty)
                                    ? NetworkImage(user.imageUrl!)
                                as ImageProvider
                                    : null,
                                child: (_image == null &&
                                    (user.imageUrl == null ||
                                        user.imageUrl!.trim().isEmpty))
                                    ? const Icon(Icons.person,
                                    size: 70, color: Color(0xFF64B5F6))
                                    : null,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2F80ED)
                                        .withOpacity(0.35),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                onPressed: () => _showImagePickerSheet(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          user.username,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== FIELDS CARD =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _sectionTitle('Account info'),

                        const SizedBox(height: 14),

                        // ID (عرض فقط)
                        _profileField(
                          label: "ID",
                          controller: idC,
                          isEditing: false,
                          onEdit: () {},
                          icon: Icons.badge_outlined,
                          editable: false,
                        ),

                        const SizedBox(height: 14),

                        _profileField(
                          label: "Name",
                          controller: nameC,
                          isEditing: editName,
                          onEdit: () => setState(() => editName = !editName),
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 14),

                        _profileField(
                          label: "Email",
                          controller: emailC,
                          isEditing: editEmail,
                          onEdit: () => setState(() => editEmail = !editEmail),
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 14),

                        _profileField(
                          label: "Password",
                          controller: passC,
                          isEditing: editPassword,
                          obscure: true,
                          onEdit: () =>
                              setState(() => editPassword = !editPassword),
                          icon: Icons.lock_outline,
                        ),

                        const SizedBox(height: 14),

                        _profileField(
                          label: "Phone",
                          controller: phoneC,
                          isEditing: editPhone,
                          onEdit: () => setState(() => editPhone = !editPhone),
                          icon: Icons.phone_outlined,
                        ),

                        const SizedBox(height: 22),

                        // ===== SAVE BUTTON =====
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F80ED),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 6,
                            ),
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

                              final uid =
                                  FirebaseAuth.instance.currentUser!.uid;

                              ProfileCubit.get(context).updateUser(updated, uid);

                              Navigator.pop(context);
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Updated Successfully")),
                              );
                            },
                            child: const Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
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
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        const Icon(Icons.verified_user, color: Color(0xFF2F80ED)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _profileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    required IconData icon,
    bool obscure = false,
    bool editable = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FBFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3F2FD)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF2F80ED).withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF2F80ED)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isEditing
                ? TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (editable)
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                isEditing ? Icons.check_circle : Icons.edit,
                color: const Color(0xFF2F80ED),
              ),
            ),
        ],
      ),
    );
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Select Image Source",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF56CCF2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallery"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
      );

      if (pickedFile == null) {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}
