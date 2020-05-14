

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/loading.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  dynamic userdetails;

  Future<void> getuserdetails() async {
    
    try{
      final CollectionReference userdata = Firestore.instance.collection('Database');
      dynamic result = await userdata.document('User Details').get(); 
      setState((){
      userdetails= result;
    });
    }
    catch(e)
    {
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
    if(userdetails==null)
    {
      return Loading();
    }
    else
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            userdetails["name"],
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
  }
}