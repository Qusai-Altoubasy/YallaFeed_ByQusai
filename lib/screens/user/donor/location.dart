import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationPage extends StatefulWidget {
  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  LatLng? pickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(31.9539, 35.9106), // عمان
          zoom: 14,
        ),
        onTap: (LatLng pos) {
          setState(() {
            pickedPosition = pos;
          });
        },
        markers: pickedPosition == null
            ? {}
            : {
          Marker(
            markerId: MarkerId("picked"),
            position: pickedPosition!,
          )
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (pickedPosition != null) {
            Navigator.pop(context, pickedPosition);
          }
        },
      ),
    );
  }
}