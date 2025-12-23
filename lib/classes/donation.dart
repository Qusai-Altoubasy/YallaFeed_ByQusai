import 'package:cloud_firestore/cloud_firestore.dart';

class donation {
  String mealType;
  int numberOfPeople;
  String ?category;
  String fromlocation;
  String tolocation;
  String description;
  String imagePath;
  String status;
  String ?donoruid;
  String ?reciveruid;
  String ?deleiveruid;
  DateTime donatetime;
  DateTime? recivetime;
  DateTime? deleviretime;
  String did;


  donation({
    required this.mealType,
    required this.numberOfPeople,
    this.category,
    this.fromlocation='kla',
    this.tolocation='jn',
    this.description='kl',
    required this.imagePath,
    required this.status,
    this.deleiveruid,
    this.donoruid,
    this.reciveruid,
    DateTime? donatetime,
    this.deleviretime,
    this.recivetime,
    this.did='ml'
  }): donatetime = donatetime ?? DateTime.now();

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
          'did':doc.id,
        }
    );

  }


}