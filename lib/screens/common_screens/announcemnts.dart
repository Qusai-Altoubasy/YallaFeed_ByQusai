import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/screens/common_screens/showannouncement.dart';
import 'package:qusai/shared/shared.dart';



class announcemnts_shared extends StatefulWidget {

  @override
  State<announcemnts_shared> createState() => _announcemnts_sharedState();
}

class _announcemnts_sharedState extends State<announcemnts_shared> {
  List<String> readIds = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadReadAnnouncements();
  }

  Future<void> loadReadAnnouncements() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_announcements')
        .where('userId', isEqualTo: userid)
        .get();

    readIds =
        readSnapshot.docs.map((e) => e['announcementId'] as String).toList();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }


    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('announcements')
          .where('sendto', isEqualTo:
          usertype=='user'?'group1':'group2'
          )
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var docs = snapshot.data!.docs
            .where((doc) => !readIds.contains(doc.id))
            .toList();


        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Announcements'),
            ),
            body: Center(child: Text('There are no announcements')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Announcements'),
          ),
          body: ListView.builder(
              itemBuilder:(context , index ) => buildChatItem(context, docs[index]),
              itemCount: docs.length
          ),
        );
      }
    );
  }
  Widget buildChatItem(BuildContext context, QueryDocumentSnapshot doc) => InkWell(
    onTap: ()async {
      announcement x = announcement(
          title: doc['title'],
          message: doc['message'],
          sendTo: doc['sendto'],
          owener: doc['owener'],
          id: doc.id
      );

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => show_announecement(current: x),
        ),
      );

      if (result != null) {
        setState(() {
          readIds.add(result);
        });
      }
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
}

