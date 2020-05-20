import 'package:crce_attendance_tracker/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:crce_attendance_tracker/user/userhome.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userbox = Hive.box('currentuser');
  @override
  Widget build(BuildContext context) {
    if(userbox.length==0)
    {
      return Login();
    }
    else{
      return UserHome();
    }
  }
}