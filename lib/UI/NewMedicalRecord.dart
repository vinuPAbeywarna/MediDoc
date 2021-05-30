import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMedicalRecord extends StatefulWidget {
  const NewMedicalRecord({Key key}) : super(key: key);

  @override
  _NewMedicalRecordState createState() => _NewMedicalRecordState();
}

class _NewMedicalRecordState extends State<NewMedicalRecord> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;
  FirebaseAuth fAuth = FirebaseAuth.instance;

  List<String> users = [];
  String selectedUser;

  TextEditingController mrec = TextEditingController();

  void getUsers() async{
    await fStore.collection('User').get().then((value){
      setState(() {
        value.docs.forEach((element) {
          users.add(element.id);
        });
      });
    });
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('New Medical Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton(
              underline:Container(),
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
            SizedBox(height: 32),
            Container(
              height: 64,
              width: Get.width,
              child: ElevatedButton(onPressed: (){
                fStore.collection('MedicalRecodes')
                    .add({
                  'Nurse': fAuth.currentUser.displayName,
                  'NurseEmail': fAuth.currentUser.email,
                  'Record': mrec.text,
                  'Date': DateTime.now().toLocal(),
                  'Patient': selectedUser,
                }).then((value){
                  Get.snackbar('Success', 'Record Added', backgroundColor: Colors.white);
                });
              }, child: Text('Add')),
            )
          ],
        ),
      )
    );
  }
}
