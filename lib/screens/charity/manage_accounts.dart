import 'package:flutter/material.dart';

class manage_accounts extends StatelessWidget {
  const manage_accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        // leading: IconButton(
        // icon: const Icon(Icons.arrow_back_outlined),
        // onPressed: () {
        //   Navigator.pop(context);
        // },
        // ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for users',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
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
            icon: Icon(Icons.person, size: 16),
            label: Text('profile'),
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
            icon: Icon(Icons.remove_circle, size: 16),
            label: Text('Decline'),
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
