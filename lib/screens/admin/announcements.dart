import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/classes/mainuser.dart';

class AnnouncementDesign extends StatelessWidget {
  late mainuser Owenr;
  late String uid;
  var formKey=GlobalKey<FormState>();


  AnnouncementDesign({required this.Owenr, required this.uid});

  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var messagecontroller= TextEditingController();
    String? selectedGroup;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('📢 Announcements'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
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
                      '📝 Send New Announcement',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty) {
                          return "The title must not be empty";
                        }
                        return null;
                        },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty) {
                          return "The message must not be empty";
                        }
                        return null;
                      },
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
                    DropdownButtonFormField<String>(
                      validator: (value){
                        if (value == null) {
                          return 'You must choose one option';
                        }
                        return null;
                      },
                      value: selectedGroup,
                      items: [
                        DropdownMenuItem(value: 'group1', child: Text('Users')),
                        DropdownMenuItem(value: 'group2', child: Text('Charities')),
                      ],
                      onChanged: (value){
                        selectedGroup = value;
                      },
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            announcement A = announcement(
                              title: titlecontroller.text,
                              message: messagecontroller.text,
                              sendTo: selectedGroup.toString(),
                              owener: uid,
                              id: 'dd'
                            );
                            try {
                              A.svaeindatabase();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'The announcement has been sent successfully')),
                              );
                              Navigator.pop(context);
                            }
                            catch (e) {}
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
      ),
    );


  }
}