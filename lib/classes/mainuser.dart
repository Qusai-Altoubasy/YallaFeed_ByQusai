import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mainuser{
  String name;
  String username;
  String password;
  String phone;
  String ID;
  String ? imageUrl;
  String ?type;

  mainuser({
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
    required this.ID,
    this.imageUrl,
    this.type,
  });


  void login(){}
  Future<void> signup() async {
    final usercred =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: this.username.trim(),
      password: this.password.trim(),);

    await FirebaseFirestore.instance.collection('charity').add(
        { "Id" : this.ID.trim(),
          "name" : this.name.trim(),
          "username" : this.username.trim(),
          "password" : this.password.trim(),
          "phone" : this.phone.trim(),
          "image" : this.imageUrl?.trim(),
          "type" : this.type?.trim(),
        }
    );
  }
}