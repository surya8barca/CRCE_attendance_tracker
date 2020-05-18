import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BodyLoading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<BodyLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitDualRing(
                color: Colors.blue,
                size: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
