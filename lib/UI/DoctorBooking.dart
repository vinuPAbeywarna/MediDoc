import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorBooking extends StatefulWidget {
  final DocumentSnapshot doctor;

  const DoctorBooking({Key key, this.doctor}) : super(key: key);
  @override
  _DoctorBookingState createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
