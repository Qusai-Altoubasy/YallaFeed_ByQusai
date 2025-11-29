import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/admin/admin_cubit.dart';
import 'package:qusai/cubits/admin/admin_states.dart';

class AnnouncementDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var messagecontroller= TextEditingController();
    var sendtocontroller=TextEditingController();

    return BlocProvider(
      child: BlocConsumer<admin_cubit, admin_state>(
        builder: (context, state){
          var cubit = admin_cubit.get(context);
          return Scaffold(
        backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text('📢 Announcements'),
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📝 Create New Announcement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: titlecontroller,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: messagecontroller,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Send To',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select group...',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if(titlecontroller.text.length!=0 && messagecontroller.text.length!=0 && sendtocontroller.text.length!=0) {
                              cubit.send_announcement(
                                  titlecontroller.text, messagecontroller.text,
                                  sendtocontroller.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'The announcement have been sent successfully')),
                              );
                              Navigator.pop(context);
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Please enter valid contects')),
                              );
                            }

                          },
                          icon: Icon(Icons.send),
                          label: Text('Send Announcement'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        },
        listener: (context, state){},
      ),
      create: (BuildContext context)=> admin_cubit(),
    );
  }
}