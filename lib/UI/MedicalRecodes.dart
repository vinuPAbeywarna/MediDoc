import 'package:MediDoc/UI/ViewMedicalRec.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class MedicalRecodes extends StatefulWidget {
  @override
  _MedicalRecodesState createState() => _MedicalRecodesState();
}


class _MedicalRecodesState extends State<MedicalRecodes> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Recodes'),
        backgroundColor: Colors.blue.shade900,
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
                          

                    trailing: Icon(Icons.delete_forever_rounded,color: Colors.blue.shade900,),
                    

                    ),
                  );
                });
          }),
    );
  }
}