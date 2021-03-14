import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorBooking extends StatefulWidget {
  final DocumentSnapshot doctor;

  const DoctorBooking({Key key, this.doctor}) : super(key: key);
  @override
  _DoctorBookingState createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  FirebaseAuth fAuth = FirebaseAuth.instance;

  List<String> timeList = ['9:00 AM','12:00 PM','6:00 PM','9:00 PM'];
  List<String> dayList = ['Monday','Wednesday','Friday','Saturday'];

  String selectedTime = "9:00 AM";
  String selectedDay = "Monday";

  ButtonStyle unselected = ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black
  );

  ButtonStyle selected = ElevatedButton.styleFrom(
    primary: Colors.blue.shade900,
    onPrimary: Colors.white,
  );

  void addAppointment(){
    FirebaseFirestore.instance.collection('User')
        .doc(fAuth.currentUser.email)
        .collection('Appointments')
        .add({
      'DocID':widget.doctor.id,
      'Time':selectedTime,
      'Day': selectedDay,
      'Charge': widget.doctor['Charge']
    }).then((value){
      Get.snackbar('Confirmed', 'Mn Pkyya');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(widget.doctor['Name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              children: [
                Text("Email Address:   " + widget.doctor['Email'],
                    style: TextStyle(fontSize: 15)),
                Text("Type:   " + widget.doctor['Type'],
                    style: TextStyle(fontSize: 15)),
                Text("Working Hospital:   " + widget.doctor['Hospital'],
                    style: TextStyle(fontSize: 15)),
                Text("Description:   " + widget.doctor['Description'],
                    style: TextStyle(fontSize: 15)),

                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 72,
                  width: Get.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeList.length,
                    itemBuilder: (_,index){
                      return Container(
                        width: 128,
                        height: 64,
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          style: selectedTime==timeList[index] ? selected:unselected,
                          child: Text(timeList[index]),
                          onPressed: (){
                            setState(() {
                              selectedTime=timeList[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 72,
                  width: Get.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dayList.length,
                    itemBuilder: (_,index){
                      return Container(
                        width: 128,
                        height: 64,
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          style: selectedDay==dayList[index] ? selected:unselected,
                          child: Text(dayList[index]),
                          onPressed: (){
                            setState(() {
                              selectedDay=dayList[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16,bottom: 16),
                      width: Get.width*0.5,
                      height: 64,
                      child: Card(
                          color: Colors.blue.shade900,
                          child: Center(
                            child: Text("Charge:   " + widget.doctor['Charge'].toString(),
                                style: TextStyle(fontSize: 24, color: Colors.white)),
                          )
                      ),
                    )
                  ],
                ),
              ],
            ),



            Padding(
                padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      addAppointment();
                    },
                    child: Text('Confirm Appointment'),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
