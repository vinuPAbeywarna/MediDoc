import 'package:flutter/material.dart';

class Payments  extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Payments'),
         backgroundColor: Colors.blue.shade900,
      ),
    );
  }
}
