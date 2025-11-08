import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qusai/screens/admin/admin_main_screen.dart';



class announcemnts_shared extends StatefulWidget {


  @override
  State<announcemnts_shared> createState() => _announcemnts_sharedState();
}

class _announcemnts_sharedState extends State<announcemnts_shared> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: Text('Announcements'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,)),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.separated(
                itemBuilder:(context , index ) => buildChatItem(context),
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

Widget buildChatItem(BuildContext context) => InkWell(
  onTap: () {

  },
  borderRadius: BorderRadius.circular(10),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        const Icon(Icons.mark_email_unread_outlined,),
        const SizedBox(width: 20.0),
        const Expanded(
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
        const SizedBox(width: 8),
      ],
    ),
  ),
);