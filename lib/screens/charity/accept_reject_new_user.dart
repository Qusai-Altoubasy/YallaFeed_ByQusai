import 'package:flutter/material.dart';

class accept_reject_new_user extends StatelessWidget {
  const accept_reject_new_user({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder:(context , index ) => buildChatItem(),
                separatorBuilder: (context , index ) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: 20),
          ),
        ],
      ),
    );
  }
}
Widget buildChatItem() => Padding(
  padding: const EdgeInsets.all(8.0),
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
          'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
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
            onPressed: () {},
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
            onPressed: () {},
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
);
