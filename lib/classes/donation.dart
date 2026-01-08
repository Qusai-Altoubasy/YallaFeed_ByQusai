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
  bool donorRated;
  bool receiverRated;
  bool deliverRated;
  Timestamp? deliveryDeadline;
  DateTime? reciveDate;






  donation({
    this.donorRated=false,
    this.deliverRated=false,
    this.receiverRated=false,

    required this.mealType,
    required this.numberOfPeople,
    this.category,
    this.fromlocation='kla',
    this.tolocation='jn',
    this.description='kl',
    required this.imagePath,
    required this.status,
    this.deleiveruid='jnf',
    this.donoruid,
    this.reciveruid,
    DateTime? donatetime,
    this.deleviretime,
    this.recivetime,
    this.did='ml',
    this.deliveryDeadline,
    this.reciveDate,


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
          'reciveDate': DateTime.now(),
          'donatetime': FieldValue.serverTimestamp(),
          'recivetime': FieldValue.serverTimestamp(),
          'deleviretime': FieldValue.serverTimestamp(),
          'did':doc.id,
          'donorRated': false,
          'deliverRated':false,
          'receiverRated':false,
          'deliveryDeadline': null,

        }
    );

  }
  factory donation.fromFirestore(
      Map<String, dynamic> data,
      String docId,
      ) {
    return donation(
      did: docId,
      mealType: data['mealType'],
      numberOfPeople: data['numberOfPeople'],
      category: data['category'],
      fromlocation: data['fromlocation'],
      tolocation: data['tolocation'],
      description: data['description'],
      imagePath: data['imagePath'],
      status: data['status'],
      donoruid: data['donoruid'],
      reciveruid: data['reciveruid'],
      deleiveruid: data['deleiveruid'],
      donatetime: (data['donatetime'] as Timestamp).toDate(),
      recivetime: data['recivetime'] != null
          ? (data['recivetime'] as Timestamp).toDate()
          : null,
      deleviretime: data['deleviretime'] != null
          ? (data['deleviretime'] as Timestamp).toDate()
          : null,
      deliveryDeadline: data['deliveryDeadline'] != null
          ? data['deliveryDeadline'] as Timestamp
          : null,

      donorRated: data['donorRated'] ?? false,
      deliverRated: data['deliverRated'] ?? false,
      receiverRated: data['receiverRated'] ?? false,
      reciveDate: data['reciveDate'] != null
          ? (data['reciveDate'] as Timestamp).toDate()
          : null,

    );
  }


}
