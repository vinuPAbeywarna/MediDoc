import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medidoc/Classes/CommonData.dart';
import 'package:medidoc/UI/Home.dart';

class SingleSignIn extends StatefulWidget {
  @override
  _SingleSignInState createState() => _SingleSignInState();
}

class _SingleSignInState extends State<SingleSignIn> {
  void signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser.email)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists){
          userData = await FirebaseFirestore.instance
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser.email)
              .get();
          Get.offAll(() => Home());
        } else {
          await FirebaseFirestore.instance
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser.email).set({
            'Type':'Patient',
            'Name': FirebaseAuth.instance.currentUser.displayName,
            'Email':FirebaseAuth.instance.currentUser.email,
            'Photo': FirebaseAuth.instance.currentUser.photoURL
          }).then((value) async{
            userData = await FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser.email)
                .get();
            Get.offAll(() => Home());
          });

        }
      });
    }).onError((error, stackTrace){
      Get.snackbar('SignIn Failed', error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/stethoscope.png'),
            ),
            Text(
              'MediDoc',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            Text(
              'SignIn to Continue',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 64),
            Container(
              width: Get.width/2,
              height: 64,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: Text(
                    'SignIn',
                    style: TextStyle(
                      fontSize: 24
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
