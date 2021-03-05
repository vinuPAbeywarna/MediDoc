import 'package:flutter/material.dart';

//import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MyAppoinments extends StatefulWidget {
  @override
  _MyAppoinmentsState createState() => _MyAppoinmentsState();
}

class _MyAppoinmentsState extends State<MyAppoinments> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                insets:EdgeInsets.symmetric(horizontal: 18.0) ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.approval)),
              ],
            ),
            title: Text('My Appointments'),
            backgroundColor: Colors.lightBlue.shade700,
          ),
          //backgroundColor: Colors.lightBlue.shade800,
          body: TabBarView(
            children: [
              Icon(Icons.calendar_today),
              Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
