import 'package:flutter/material.dart';

class TheorySubjects extends StatefulWidget {
  @override
  _TheorySubjectsState createState() => _TheorySubjectsState();
}

class _TheorySubjectsState extends State<TheorySubjects> {

  @override
  void initState() {
    print('init state theory');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('theory'),
    );
  }
}