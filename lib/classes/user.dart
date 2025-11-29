import 'package:qusai/classes/mainuser.dart';

class user extends mainuser{
  String phone;
  String id;
  bool ?havepermission;
  String ?nameofcharity;

  user({name, username, password, imageUrl, required this.phone, required this.id}) :
        super(name: name, username: username, password: password, imageUrl: imageUrl, type: 'user'){
    havepermission = false;
  }

  void letpermission(String n){
    havepermission=true;
    this.nameofcharity=n;

  }


}