import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qusai/screens/common_screens/another_profile.dart';
import 'package:qusai/shared/shared.dart';

class accept_reject_new_user extends StatelessWidget {
  const accept_reject_new_user({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('requests').snapshots(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: Text(
                    'There is no requests yet.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context , index ) => buildChatItem(
                        context,
                      snapshot.data!.docs[index].data()['uid'],
                      snapshot.data!.docs[index].data()['name'],
                    ),
                ),
              );
            },
        ),
      ),
    );
  }
}
Widget buildChatItem(context, uid, name) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: MaterialButton(
    onPressed: () { navigateto(context, another_profile(uid: uid)); },
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 8,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('users').doc(uid).update(
                    {
                      'havepermission': true,
                      'askpermission' :false,
                    }
                );

                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(uid)
                    .delete();

              },
              icon: Icon(Icons.check_box, size: 20),
              label: Text('Accept'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.withOpacity(0.5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(width: 8,),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('users').doc(uid).update(
                    {
                      'askpermission' :false,
                    }
                );

                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(uid)
                    .delete();

              },
              icon: Icon(Icons.remove_circle, size: 20),
              label: Text('Reject'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.withOpacity(0.5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
