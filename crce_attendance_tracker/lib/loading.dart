import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Attendance Tracker',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Loading Data',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.red),
            ),
            SizedBox(
              height: 15,
            ),
            SpinKitPouringHourglass(
              color: Colors.blue,
              size: 125,
            ),
          ],
        ),
      ),
    );
  }
}
