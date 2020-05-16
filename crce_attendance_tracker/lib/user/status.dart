import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {

  DocumentSnapshot userdetails;
  Color attendancecolor = Colors.green;
  String alert = 'Attendance above required (75%)';
  double practicalattendance,theoryattendance;

  final CollectionReference userdata =
          Firestore.instance.collection('Database');
  final CollectionReference practicalsubjects =
          Firestore.instance.collection('Practical Subjects');
  final CollectionReference theorysubjects =
          Firestore.instance.collection('Theory Subjects');

  Future<void> getattendance() async{
    try{
      QuerySnapshot theory=await theorysubjects.getDocuments();
      QuerySnapshot pracs=await practicalsubjects.getDocuments();
      double total1=0,total2=0;
      for(int i=0;i<pracs.documents.length;i++)
      {
        total1=total1+pracs.documents[i].data["attendance"];
      }
      for(int i=0;i<theory.documents.length;i++)
      {
        total2=total2+theory.documents[i].data["attendance"];
      }
      print("total theory:${total2.toStringAsPrecision(4)}");
      print("total pracs:${total1.toStringAsPrecision(4)}");

      setState(() {
        practicalattendance=total1/pracs.documents.length;
        theoryattendance=total2/theory.documents.length;
      });

      print("theory:${theoryattendance.toStringAsPrecision(4)}");
      print("pracs:${{practicalattendance.toStringAsPrecision(4)}}");

      await userdata.document('User Details').updateData({

        "attendance":((practicalattendance+theoryattendance)/2),
      });    
      }
    catch(e)
    {
      print(e.message);
    }
  }

  Future<void> getuserdetails() async {
    try {
      await getattendance();
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
          width: MediaQuery.of(context).size.width,
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
                  '${userdetails.data["attendance"].toStringAsPrecision(4)} %',
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
                height: 70,
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
