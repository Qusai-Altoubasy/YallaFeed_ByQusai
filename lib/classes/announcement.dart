import 'package:cloud_firestore/cloud_firestore.dart';

class announcement {
  String title;
  String message;
  String sendTo;
  String owener;
  String id;

  announcement({
    required this.title,
    required this.id,
    required this.message,
    required this.sendTo,
    required this.owener,
  });

  Future<void> svaeindatabase() async {
    await FirebaseFirestore.instance.collection('announcements').doc().set(
        {
          'title':this.title,
          'message':this.message,
          'sendto':this.sendTo,
          'owener':this.owener,
          'time': FieldValue.serverTimestamp(),
        }
    );

  }
}