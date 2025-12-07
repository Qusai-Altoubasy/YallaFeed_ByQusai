import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/user/user_states.dart';
import 'package:qusai/screens/user/deleviry/deleviry_main_screen.dart';
import 'package:qusai/screens/user/receiver/receiver_main_screen.dart';

import '../../classes/user.dart';
import '../../screens/user/donor/donor_main_screen.dart';

class user_cubit extends Cubit<user_states>{
  user_cubit():super (user_init_state());
  static user_cubit get(context)=> BlocProvider.of(context);

  int current_index=0;

  user ?User ;

  List<String> titles = [
    'Donor Dashboard',
    'Receiver Dashboard',
    'Delivery Dashboard',
  ];

  void change_bottom_nav_bar(int index){
    current_index= index;
    emit(change_user_bottom());
    }



  Future<void> sendrequest(databaseID, name)async {
    emit(loading());
    try{
      await FirebaseFirestore.instance
          .collection("users")
          .doc(databaseID)
          .update({
        // "havepermission":true,
        "askpermission": true,
      });
      await FirebaseFirestore.instance.collection('requests').doc(databaseID).set(
        {
          "uid" : databaseID,
          "name" :name,
        }
      );
      User?.askpermission=true;
    }
    catch(e){
      print(e);
    }
    emit(requestsended());
  }

  Future<void> getuser(String uid)async{
    emit(loading());
    final userdoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    user User = user(
      name: userdoc.data()?["name"],
      username: userdoc.data()?["username"],
      password: userdoc.data()?["password"],
      id: userdoc.data()?["Id"],
      phone: userdoc.data()?["phone"],
      imageUrl: userdoc.data()?["image"],
      databaseid: userdoc.data()?["uid"],
    );
    User.havepermission=userdoc.data()?["havepermission"];
    User.askpermission= userdoc.data()?["askpermission"];
    User.nameofcharity=userdoc.data()?["nameofcharity"];

    this.User= User;
    emit(loadeduser());
  }



}
