import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/charity.dart';
import 'package:qusai/cubits/charity/charity_states.dart';

class charity_cubit extends Cubit<charity_states>{
  charity_cubit():super (charity_init_state());
  static charity_cubit get(context)=> BlocProvider.of(context);

  late charity Charity ;
  Future<void> getcharity(String uid)async{
    emit(loading());
    final userdoc = await FirebaseFirestore.instance
        .collection('charity')
        .doc(uid)
        .get();

    charity User = charity(
      name: userdoc.data()?["name"],
      username: userdoc.data()?["username"],
      password: userdoc.data()?["password"],
      id: userdoc.data()?["Id"],
      phone: userdoc.data()?["phone"],
      imageUrl: userdoc.data()?["image"],
    );
    this.Charity=User;
    emit(loadedcharity());
  }




}