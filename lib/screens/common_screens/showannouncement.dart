import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/shared/shared.dart';

class show_announecement extends StatelessWidget {
  late announcement current;
  show_announecement({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC),
        title: Text(
          current.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                    await FirebaseFirestore.instance
                    .collection('read_announcements')
                    .doc('${userid}_${current.id}')
                    .set({
                      'userId': userid,
                      'announcementId': current.id,
                    });
                    Navigator.pop(context, current.id);
              },

              icon: Icon(Icons.delete_outline,)),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // 🌟 Gradient background
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Text(
              current.message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
