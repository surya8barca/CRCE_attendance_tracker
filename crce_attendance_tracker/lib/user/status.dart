import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  DocumentSnapshot userdetails;

  Future<void> getuserdetails() async {
    try {
      final CollectionReference userdata =
          Firestore.instance.collection('Database');
      DocumentSnapshot result = await userdata.document('User Details').get();
      setState(() {
        userdetails = result;
        print(userdetails.data);
      });
      if (userdetails.data['attendance'] < 75) {
        setState(() {
          attendancecolor = Colors.red;
          alert = 'Attendance below required (75%)';
        });
      }
    } catch (e) {
      print(e.message);
    }
  }

  Color attendancecolor = Colors.green;
  String alert = 'Attendance is good';

  @override
  void initState() {
    getuserdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userdetails == null) {
      return BodyLoading();
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Attendance record',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Current Attendance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: attendancecolor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  '${userdetails.data["attendance"].toString()} %',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: attendancecolor,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                alert,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: attendancecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Navbar for adding lectures',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 25,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 50,
                  ),
                  SizedBox(
                    width: 185,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
