import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/admin.dart';
import 'package:qusai/cubits/admin/admin_states.dart';

class admin_cubit extends Cubit<admin_state>{
  admin_cubit():super (admin_init_state());
  static admin_cubit get(context)=> BlocProvider.of(context);

  late admin Admin;

  Future<void> getadmin(String uid)async{
    emit(loading());
    final userdoc = await FirebaseFirestore.instance
        .collection('admin')
        .doc(uid)
        .get();

    admin User = admin(
        userdoc.data()?["name"],
        userdoc.data()?["username"],
        userdoc.data()?["password"],
        userdoc.data()?["phone"],
        userdoc.data()?["Id"],
        userdoc.data()?["image"]
    );
    this.Admin=User;
    emit(loadedadmin());
  }


  void send_announcement(String title, String message, String sendto){}


  void add_user(String name, String username, String pass, String phone, String id){}

  void get_user(){}

  void delete_user(String id){}

}