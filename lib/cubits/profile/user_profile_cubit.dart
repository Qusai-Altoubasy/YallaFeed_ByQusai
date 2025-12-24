

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/user.dart';


class user_profile_cubit extends Cubit<user?> {
  user_profile_cubit() : super(null);

  static user_profile_cubit get(context) => BlocProvider.of(context);

  final _fire = FirebaseFirestore.instance;

  Future<void> loadUser(String uid) async {

    DocumentSnapshot? doc;

    // users
    doc = await _fire.collection("users").doc(uid).get(const GetOptions(source: Source.server));
    if (doc.exists) {
      emit(user(
        name: doc["name"],
        username: doc["username"],
        password: doc["password"],
        phone: doc["phone"],
        id: doc["Id"],
        imageUrl: doc["image"],
        ratingAverage: (doc['ratingAverage'] as num?)?.toDouble(),
      ));
      return;
    }

  }

  Future<void> updateUser(user U, String uid) async {

    await _fire.collection('users').doc(uid).update({
      "name": U.name,
      "username": U.username,
      "phone": U.phone,
      "password": U.password,
      "image": U.imageUrl,
    });

    await loadUser(uid);
  }
}
