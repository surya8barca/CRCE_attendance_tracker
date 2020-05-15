import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/loading.dart';
import 'package:crce_attendance_tracker/user/display.dart';
import 'package:crce_attendance_tracker/user/practical.dart';
import 'package:crce_attendance_tracker/user/theory.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  DocumentSnapshot userdetails;

  Future<void> getuserdetails() async {
    
    try{
      final CollectionReference userdata = Firestore.instance.collection('Database');
      DocumentSnapshot result = await userdata.document('User Details').get(); 
      setState((){
      userdetails= result;
      print(userdetails.data);
    });
    await gettheorysubjects();
    await getpracticalsubjects();
    }
    catch(e)
    {
      print(e.message);
    }
  }

  Future<void> gettheorysubjects() async{
    try{
      final CollectionReference theorysubjects = Firestore.instance.collection('Theory Subjects');
      QuerySnapshot alltheorysubjects = await theorysubjects.getDocuments();
      for(int i = 0;i< alltheorysubjects.documents.length;i++)
      {
        print(alltheorysubjects.documents[i].data);
      }
    }
    catch(e)
    {
      print(e.message);
    }
  }

  Future<void> getpracticalsubjects() async{
    try{
      final CollectionReference practicalsubjects = Firestore.instance.collection('Practical Subjects');
      QuerySnapshot allpracticalsubjects = await practicalsubjects.getDocuments();
      for(int i = 0;i< allpracticalsubjects.documents.length;i++)
      {
        print(allpracticalsubjects.documents[i].data);
      }
      
    }
    catch(e)
    {
      print(e.message);
    }
  }

  int index=0;
  List pages=[
    Display(),
    TheorySubjects(),
    PracticalSubjects()

  ];

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
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.bounceOut,
          onTap: (value) {
            print(index);
            setState(() {
              index=value;
              print(index);
            });
          },
          items:<Widget> [
            Icon(Icons.home,color: Colors.white,),
            Icon(Icons.book,color: Colors.white,),
            Icon(Icons.laptop_chromebook,color: Colors.white,),
          ],
          height: 70,
          buttonBackgroundColor: Colors.blue,
          color: Colors.black,
          ),
      );
    }
  }
}