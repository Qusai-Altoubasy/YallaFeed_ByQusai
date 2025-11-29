import 'package:qusai/classes/mainuser.dart';
import 'package:qusai/classes/user.dart';

class charity extends mainuser {
  String phone;
  String id;

  charity({name, username, password, imageUrl, required this.phone, required this.id}) :
        super(name: name, username: username, password: password, imageUrl: imageUrl, type: 'charity');

  void permission(user User){
    User.letpermission(this.name);
  }

}