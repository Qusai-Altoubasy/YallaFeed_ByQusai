import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/admin/admin_states.dart';

class admin_cubit extends Cubit<admin_state>{
  admin_cubit():super (admin_init_state());
  static admin_cubit get(context)=> BlocProvider.of(context);



}