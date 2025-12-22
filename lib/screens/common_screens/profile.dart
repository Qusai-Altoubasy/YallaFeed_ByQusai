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
  bool editPhone = false;


  bool _showCurrentPass = false;
  bool _showNewPass = false;
  bool _showConfirmPass = false;

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final idC = TextEditingController();

  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    ProfileCubit.get(context).loadUser(uid);
  }

  @override
  void dispose() {
    nameC.dispose(); emailC.dispose(); phoneC.dispose(); idC.dispose();
    currentPassController.dispose(); newPassController.dispose(); confirmPassController.dispose();
    super.dispose();
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
        title: const Text('Your profile', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
      ),
      body: BlocBuilder<ProfileCubit, mainuser?>(
        builder: (context, user) {
          if (user == null) return const Center(child: CircularProgressIndicator());

          if (nameC.text.isEmpty) nameC.text = user.name;
          if (emailC.text.isEmpty) emailC.text = user.username;
          if (phoneC.text.isEmpty) phoneC.text = user.phone;
          if (idC.text.isEmpty) idC.text = user.ID;

          double userRating = 4.8;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9BE7FF), Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 110, 18, 28),
              child: Column(
                children: [

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.25),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        _buildProfileImage(user),
                        const SizedBox(height: 15),
                        Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        _buildRatingBadge(userRating),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --- INFO CARD ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.92), borderRadius: BorderRadius.circular(28)),
                    child: Column(
                      children: [
                        _profileField(label: "ID", controller: idC, isEditing: false, onEdit: (){}, icon: Icons.badge_outlined, editable: false),
                        const SizedBox(height: 15),
                        _profileField(label: "Email", controller: emailC, isEditing: false, onEdit: () => {}, icon: Icons.email_outlined , editable: false),
                        const SizedBox(height: 15),
                        _profileField(label: "Name", controller: nameC, isEditing: editName, onEdit: () => setState(() => editName = !editName), icon: Icons.person_outline),
                        const SizedBox(height: 15),
                        _profileField(label: "Phone", controller: phoneC, isEditing: editPhone, onEdit: () => setState(() => editPhone = !editPhone), icon: Icons.phone_outlined),
                        const SizedBox(height: 25),
                        _passwordDisplayField(context),
                        const SizedBox(height: 15),
                        _buildSaveButton(user),
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

  // --- Widgets ---

  Widget _buildProfileImage(mainuser user) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.white,
          backgroundImage: _image != null ? FileImage(_image!) : (user.imageUrl != null && user.imageUrl!.isNotEmpty ? NetworkImage(user.imageUrl!) as ImageProvider : null),
          child: (_image == null && (user.imageUrl == null || user.imageUrl!.isEmpty)) ? const Icon(Icons.person, size: 70, color: Color(0xFF64B5F6)) : null,
        ),
        CircleAvatar(
          backgroundColor: Colors.blue, radius: 20,
          child: IconButton(icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20), onPressed: () => _showImageSourceSheet(context)),
        ),
      ],
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(30)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 28),
        const SizedBox(width: 8),
        Text("$rating", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(" / 5.0", style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
      ]),
    );
  }

  Widget _passwordDisplayField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFFF7FBFF), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE3F2FD))),
      child: Row(children: [
        const Icon(Icons.lock_outline, color: Colors.blue),
        const SizedBox(width: 15),
        const Expanded(child: Text("Password: •••••••••", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
        IconButton(onPressed: () => _showChangePasswordSheet(context), icon: const Icon(Icons.edit, color: Colors.blue)),
      ]),
    );
  }

  void _showChangePasswordSheet(BuildContext context) {
    currentPassController.clear(); newPassController.clear(); confirmPassController.clear();
    setState(() { _showCurrentPass = _showNewPass = _showConfirmPass = false; });

    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => StatefulBuilder( // استخدام StatefulBuilder لتحديث العين داخل الـ Sheet
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Change Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _passTextField(currentPassController, "Current Password", _showCurrentPass, () => setSheetState(() => _showCurrentPass = !_showCurrentPass)),
              const SizedBox(height: 15),
              _passTextField(newPassController, "New Password", _showNewPass, () => setSheetState(() => _showNewPass = !_showNewPass)),
              const SizedBox(height: 15),
              _passTextField(confirmPassController, "Confirm New Password", _showConfirmPass, () => setSheetState(() => _showConfirmPass = !_showConfirmPass)),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blue),
                onPressed: () async {
                  // 1. التحقق من تطابق الجديد مع القديم
                  if (currentPassController.text == newPassController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New password cannot be the same as current password!"), backgroundColor: Colors.orange));
                    return;
                  }
                  // 2. التحقق من تطابق التأكيد
                  if (newPassController.text != confirmPassController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New passwords do not match!")));
                    return;
                  }

                  try {
                    User? user = FirebaseAuth.instance.currentUser;
                    AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: currentPassController.text);
                    await user.reauthenticateWithCredential(credential);
                    await user.updatePassword(newPassController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Changed Successfully!"), backgroundColor: Colors.green));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect current password or error occurred"), backgroundColor: Colors.red));
                  }
                },
                child: const Text("Update Password", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passTextField(TextEditingController controller, String label, bool isVisible, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  // --- باقي الدوال المساعدة ---
  Widget _profileField({required String label, required TextEditingController controller, required bool isEditing, required VoidCallback onEdit, required IconData icon, bool editable = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF7FBFF), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE3F2FD))),
      child: Row(children: [
        Icon(icon, color: Colors.blue), const SizedBox(width: 15),
        Expanded(child: isEditing ? TextField(controller: controller, decoration: InputDecoration(hintText: label, border: InputBorder.none)) : Text("${label}: ${controller.text}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
        if (editable) IconButton(onPressed: onEdit, icon: Icon(isEditing ? Icons.check_circle : Icons.edit, color: Colors.blue)),
      ]),
    );
  }

  Widget _buildSaveButton(mainuser user) {
    return SizedBox(
      width: double.infinity, height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F80ED), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        onPressed: () {
          final updated = mainuser(name: nameC.text, username: emailC.text, password: user.password, phone: phoneC.text, ID: user.ID, imageUrl: user.imageUrl, type: user.type);
          ProfileCubit.get(context).updateUser(updated, FirebaseAuth.instance.currentUser!.uid);
          setState(() { editName = editEmail = editPhone = false; });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated!")));
        },
        child: const Text("Save Profile Changes", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showImageSourceSheet(BuildContext context) {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (context) => Container(padding: const EdgeInsets.all(20), height: 160, child: Column(children: [const Text("Select Image Source", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 20), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [ElevatedButton.icon(onPressed: () { Navigator.pop(context); getImage(ImageSource.camera); }, icon: const Icon(Icons.camera_alt), label: const Text("Camera")), ElevatedButton.icon(onPressed: () { Navigator.pop(context); getImage(ImageSource.gallery); }, icon: const Icon(Icons.photo), label: const Text("Gallery"))])])));
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) setState(() { _image = File(pickedFile.path); });
  }
}