import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/user/user_states.dart';
import 'package:qusai/screens/user/deleviry/deleviry_main_screen.dart';
import 'package:qusai/screens/user/receiver/receiver_main_screen.dart';

import '../../screens/user/donor/donor_main_screen.dart';

class user_cubit extends Cubit<user_states>{
  user_cubit():super (user_init_state());
  static user_cubit get(context)=> BlocProvider.of(context);

  int current_index=0;

  List<String> titles = [
    'Donor Dashboard',
    'Receiver Dashboard',
    'Delivery Dashboard',
  ];

  List<Widget> screens=[
    donor_main_screen(),
    receiver_main_screen(),
    deleviry_main_screen(),
  ];

  void change_bottom_nav_bar(int index){
    current_index= index;
    emit(change_user_bottom());
    }


}
