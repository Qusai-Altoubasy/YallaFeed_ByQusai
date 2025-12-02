import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/register/register_states.dart';

import '../../classes/charity.dart';
import '../../classes/user.dart';

class register_cubit extends Cubit<register_states> {
  register_cubit() : super(register_init_state());

  static register_cubit get(context) => BlocProvider.of(context);

  Future<void> userRegister ({
    required user User,
  })  async {
    User.signup();
  }

  Future<void> charityRegister ({
    required charity Charity,
  })  async {
    Charity.signup();
  }




  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(register_change_password_visibility_state());
  }
}