import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth fAuth = FirebaseAuth.instance;

  QuerySnapshot unpaids;
  bool ready = false;

  void getUnPaid() async {
    unpaids = await firestore
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('Appointments')
        .where('PaymentID', isEqualTo: 'UNPAID')
        .get();
    setState(() {
      ready = true;
    });
  }

  void payhere(charge,docID) {
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "1216840",
      "merchant_secret": "4ks40L6hKmB4p6mnEXWHy548fdJ6mrF9Y4TxiSROzCib",
      "notify_url": "http://sample.com/notify",
      "order_id": "UNRELATED",
      "items": "Appointments Charge",
      "amount": charge,
      "currency": "LKR",
      "first_name": fAuth.currentUser.displayName,
      "last_name": fAuth.currentUser.displayName,
      "email": fAuth.currentUser.email,
      "phone": "UNRELATED",
      "address": "UNRELATED",
      "city": "UNRELATED",
      "country": "Sri Lanka",
      "delivery_address": "UNRELATED",
      "delivery_city": "UNRELATED",
      "delivery_country": "Sri Lanka",
      "custom_1": "UNRELATED",
      "custom_2": "UNRELATED"
    };

    PayHere.startPayment(paymentObject, (paymentId) async {
      await firestore
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser.email)
          .collection('Appointments')
          .doc(docID)
          .update({
        'PaymentID': paymentId,
        'PaymentDate':DateTime.now(),
      }).then((value){
        Get.snackbar(
            'Payment Success!',
            'Your Payment is Success!',
            backgroundColor: Colors.white);
        setState(() {
          ready = false;
        });
        getUnPaid();

      });
    }, (error) {
      print("One Time Payment Failed. Error: $error");
    }, () {
      print("One Time Payment Dismissed");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnPaid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Payments'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: ready
            ? ListView.builder(
                itemCount: unpaids.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        payhere(unpaids.docs[index]['Charge'].toString(), unpaids.docs[index].id);
                      },
                      child: Text('Pay Now'),
                    ),
                    title: Text('LKR ' + unpaids.docs[index]['Charge'].toString()),
                    subtitle: Text(weekdays[unpaids.docs[index]['Day']] +
                        ' at ' +
                        unpaids.docs[index]['Time']),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
