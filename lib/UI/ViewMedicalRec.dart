import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:MediDoc/UI/MedicalRecodes.dart';

class ViewMedicalRec extends StatefulWidget {
  final DocumentSnapshot medicalrecodes;

  const ViewMedicalRec({Key key, this.medicalrecodes}) : super(key: key);
  @override
  _ViewMedicalRecState createState() => _ViewMedicalRecState();
}

class _ViewMedicalRecState extends State<ViewMedicalRec> {
  FirebaseAuth fAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Recodes"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
            ),

            Text("Name:  " + widget.medicalrecodes['Name'],
                style: TextStyle(fontSize: 20)),
            Text("Email Address:   " + widget.medicalrecodes['Email'],
                style: TextStyle(fontSize: 15)),
            Text("Reason:   " + widget.medicalrecodes['Reason'],
                style: TextStyle(fontSize: 15)),
            Text("Consult Doctor Name:   " + widget.medicalrecodes['Doctor'],
                style: TextStyle(fontSize: 15)),
            Text("Date:   " + widget.medicalrecodes['Date'],
                style: TextStyle(fontSize: 15)),
//ClipOval(child: CachedNetworkImage(imageUrl: fAuth.currentUser.photoURL,),)
          ],
        ),
      ),
    );
  }
}
