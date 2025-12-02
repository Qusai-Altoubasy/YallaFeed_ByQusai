import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qusai/classes/mainuser.dart';

class user extends mainuser{

  bool ?havepermission;
  String ?nameofcharity;

  user({name, username, password, imageUrl, phone, id}) :
        super(name: name, username: username, password: password,phone: phone,ID :id ,imageUrl: imageUrl, type: 'user'){
    havepermission = false;
    nameofcharity = 'nameofcharity';
  }

  void letpermission(String n){
    havepermission=true;
    this.nameofcharity=n;

  }

@override
  Future<void> signup() async{

  final usercred =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: this.username.trim(),
    password: this.password.trim(),);

  await FirebaseFirestore.instance.collection('users').add(
      { "Id" : this.ID.trim(),
        "name" : this.name.trim(),
        "username" : this.username.trim(),
        "password" : this.password.trim(),
        "phone" : this.phone.trim(),
        "image" : this.imageUrl?.trim(),
        "type" : this.type?.trim(),
        "havepermission" : this.havepermission,
        "nameofcharity" : this.nameofcharity,
      }
  );
  }
}