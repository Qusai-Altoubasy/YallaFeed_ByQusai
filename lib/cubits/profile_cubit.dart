

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/mainuser.dart';

class ProfileCubit extends Cubit<mainuser?> {
  ProfileCubit() : super(null);

  static ProfileCubit get(context) => BlocProvider.of(context);

  final _fire = FirebaseFirestore.instance;

  Future<void> loadUser(String uid) async {
    // نجلب المستخدم من ال 3 مجموعات
    // user - charity - admin

    DocumentSnapshot? doc;

    // users
    doc = await _fire.collection("users").doc(uid).get();
    if (doc.exists) {
      emit(mainuser(
        name: doc["name"],
        username: doc["username"],
        password: doc["password"],
        phone: doc["phone"],
        ID: doc["Id"],
        imageUrl: doc["image"],
        type: "user",
      ));
      return;
    }

    // charity
    doc = await _fire.collection("charity").doc(uid).get();
    if (doc.exists) {
      emit(mainuser(
        name: doc["name"],
        username: doc["username"],
        password: doc["password"],
        phone: doc["phone"],
        ID: doc["Id"],
        imageUrl: doc["image"],
        type: "charity",
      ));
      return;
    }

    // admin
    doc = await _fire.collection("admin").doc(uid).get();
    if (doc.exists) {
      emit(mainuser(
        name: doc["name"],
        username: doc["username"],
        password: doc["password"],
        phone: doc["phone"],
        ID: doc["Id"],
        imageUrl: doc["image"],
        type: "admin",
      ));
      return;
    }
  }

  Future<void> updateUser(mainuser user, String uid) async {
    String collection = user.type == "user"
        ? "users"
        : user.type == "charity"
        ? "charity"
        : "admin";

    await _fire.collection(collection).doc(uid).update({
      "name": user.name,
      "username": user.username,
      "phone": user.phone,
      "password": user.password,
      "image": user.imageUrl,
    });

    emit(user); // تحديث الحالة
  }
}
