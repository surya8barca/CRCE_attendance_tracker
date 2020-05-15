import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
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
        child: Container(child: Text(userdetails.data["name"])),
      );
    }
  }
}
