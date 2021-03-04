import 'package:MediDoc/UI/HomeHome.dart';
import 'package:MediDoc/UI/Profile.dart';
import 'package:MediDoc/UI/QR.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                  onTap: () {},
                  title: Text('My Sex Life'),
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.blue.shade900,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('My Sex Life'),
                  leading: Icon(
                    Icons.add_circle_outlined,
                    color: Colors.blue.shade900,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('My Sex Life'),
                  leading: Icon(
                    Icons.file_copy_outlined,
                    color: Colors.blue.shade900,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('My Sex Life'),
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
        controller: pageController,
        children: [Profile(), HomeHome(), QRScan()],
      ),
    );
  }
}

// Group: Header
