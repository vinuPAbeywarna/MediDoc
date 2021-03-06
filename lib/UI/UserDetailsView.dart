import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:MediDoc/UI/Userdetails.dart';

class UserDetailsview extends StatefulWidget {
  final DocumentSnapshot user;

const UserDetailsview({Key key, this.user}) : super(key: key);
@override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}