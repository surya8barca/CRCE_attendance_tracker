import 'package:flutter/material.dart';

class PracticalSubjects extends StatefulWidget {
  @override
  _PracticalSubjectsState createState() => _PracticalSubjectsState();
}

class _PracticalSubjectsState extends State<PracticalSubjects> {

  @override
  void initState() {
    print('init state pracs');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Text('practical'),
    );
  }
}