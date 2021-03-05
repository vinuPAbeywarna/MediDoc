import 'package:MediDoc/Auth/SingleSignIn.dart';

import 'package:MediDoc/UI/Profile.dart';
import 'package:MediDoc/UI/QR.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:MediDoc/UI/MyAppointments.dart';
import 'package:MediDoc/UI/DoctorChanneling.dart';
import 'package:MediDoc/UI/MedicalRecodes.dart';
import 'package:MediDoc/UI/Payments.dart';
import 'package:MediDoc/UI/UserDetails.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth fAuth = FirebaseAuth.instance;

  int page = 1;
  PageController pageController = new PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Colors.blue.shade900,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(size: 32),
          currentIndex: page,
          onTap: (val) {
            setState(() {
              page = val;
              pageController.jumpToPage(val);
            });
          },
          items: [
            BottomNavigationBarItem(
                label: 'Profile', icon: Icon(Icons.supervised_user_circle)),
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'QR', icon: Icon(Icons.qr_code))
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                      child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: fAuth.currentUser.photoURL,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fAuth.currentUser.displayName,
                              style: TextStyle(
                                  fontSize: 21, color: Colors.blue.shade900),
                            ),
                            Text('USER TYPE')
                          ],
                        )
                      ],
                    ),
                  )),
                  ListTile(
                    onTap: () {
                      Get.to(() => MyAppoinments());
                    },
                    title: Text('My Appointments'),
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => DoctorChanneling());
                    },
                    title: Text('New Appointments'),
                    leading: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => MedicalRecodes());
                    },
                    title: Text('Medical Recodes'),
                    leading: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => UserDetails());
                    },
                    title: Text('Account Settings'),
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () async {
                  await fAuth.signOut();
                  await GoogleSignIn().signOut();
                  Get.offAll(SingleSignIn());
                },
                title: Text('SignOut'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        body: PageView(
          onPageChanged: (val) {
            setState(() {
              page = val;
            });
          },
          controller: pageController,
          children: [
            Profile(),
            GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              crossAxisCount: 2,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => DoctorChanneling());
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/image 1.png',
                          width: 270, height: 165),
                      //OutlineButton(onPressed:()=> MyAppoinments() ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => MedicalRecodes());
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/image 4.png',
                          width: 270, height: 165),
                      //OutlineButton(onPressed:()=> MyAppoinments() ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => Payments());
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/image 3.png',
                          width: 270, height: 165),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => UserDetails());
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/image 5.png',
                          width: 270, height: 165),
                    ],
                  ),
                ),
              ],
            ),
            QRScan()
          ],
        ));
  }
}

// Group: Header
