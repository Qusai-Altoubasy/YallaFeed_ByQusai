import 'package:qusai/classes/announcement.dart';
import 'package:qusai/classes/mainuser.dart';
import 'package:qusai/classes/user.dart';

class admin extends mainuser {


  admin(name, username, password, phone, id, imageUrl) :
        super(name: name, username: username, password: password,phone : phone,ID :id, imageUrl: imageUrl, type: 'admin');

  void add_new_user(name, username, password, phone, id, image){
    user User=user(
      name: name,
      phone: phone,
      id:id,
      username: username,
      password: password,
      imageUrl: image
    );
  }

  void delete_account(String id){

  }

  void create_new_announcement(String t, String m, String st){
    announcement Announcement= announcement(title: t, message: m, sendTo: st, owener: this.name);
  }

}