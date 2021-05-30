
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
//import 'package:MediDoc/UI/DoctorBooking.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: StreamBuilder(
          stream: fStore.collection('User').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> data) {
            if(data.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: data.data.docs.map((DocumentSnapshot document){
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: document['Photo'],
                      ),
                    ),
                    title: Text(document['Name']),
                    subtitle: Text(document['Email']),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
