import 'package:MediDoc/Classes/CommonData.dart';
import 'package:MediDoc/UI/ViewMedicalRec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicalRecodes extends StatefulWidget {
  @override
  _MedicalRecodesState createState() => _MedicalRecodesState();
}

class _MedicalRecodesState extends State<MedicalRecodes> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;
  FirebaseAuth fAuth = FirebaseAuth.instance;

  final AppBarController appBarController = AppBarController();

  List<String> users = [];
  String selectedUser;

  TextEditingController mrec = TextEditingController();

  void getUsers() async{

    await fStore.collection('User').get().then((value){
      value.docs.forEach((element) {
        users.add(element.id);
      });
    });
  }

  void showInsertDialog(){
    Get.defaultDialog(
      title: 'New Medical Record',
      radius: 4,
      content: Column(
        children: [
          DropdownButton(
            hint: Text('Please Select a User'), // Not necessary for Option 1
            value: selectedUser,
            onChanged: (newValue) {
              setState(() {
                selectedUser = newValue;
              });
            },
            items: users.map((user) {
              return DropdownMenuItem(
                child: new Text(user),
                value: user,
              );
            }).toList(),
          ),
          TextField(
            minLines: 6,
            maxLines: 6,
            controller: mrec,
            decoration: InputDecoration(
              labelText: 'Medical Info',
              border: OutlineInputBorder()
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: (){Get.back();}, child: Text('Cancel')),
        ElevatedButton(onPressed: (){
          fStore.collection('User')
              .doc(selectedUser)
              .collection('MedicalRecords')
              .add({
            'Nurse': fAuth.currentUser.displayName,
            'NurseEmail': fAuth.currentUser.email,
            'Record': mrec.text,
            'Date': DateTime.now().toLocal(),
            'Patient': selectedUser,
          }).then((value){
            Get.back();
            Get.snackbar('Success', 'Record Added', backgroundColor: Colors.white);
          });
        }, child: Text('Add'))
      ]
    );
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }
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
            Visibility(
                visible:  userData['isNurse'],
                child: TextButton(onPressed: (){
                  showInsertDialog();
                }, child: Text('+ Add',style: TextStyle(color: Colors.white))))
          ],
        ),
      ),
      body: StreamBuilder(
          stream: fStore
              .collection('User')
              .doc(fAuth.currentUser.email)
              .collection('MedicalRecords')
              .get()
          .asStream(),
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
                      title: Text(data.data.docs[index]['Record']),
                      subtitle: Text(data.data.docs[index]['Nurse'] +
                          ' | ' +
                          data.data.docs[index]['Date'].toDate().toString()),

                    ),
                  );
                });
          }),
    );
  }
}
