import 'package:crce_attendance_tracker/loading.dart';
import 'package:crce_attendance_tracker/setup/start.dart';
import 'package:crce_attendance_tracker/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool databaseEmpty;

  Future<void> checkdatabaseEmptyence() async {
    try {
      QuerySnapshot snapshot =
          await Firestore.instance.collection('Database').getDocuments();
      if (snapshot.documents.isEmpty) {
        setState(() {
          databaseEmpty = true;
        });
      } else {
        
        databaseEmpty = false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    checkdatabaseEmptyence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (databaseEmpty == true) {
      return Start(); //first page (database setup)
    } else if(databaseEmpty == false) {
      return UserHome(); //general user home(after setup)
    }
    else{
      return Loading();
    }
  }
}
