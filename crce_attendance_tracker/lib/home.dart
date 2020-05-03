import 'package:flutter/material.dart';
import 'package:crce_attendance_tracker/userhome.dart';
import 'package:crce_attendance_tracker/start.dart';

class Home extends StatefulWidget {

  final bool timetableAdded;
  Home({this.timetableAdded});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    if(widget.timetableAdded==null){
      return Start();
    }
    else{
      return UserHome();
    }
    
  }
}