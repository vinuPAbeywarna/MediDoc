import 'package:flutter/material.dart';

class SingleSignIn extends StatefulWidget {
  @override
  _SingleSignInState createState() => _SingleSignInState();
}

class _SingleSignInState extends State<SingleSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text('SignIn'),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
