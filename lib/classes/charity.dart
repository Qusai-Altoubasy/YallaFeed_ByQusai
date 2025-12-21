import 'package:qusai/classes/mainuser.dart';
import 'package:qusai/classes/user.dart';

class charity extends mainuser {

  late String databaseID;

  charity({name, username, password, imageUrl, phone, id , databaseid='bd'}) :
        super(name: name, username: username, password: password,phone: phone ,ID :id, imageUrl: imageUrl, type: 'charity'){

    this.databaseID=databaseid;
  }


}