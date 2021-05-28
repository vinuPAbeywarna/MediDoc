import 'package:MediDoc/UI/UserDetailsView.dart';
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

  final AppBarController appBarController = AppBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: SearchAppBar(
        primary: Theme.of(context).primaryColor,
        appBarController: appBarController,
        // You could load the bar with search already active
        autoSelected: false,
        searchHint: "Search Here...",
        mainTextColor: Colors.white,
        onChange: (String value) {
          //Your function to filter list. It should interact with
          //the Stream that generate the final list
        },

        mainAppBar: AppBar(
          title: Text("Users"),
          backgroundColor: Colors.blue.shade900,
          actions: <Widget>[
            InkWell(
              child: Icon(
                Icons.search,
              ),
              onTap: () {
                //This is where You change to SEARCH MODE. To hide, just
                //add FALSE as value on the stream
                appBarController.stream.add(true);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('User').get().asStream(),
          builder: (context, data) {
            return ListView.builder(
                itemCount: data.connectionState == ConnectionState.done
                    ? data.data.docs.length
                    : 0,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      onTap: () {

                      },

                      leading: CircleAvatar(),
                      title: Text(data.data.docs[index]['Name']),
                      subtitle: Text(data.data.docs[index]['Email']),

                      // trailing: Icon(Icons.delete_forever_rounded,color: Colors.blue.shade900,),
                    ),
                  );
                });
          }),
    );
  }
}
