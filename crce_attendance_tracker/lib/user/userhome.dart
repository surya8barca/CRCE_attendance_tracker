import 'package:crce_attendance_tracker/user/display.dart';
import 'package:crce_attendance_tracker/user/practical.dart';
import 'package:crce_attendance_tracker/user/theory.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int index = 1;
  List pages = [TheorySubjects(), Display(), PracticalSubjects()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black,
      drawer: Drawer(), //spcifics to be added later
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
    );
  }
}
