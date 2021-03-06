import 'package:flutter/material.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Account Settings'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text("Edit Profile"),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.black,
                          ),
                          //boxShadow: (

                          //Offset:
                          //),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(""))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.edit,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTestField("Full Name", "Nextvnext"),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTestField(String labelText, String placeholder) {
    return TextField(
        decoration: InputDecoration(
      contentPadding: EdgeInsets.only(bottom: 3),
      labelText: "Full name",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: placeholder,
      //hintText:  TextStyle(
      //frontSize: 16,
      //color: Colors.black,
    ));
  }
}
