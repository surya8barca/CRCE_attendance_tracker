import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:crce_attendance_tracker/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TheorySubjects extends StatefulWidget {
  @override
  _TheorySubjectsState createState() => _TheorySubjectsState();
}

class _TheorySubjectsState extends State<TheorySubjects> {
  static String uid;
  bool dataloaded = false;
  QuerySnapshot alltheorysubjects;

  final snackbar = SnackBar(
    content: Text(
      'Lecture Added',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 1),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.blue,
        )),
  );

  Future<void> gettheorysubjects() async {
    await setuid();
    try {
      final CollectionReference theorysubjects =
          Firestore.instance.collection('${uid}_Theory Subjects');
      QuerySnapshot result = await theorysubjects.getDocuments();
      setState(() {
        alltheorysubjects = result;
      });
      for (int i = 0; i < result.documents.length; i++) {
        print(result.documents[i].data);
      }
      setState(() {
        dataloaded = true;
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> present(subjectdatamap) async {
    try {
      final CollectionReference theorysubjects =
          Firestore.instance.collection('${uid}_Theory Subjects');
      await theorysubjects
          .document(subjectdatamap["name_of_subject"])
          .updateData({
        "total_lectures": subjectdatamap["total_lectures"] + 1,
        "lectures_attended": subjectdatamap["lectures_attended"] + 1,
        "attendance": (((subjectdatamap["lectures_attended"] + 1) /
                (subjectdatamap["total_lectures"] + 1)) *
            100),
      });
      initState();
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> absent(subjectdatamap) async {
    try {
      final CollectionReference theorysubjects =
          Firestore.instance.collection('${uid}_Theory Subjects');
      await theorysubjects
          .document(subjectdatamap["name_of_subject"])
          .updateData({
        "total_lectures": subjectdatamap["total_lectures"] + 1,
        "lectures_attended": subjectdatamap["lectures_attended"],
        "attendance": (((subjectdatamap["lectures_attended"]) /
                (subjectdatamap["total_lectures"] + 1)) *
            100),
      });
      initState();
    } catch (e) {
      print(e.message);
    }
  }
  final userbox=Hive.box('currentuser');

  Future<void> setuid() async {
    try {
      if(userbox.length == 0)
      {
        FirebaseUser result = await FirebaseAuth.instance.currentUser();
        setState((){
          uid=result.uid;
        });  
      }
      else{
        final data =await userbox.getAt(0) as User;
        setState(() {
          uid=data.uid;
        });
      }
    } catch (e) {
      print(e.message);
    }
  }
  @override
  void initState() {
    gettheorysubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!dataloaded) {
      return BodyLoading();
    } else {
      return Builder(
          builder: (context) => SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
          
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Theory Subjects',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.yellow,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          for (int i = 0;
                              i < alltheorysubjects.documents.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          alltheorysubjects.documents[i]
                                              .data["name_of_subject"],
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Total Lectures: ${alltheorysubjects.documents[i].data["total_lectures"].toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Lectures Attended: ${alltheorysubjects.documents[i].data["lectures_attended"].toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          'Current Attendance',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '${alltheorysubjects.documents[i].data["attendance"].toStringAsPrecision(3)} %',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(10),
                                          color: Colors.cyan,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          onPressed: () async {
                                            await Alert(
                                              context: context,
                                              style: AlertStyle(
                                                backgroundColor: Colors.cyan,
                                              ),
                                              title: "Lecture Attendance",
                                              desc:
                                                  "Mark your attendance for this lecture",
                                              buttons: [],
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    ButtonTheme(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      buttonColor: Colors.black,
                                                      child: RaisedButton(
                                                        onPressed: () async {
                                                          await present(
                                                              alltheorysubjects
                                                                  .documents[i]
                                                                  .data);
                                                          Navigator.pop(
                                                              context);
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  snackbar);
                                                        },
                                                        child: Text(
                                                          'Present',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ButtonTheme(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      buttonColor: Colors.black,
                                                      child: RaisedButton(
                                                        onPressed: () async {
                                                          await absent(
                                                              alltheorysubjects
                                                                  .documents[i]
                                                                  .data);
                                                          Navigator.pop(
                                                              context);
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  snackbar);
                                                        },
                                                        child: Text(
                                                          'Absent',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                          child: Text(
                                            'Add Lecture',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(height: 150,)
                    ],
                  ),
                ),
              ));
    }
  }
}
