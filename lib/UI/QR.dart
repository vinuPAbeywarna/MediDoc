import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {

  String cameraScanResult = 'Get Result';

  Uint8List result;

  void makeQR(data) async{
    result = await scanner.generateBarCode(data);
    setState(() {
    });
  }


  void scanQR() async{
     cameraScanResult = await scanner.scan();
     makeQR(cameraScanResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                scanQR();
              },
              child: Text(cameraScanResult),
            ),
            result == null ? Container() : Image.memory(result),
          ],
        ),
      ),
    );
  }
}
