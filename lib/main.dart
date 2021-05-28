import 'package:MediDoc/Auth/SingleSignIn.dart';
import 'package:MediDoc/Classes/CommonData.dart';
import 'package:MediDoc/UI/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(FirebaseAuth.instance.currentUser != null){
    userData = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.email).get();
  }

  runApp(MediDoc());
}

class MediDoc extends StatelessWidget {
  final FirebaseAuth fAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MediDoc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade900,
        )),
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        primaryColor: Colors.blue.shade900,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: fAuth.currentUser != null ? Home() : SingleSignIn(),
    );
  }
}
