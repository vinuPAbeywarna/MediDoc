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
              Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              
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
                            width: 2,
                            color: Colors.blue.shade900,
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
                            border: Border.all(width: 1,color: Theme.of(context).scaffoldBackgroundColor,),
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTestField("Full Name", "Nextvnext"),
              buildTestField("Email", "Nextvnext66@gmail.com"),
              buildTestField("Address", "No.2,Colomobo Road,Colombo."),
              buildTestField("Telephone", "0772323333"),
              SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    //padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(20) ),
                    onPressed: ()
                    {},
                    color: Colors.blue.shade900,
                    child: Text("SAVE",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white)),
                    ),

                    RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    //padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(20) ),
                    onPressed: ()
                    {},
                    color: Colors.red.shade900,
                    child: Text("CANCEL",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white)),
                    ),
                    
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTestField(String labelText, String placeholder) {
    return Padding(
      //padding: const EdgeInsets.only(bottom :15.0),
      padding: const EdgeInsets.all(10.0),
      child: TextField(
          decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 4),
        
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle:  TextStyle(
        fontSize: 16,
        color: Colors.black,
      )
      ),
      ),
    );
  }
}
