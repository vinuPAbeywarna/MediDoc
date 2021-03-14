import 'package:MediDoc/UI/ViewMedicalRec.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

class MedicalRecodes extends StatefulWidget {
  @override
  _MedicalRecodesState createState() => _MedicalRecodesState();
}

/*class _MedicalRecodesState extends State<MedicalRecodes> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Bar Demo'),
        actions: [searchBar.getSearchAction(context)]);
  }*/

class _MedicalRecodesState extends State<MedicalRecodes> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;

  //@override
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
        searchHint: "Search your Medical Recodes...",
        mainTextColor: Colors.white,
        onChange: (String value) {
          //Your function to filter list. It should interact with
          //the Stream that generate the final list
        },
        //Will show when SEARCH MODE wasn't active
        mainAppBar: AppBar(
          title: Text("Medical Recodes"),
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
          stream: fStore.collection('MedicalRecodes').get().asStream(),
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
                        Get.to(() => ViewMedicalRec(
                              medicalrecodes: data.data.docs[index],
                            ));
                      },
                      title: Text(data.data.docs[index]['Name']),
                      subtitle: Text(data.data.docs[index]['Email'] +
                          ' | ' +
                          data.data.docs[index]['Date']),
                      trailing: Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
