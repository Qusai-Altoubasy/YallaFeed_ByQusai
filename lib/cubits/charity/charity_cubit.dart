import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/charity/charity_states.dart';

class charity_cubit extends Cubit<charity_states>{
  charity_cubit():super (charity_init_state());
  static charity_cubit get(context)=> BlocProvider.of(context);



}