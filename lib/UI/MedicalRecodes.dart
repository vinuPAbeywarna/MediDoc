import 'package:medidoc/Classes/CommonData.dart';
import 'package:medidoc/UI/NewMedicalRecord.dart';
import 'package:medidoc/UI/ViewMedicalRec.dart';
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
      appBar: AppBar(
        title: Text("Medical Recodes"),
        backgroundColor: Colors.blue.shade900,
        actions: <Widget>[
          Visibility(
              visible:  userData['Type']=='Nurse',
              child: TextButton(onPressed: (){
                Get.to(()=>NewMedicalRecord());
              }, child: Text('+ Add',style: TextStyle(color: Colors.white))))
        ],
      ),
      body: StreamBuilder(
          stream: userData['Type']=='Nurse' ? fStore.collection('MedicalRecodes').snapshots()
              : fStore.collection('MedicalRecodes').where('Patient',isEqualTo: fAuth.currentUser.email).snapshots(),
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
                  onTap: () {
                  },
                  title: Text(document['Record']),
                  subtitle: Text(document['Nurse'] +
                      ' | ' +
                      document['Date'].toDate().toString()),

                ),
              );
              }).toList() ,
            );
          }),
    );
  }
}
