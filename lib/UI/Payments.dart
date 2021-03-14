import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  void payhere(){
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "1216840",
      "merchant_secret": "4ks40L6hKmB4p6mnEXWHy548fdJ6mrF9Y4TxiSROzCib",
      "notify_url": "http://sample.com/notify",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "amount": "50.00",
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(
        paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
    }, () {
      print("One Time Payment Dismissed");
    }
    );
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
        child: ElevatedButton(
          onPressed: (){
            payhere();
          },
          child: Text('Pay'),
        ),
      ),
    );
  }
}
