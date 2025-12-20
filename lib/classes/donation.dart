import 'package:cloud_firestore/cloud_firestore.dart';

class donation {
  String mealType;
  int numberOfPeople;
  String ?category;
  String fromlocation;
  String ?tolocation;
  String ?description;
  String imagePath;
  String status;
  String donoruid;
  String reciveruid;
  String deleiveruid;


  donation({
    required this.mealType,
    required this.numberOfPeople,
    this.category,
    required this.fromlocation,
    this.tolocation,
    this.description,
    required this.imagePath,
    required this.status,
    required this.deleiveruid,
    required this.donoruid,
    required this.reciveruid,
  });

  Future<void> saveindatabase(doc)async {
    await doc.set(
        {
          'mealType': this.mealType,
          'numberOfPeople': this.numberOfPeople,
          'category': this.category,
          'fromlocation': this.fromlocation,
          'tolocation': this.tolocation,
          'description': this.description,
          'imagePath': this.imagePath,
          'status': this.status,
          'deleiveruid': this.deleiveruid,
          'donoruid': this.donoruid,
          'reciveruid': this.reciveruid,
          'donatetime': FieldValue.serverTimestamp(),
          'recivetime': FieldValue.serverTimestamp(),
          'deleviretime': FieldValue.serverTimestamp(),
        }
    );

  }


}