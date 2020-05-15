import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {


  @override
  void initState() {
    print('init state display');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('User Home')
    );
  }
}