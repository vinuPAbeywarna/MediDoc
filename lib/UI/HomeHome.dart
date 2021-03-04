import 'package:flutter/material.dart';

class HomeHome extends StatefulWidget {
  @override
  _HomeHomeState createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.home),
      ),
    );
  }
}


@override
Widget buildImage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Medi Doc'),
      centerTitle: true,
      backgroundColor: const Color(0xFF0077FF),
    ),
    body: Center(
      child: Image(
        image: AssetImage('assets/logo.png'),
      ),
    ),
  );
}


@override
Widget buildI(BuildContext context) {
  return SizedBox(
    width: 411.0,
    height: 287.0,
    child: Stack(
      children: <Widget>[
        Container(
          width: 263.0,
          height: 287.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 38.0,
          child: Text(
            'Medi Doc',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 60.0,
              color: const Color(0xFF080707),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}
