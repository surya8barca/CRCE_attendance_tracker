import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/loading.dart';
import 'package:crce_attendance_tracker/user/status.dart';
import 'package:crce_attendance_tracker/user/practical.dart';
import 'package:crce_attendance_tracker/user/theory.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int index = 1;
  List pages = [TheorySubjects(), Status(), PracticalSubjects()];
  Map userdetails;

  Future<void> getUserDetails()async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    String uid = currentUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('Database').document(uid).get();
    setState(() {
      userdetails=result.data;
      print(userdetails);
    });
  }


  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(userdetails==null)
    {
      return Loading();
    }
    else{
    return SafeArea(
          child: Scaffold(
        drawer: Drawer(
          elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/back.jpg'),
                  fit: BoxFit.cover,
                  ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    minRadius: 50,
                    backgroundImage: AssetImage('images/user.png'),
                  ),
                  Text(
                    userdetails["name"],
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ],

              ),
            ),
          ],
        ),

        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Attendance Tracker',
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.blue,
            ),
          ),
        ),
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.linearToEaseOut,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.transparent,
          index: 1,
          items: <Widget>[
            Icon(
              Icons.book,
              color: Colors.blue,
              size: 40,
            ),
            Icon(
              Icons.home,
              color: Colors.blue,
              size: 40,
            ),
            Icon(
              Icons.laptop_chromebook,
              color: Colors.blue,
              size: 40,
            ),
          ],
          buttonBackgroundColor: Colors.black,
          height: 60,
          color: Colors.black,
        ),
      ),
    );
  }
  }
}
