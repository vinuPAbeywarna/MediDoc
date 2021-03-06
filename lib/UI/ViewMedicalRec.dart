import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewMedicalRec extends StatefulWidget {
  final DocumentSnapshot medicalrecodes;

const ViewMedicalRec({Key key, this.medicalrecodes}) : super(key: key);
  @override
  _ViewMedicalRecState createState() => _ViewMedicalRecState();
}

class _ViewMedicalRecState extends State<ViewMedicalRec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
