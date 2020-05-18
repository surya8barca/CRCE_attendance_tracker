import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/auth/login.dart';
import 'package:crce_attendance_tracker/loading.dart';
import 'package:crce_attendance_tracker/user/status.dart';
import 'package:crce_attendance_tracker/user/practical.dart';
import 'package:crce_attendance_tracker/user/theory.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int index = 1;
  List pages = [TheorySubjects(), Status(), PracticalSubjects()];
  Map userdetails;

  Future<void> getUserDetails()async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    String uid = currentUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('Database').document(uid).get();
    setState(() {
      userdetails=result.data;
      print(userdetails);
    });
  }


  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(userdetails==null)
    {
      return Loading();
    }
    else{
    return SafeArea(
          child: Scaffold(
        drawer: Drawer(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('images/user6.png'),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        userdetails["name"],
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.blueAccent,
                thickness: 3,
              ),
              RaisedButton(
                onPressed: () {
                  Alert(
                    context: context,
                    style: AlertStyle(
                      backgroundColor: Colors.cyan,
                    ),
                    title: "Logout",
                    desc: "Are you sure you want to logout?",
                    buttons: [],
                    content: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            buttonColor: Colors.black,
                            child: RaisedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            buttonColor: Colors.black,
                            child: RaisedButton(
                              onPressed: ()async{
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                              },
                              child: Text(
                                'Yes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ).show();
                },
                color: Colors.blueAccent,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),

        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Attendance Tracker',
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.blue,
            ),
          ),
        ),
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.linearToEaseOut,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.black,
          index: 1,
          items: <Widget>[
            Icon(
              Icons.book,
              color: Colors.black,
              size: 40,
            ),
            Icon(
              Icons.home,
              color: Colors.black,
              size: 40,
            ),
            Icon(
              Icons.laptop_chromebook,
              color: Colors.black,
              size: 40,
            ),
          ],
          buttonBackgroundColor: Colors.blue,
          height: 60,
          color: Colors.blue,
        ),
      ),
    );
  }
  }
}
