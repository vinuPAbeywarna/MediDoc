

import 'package:MediDoc/UI/DoctorChanneling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MyAppoinments extends StatefulWidget {
  @override
  _MyAppoinmentsState createState() => _MyAppoinmentsState();
}

class _MyAppoinmentsState extends State<MyAppoinments> {
  @override
  Widget build(BuildContext context) => DefaultTabController (
   // return Scaffold(
     // home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            actions: [
              FlatButton(
                  onPressed: (){
                    Get.to(()=>DoctorChanneling());
                  },
                  child: Text('+ New Appointment',style: TextStyle(color: Colors.white),)
              )
            ],
            elevation: 15,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                insets:EdgeInsets.symmetric(horizontal: 18.0) ),
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
              //Icon(Icons.calendar_today),
              //Icon(Icons.approval),
		        buildPage('Upcoming'),
		        buildPage('Past'),
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

