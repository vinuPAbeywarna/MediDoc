import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  FirebaseAuth fAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Account details'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 16,
          ),
          Center(
            child: Container(
              width: 130,
              height: 130,
              child: ClipOval(
                  child: CachedNetworkImage(
                imageUrl: fAuth.currentUser.photoURL,
              )),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            'Name',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            fAuth.currentUser.displayName,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            'Email',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            fAuth.currentUser.email,
            style: TextStyle(fontSize: 21),
          ),
        ],
      ),
    );
  }
}
