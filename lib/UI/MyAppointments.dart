import 'package:MediDoc/UI/DoctorChanneling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyAppoinments extends StatefulWidget {
  @override
  _MyAppoinmentsState createState() => _MyAppoinmentsState();
}

class _MyAppoinmentsState extends State<MyAppoinments> {
  QuerySnapshot appointments;
  QuerySnapshot appointmentsPast;
  QuerySnapshot doctors;
  DateTime dtNow = DateTime.now();

  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  void getPast() async {
    appointmentsPast = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('Appointments')
        .where('Status', isEqualTo: 'CHECKED')
        .get();
  }

  void getUpcoming() async {
    appointments = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('Appointments')
        .where('Status', isEqualTo: 'UNCHECKED')
        .get();
    setState(() {
      print(appointments.docs.length);
    });
  }

  void getDoctors() async {
    doctors = await FirebaseFirestore.instance.collection('Doctors').get();
    setState(() {
      print(doctors.docs.length);
    });
  }

  @override
  void initState() {
    super.initState();
    getDoctors();
    getUpcoming();
    getPast();
    print(DateTime.now().weekday - 1);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            actions: [
              FlatButton(
                  onPressed: () {
                    Get.to(() => DoctorChanneling());
                  },
                  child: Text(
                    '+ New Appointment',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            elevation: 15,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.symmetric(horizontal: 18.0)),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.calendar_today), text: 'Upcoming'),
                Tab(icon: Icon(Icons.approval), text: 'Past'),
              ],
            ),
            title: Text('My Appointments'),
            backgroundColor: Colors.blue.shade900,
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: appointments == null ? 0 : appointments.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        Get.defaultDialog(
                          radius: 8,
                          title: 'Appointment',
                        );
                      },
                      title: Text(
                          weekdays[appointments.docs[index]['Day']].toString() +
                              " " +
                              appointments.docs[index]['Time']),
                      subtitle: Text(appointments.docs[index]['Time']),
                      trailing: ElevatedButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Check In',
                              content: Container(
                                height: 256,
                                width: 256,
                                child: QrImage(
                                  data: appointments.docs[index].id + '|' + FirebaseAuth.instance.currentUser.email,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              )
                            );
                          }, child: Text('CheckIn')));
                },
              ),
              ListView.builder(
                itemCount:
                    appointmentsPast == null ? 0 : appointmentsPast.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(weekdays[appointmentsPast.docs[index]['Day']]
                        .toString()),
                    subtitle: Text(appointments.docs[index]['Time']),
                    trailing: Text(
                        'LKR ' + appointments.docs[index]['Charge'].toString()),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget buildPage(String text) => Center(
        child: Text(
          text,
        ),
      );
}
