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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please Wait',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.yellow),
              ),
              SizedBox(height: 5,),
              Text(
                'Loading Database',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.yellow),
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
      ),
    );
  }
}
