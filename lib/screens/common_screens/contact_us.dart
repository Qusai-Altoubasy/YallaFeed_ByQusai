import 'package:flutter/material.dart';

class contact_us extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '1- osama',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'Number : 0785386494',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'E-mail : osamaameerah2@gmail.com',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 1.5,
            ),
            Text(
              '2- Qusai',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'Number : 0795351305',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'E-mail : qaaltwbasy@cit.edu.just',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 1.5,
            ),
            Text(
              '3- Abu issa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'Number : 0788720240',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'E-mail : ammohammad2197@cit.just.edu.jo',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 1.5,
            ),
            Text(
              '4- Waleed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'Number : 0792915033',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'E-mail : wtaldweik21@cit.just.edu.jo',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 1.5,
            ),

          ],
        ),
      ),
    );
  }
}
