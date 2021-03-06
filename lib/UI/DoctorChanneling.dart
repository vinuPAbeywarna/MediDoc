import 'package:MediDoc/UI/DoctorBooking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorChanneling extends StatefulWidget {
  @override
  _DoctorChannelingState createState() => _DoctorChannelingState();
}

class _DoctorChannelingState extends State<DoctorChanneling> {
  FirebaseFirestore fStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: StreamBuilder(
          stream: fStore.collection('Doctors').get().asStream(),
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
                        Get.to(() => DoctorBooking(
                              doctor: data.data.docs[index],
                            ));
                      },
                      leading: CircleAvatar(),
                      title: Text(data.data.docs[index]['Name']),
                      subtitle: Text(data.data.docs[index]['Type'] +
                          ' | ' +
                          data.data.docs[index]['Hospital']),
                          

                   // trailing: Icon(Icons.delete_forever_rounded,color: Colors.blue.shade900,),

                    ),
                  );
                });
          }),
    );
  }
}
