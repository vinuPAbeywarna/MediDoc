import 'package:flutter/material.dart';

class MedicalRecodes extends StatefulWidget {
  @override
  _MedicalRecodesState createState() => _MedicalRecodesState();
}

class _MedicalRecodesState extends State<MedicalRecodes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Recodes'),
        backgroundColor: Colors.lightBlue.shade800,
      ),
    );
  }
}
