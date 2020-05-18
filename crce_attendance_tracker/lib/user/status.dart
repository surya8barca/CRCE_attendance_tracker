import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  static String uid;

  DocumentSnapshot userdetails;
  Color attendancecolor = Colors.green;
  String alert = 'Attendance above required (75%)';
  double practicalattendance, theoryattendance;

  final CollectionReference userdata =
      Firestore.instance.collection('Database');

  Future<void> getattendance() async {
    try {
      final CollectionReference practicalsubjects =
          Firestore.instance.collection('${uid}_Practical Subjects');
      final CollectionReference theorysubjects =
          Firestore.instance.collection('${uid}_Theory Subjects');
      QuerySnapshot theory = await theorysubjects.getDocuments();
      QuerySnapshot pracs = await practicalsubjects.getDocuments();
      double total1 = 0, total2 = 0;
      for (int i = 0; i < pracs.documents.length; i++) {
        total1 = total1 + pracs.documents[i].data["attendance"];
      }
      for (int i = 0; i < theory.documents.length; i++) {
        total2 = total2 + theory.documents[i].data["attendance"];
      }
      print("total theory:${total2.toStringAsPrecision(3)}");
      print("total pracs:${total1.toStringAsPrecision(3)}");

      setState(() {
        practicalattendance = total1 / pracs.documents.length;
        theoryattendance = total2 / theory.documents.length;
      });

      print("theory:${theoryattendance.toStringAsPrecision(3)}");
      print("pracs:${{practicalattendance.toStringAsPrecision(3)}}");

      await userdata.document(uid).updateData({
        "attendance": ((practicalattendance + theoryattendance) / 2),
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> setuid() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        uid = user.uid;
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> getuserdetails() async {
    try {
      await setuid();
      await getattendance();
      DocumentSnapshot result = await userdata.document(uid).get();
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
          decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                    color: Colors.yellow,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Theory Attendance: ${theoryattendance.toStringAsPrecision(3)}%',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 25,
                ),
              ),
              Text(
                'Practical Attendance: ${practicalattendance.toStringAsPrecision(3)}%',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 25,
                ),
              ),
              Center(
                child: Text(
                  'Overall Attendance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyan,
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
                  '${userdetails.data["attendance"].toStringAsPrecision(3)} %',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: attendancecolor,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  alert,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: attendancecolor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  '(Use Navbar for adding lectures)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
