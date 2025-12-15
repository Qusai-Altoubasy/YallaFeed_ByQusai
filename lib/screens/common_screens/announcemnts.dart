import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/screens/common_screens/showannouncement.dart';
import 'package:qusai/shared/shared.dart';



class announcemnts_shared extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('announcements')
          .where('sendto', isEqualTo: 'group3')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('There are no announcements'));
        }

        var docs = snapshot.data!.docs;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Announcements'),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,)),
            ],
          ),
          body: ListView.builder(
              itemBuilder:(context , index ) => buildChatItem(context, docs[index]),
              itemCount: docs.length
          ),
        );
      }
    );
  }
}

Widget buildChatItem(BuildContext context, QueryDocumentSnapshot doc) => InkWell(
  onTap: () {
    announcement x=announcement(
        title: doc['title'],
        message: doc['message'],
        sendTo: doc['sendto'],
        owener: doc['owener']);

    navigateto(context, show_announecement(current: x));
  },
  borderRadius: BorderRadius.circular(10),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        const Icon(Icons.mark_email_unread_outlined,),
        const SizedBox(width: 20.0),
        Expanded(
          child: Text(
            doc['title'],
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
  ),
);