import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  String cameraScanResult;
  DocumentSnapshot appointment;

  void getDoc(data) async {
    String docID = data.split('|')[0];
    String email = data.split('|')[1];

    print(docID);
    print(email);

    FirebaseFirestore.instance
        .collection('User')
        .doc(email)
        .collection('Appointments')
        .doc(docID)
        .update({'Status': 'CHECKED'}).then((value) {
      Get.snackbar('Success', 'Marked as Checked In',
          backgroundColor: Colors.white);
    });
  }

  void scanQR() async {
    cameraScanResult = await scanner.scan();
    getDoc(cameraScanResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      width: Get.width / 2,
      height: 64,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: () {
          scanQR();
        },
        child: Text('Scan QR',  style: TextStyle(
            fontSize: 24
        )),
      ),
    )));
  }
}
