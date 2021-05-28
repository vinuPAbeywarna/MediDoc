import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDetailsView extends StatefulWidget {
  final DocumentSnapshot user;

  const UserDetailsView({Key key, this.user}) : super(key: key);
  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  FirebaseAuth fAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Users"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
            ),
            //ClipOval(child: CachedNetworkImage(imageUrl: fAuth.currentUser.photoURL,),),
            Text("Name:  " + widget.user['Name'],
                style: TextStyle(fontSize: 20)),
            Text("Email Address:   " + widget.user['Email'],
                style: TextStyle(fontSize: 15)),
            Text("User Type:   " + widget.user['User Type'],
                style: TextStyle(fontSize: 15)),

            Text("Telephone:   " + widget.user['Telephone'],
                style: TextStyle(fontSize: 15)),

            Text("Address:   " + widget.user['Address'],
                style: TextStyle(fontSize: 15)),

//ClipOval(child: CachedNetworkImage(imageUrl: fAuth.currentUser.photoURL,),)
          ],
        ),
      ),
    );
  }
}
